using DataFrames
using CSV
using Statistics
using Measurements

function remove_outliers(df, cols)
    if length(df[!, "neutral_fall_seconds"]) == 1
        return df
    end

    filtered_df = df  # Create a copy of df
    for col in cols
        μ = mean(filtered_df[!, col])  # Compute mean
        σ = std(filtered_df[!, col])   # Compute standard deviation
        filtered_df = filter(row -> abs(row[col] - μ) ≤ σ, filtered_df)  # Keep rows within 1 std dev
    end
    return filtered_df
end

# Load data from CSV files into a vector of DataFrames, removing outliers
data::Vector{DataFrame} = DataFrame.(CSV.File.(readdir("raw_data/", join=true)))
data = [remove_outliers(df, [:neutral_fall_seconds, :charged_rise_seconds]) for df in data]

# Compute charges with uncertainty
charges = map(data) do df
    vf = 0.5e-3 / mean(df.neutral_fall_seconds)
    vr = 0.5e-3 / mean(df.charged_rise_seconds)

    voltage_error = round(mean(df.voltage_V) .* 0.0009 .+ 0.2, sigdigits=1)
    V = mean(df.voltage_V) ± voltage_error
    d = mean(df.d) ± 0.001
    E = V / d

    p = mean(df.p) ± 1000
    
    a = @. sqrt((df.b / (2*p))^2 + (9 * df.eta * vf) / (2 * df.g * df.rho)) - df.b / (2df.p)
    m = (4/3) * π * mean(a)^3 * mean(df.rho)
    q = m * mean(df.g) * (vf + vr) / (E * vf)

    return q
end

real_charge::Float64 = 1.602e-19
number_of_measurements = length.(getproperty.(data, :neutral_fall_seconds))

# Extract values and uncertainties
charge_values = Measurements.value.(charges)  # Extract central values (nominal charge)
normalized_charge = charge_values ./ minimum(charge_values)
systematic_uncertainties = Measurements.uncertainty.(charges)  # Extract propagated systematic uncertainties
statistical_uncertainties = (charge_values ./ normalized_charge) ./ sqrt.(number_of_measurements)  # Statistical part
z_scores = (charge_values ./ normalized_charge .- real_charge) ./ sqrt.(statistical_uncertainties.^2 + systematic_uncertainties.^2)
chi_squared = sum(z_scores .^ 2)

# Generate droplet labels: "A", "B", "C", ..., "Z", "AA", "AB", etc.
droplet_labels = [
    string(Char(65 + (i - 1) % 26)) * (i > 26 ? string(Char(65 + (i - 1) ÷ 26)) : "")
    for i in 1:length(charges)
]

# Display results including systematic and statistical uncertainties separately
df_results::DataFrame = DataFrame(zip(
    droplet_labels,
    round.(charge_values, sigdigits=4),  # Charge in Coulombs
    round.(normalized_charge, sigdigits=4),  # Number of charges per droplet
    round.(statistical_uncertainties, sigdigits=4),  # Statistical Uncertainty
    round.(systematic_uncertainties, sigdigits=4),  # Systematic Uncertainty
    round.(z_scores, sigdigits=4)  # Z-Score
))

colnames = [
    "",
    "Charge (C)",
    "# Charges",
    "Statistical Uncertainty",
    "Systematic Uncertainty",
    "Z-Score"
]

rename!(df_results, Symbol.(colnames))
println(df_results)
println("\nΧ² = $chi_squared")

# Plotting with uncertainties
using Plots

# Plot with xerr for uncertainty in number of charges and yerr for uncertainty in charge
scatter(normalized_charge, Measurements.value.(charges), 
        yerr=Measurements.uncertainty.(charges), 
        xerr=statistical_uncertainties ./ normalized_charge,  # Uncertainty for normalized charges
        xlabel="Number of Charges", 
        ylabel="Charge (C)",
        label="Measured Charges",
        title="Number of Charges vs Charge (including uncertainty)",
        legend=:topright)

savefig("output_plot.png")  # Save the plot as a PNG image
