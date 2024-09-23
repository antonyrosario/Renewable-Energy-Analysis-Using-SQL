/*
CREATED BY: ANTONY ROSARIO JOHN PETER
CREATED ON: 07/09/2024
*/

--QUERY 1: DISPLAY ALL THE TABLES

SELECT *
FROM CountryEnergyAccess
ORDER BY 'Country Name';

SELECT *
FROM EnergyProductionConsumption
ORDER BY 'Country Name';

SELECT *
FROM EnvironmentalEconomicData
ORDER BY 'Country Name';


--QUERY 2: TOP 10 COUNTRIES WITH HIGHEST RENEWABLE ENERGY PRODUCTION

SELECT
    [Country Name],
    Year,
    ROUND(MAX("Electricity production from renewable sources, excluding hydroelectric (% of total)"), 2) AS Renewable_Electricity_Percent
FROM 
    EnergyProductionConsumption
GROUP BY 
    [Country Name]
ORDER BY 
    Renewable_Electricity_Percent DESC
LIMIT 10;


--QUERY 3: AVERAGE ACCESS TO ELECTRICITY RURAL VS URBAN

SELECT 
    Year,
    ROUND(AVG("Access to electricity, rural (% of rural population)"), 2) AS Avg_Rural_Electricity_Access,
    ROUND(AVG("Access to electricity, urban (% of urban population)"), 2) AS Avg_Urban_Electricity_Access
FROM 
    CountryEnergyAccess
WHERE
    Year IS NOT 2023
GROUP BY 
    Year
ORDER BY 
    Year DESC;

	
--Query 4: Total CO2 Emissions by Year (liquid fuel vs gaseous fuel)
SELECT 
    Year,
    round(SUM("CO2 emissions from liquid fuel consumption (kt)"),2) AS Total_Liquid_Fuel_Emissions,
    round(SUM("CO2 emissions from gaseous fuel consumption (% of total)"),2) AS Total_Gaseous_Fuel_Emissions
FROM 
    EnvironmentalEconomicData
GROUP BY 
    Year
ORDER BY 
    Year;
	
--Query 5: Correlation Between GDP and Energy Use

SELECT 
    ed.[Country Name], 
    ed.Year,
    ed."GDP per unit of energy use (constant 2021 PPP $ per kg of oil equivalent)" AS GDP_Per_Unit_Energy,
    ed."Energy use (kg of oil equivalent per capita)" AS Energy_Use_Per_Capita
FROM 
    EnvironmentalEconomicData ed
WHERE 
    ed."Energy use (kg of oil equivalent per capita)" IS NOT '0'
ORDER BY 
    'Country Name', Year DESC, GDP_Per_Unit_Energy DESC;

--QUERY 6: Countries with the Highest Fossil Fuel Energy Consumption

SELECT 
    [Country Name],
    Year,
    "Fossil fuel energy consumption (% of total)" AS Fossil_Fuel_Consumption_Percent
FROM 
    EnvironmentalEconomicData
WHERE 
    "Fossil fuel energy consumption (% of total)" IS NOT '0'
ORDER BY 
	Year DESC, Fossil_Fuel_Consumption_Percent DESC
LIMIT 10;

-- QUERY 7: Countries with Most Efficient Electric Power Transmission

SELECT 
    "Country Name",
    Year,
    "Electric power transmission and distribution losses (% of output)" AS Transmission_Losses_Percent
FROM 
    EnergyProductionConsumption
WHERE
	"Electric power transmission and distribution losses (% of output)" IS NOT 0
ORDER BY 
    Year DESC, Transmission_Losses_Percent ASC
LIMIT 10;

-- QUERY 8: Energy Use vs. Renewable Energy Consumption

SELECT 
    ce."Country Name", 
    ee."Energy use (kg of oil equivalent per capita)" AS Total_Energy_Use_Per_Capita,
    ep."Renewable energy consumption (% of total final energy consumption)" AS Renewable_Energy_Consumption
FROM 
    CountryEnergyAccess ce
JOIN 
    EnergyProductionConsumption ep 
    ON ce.[Country Name] = ep.[Country Name] AND ce.Year = ep.Year
JOIN
	EnvironmentalEconomicData ee
	ON ce.[Country Name] = ee.[Country Name] AND ce.Year = ee.Year
WHERE 
    ep."Renewable energy consumption (% of total final energy consumption)" IS NOT 0
ORDER BY 
    Renewable_Energy_Consumption DESC;


-- QUERY 9: Yearly CO2 Emissions from Different Fuel Sources for specific countries

SELECT 
    Year,
    "CO2 emissions from liquid fuel consumption (kt)" AS Liquid_Fuel_Emissions,
    "CO2 emissions from gaseous fuel consumption (% of total)" AS Gaseous_Fuel_Emissions
FROM 
    EnvironmentalEconomicData
WHERE 
    [Country Name] = 'Australia'  -- Replace country names
ORDER BY 
    Year;

-- QUERY 10: Average Electric power consumption across the world

SELECT 
	[Country Name],
    Round(AVG(ep."Electric power consumption (kWh per capita)"),2) AS Avg_Global_Power_Consumption
FROM 
    EnergyProductionConsumption ep
WHERE 
    ep."Electric power consumption (kWh per capita)" IS NOT '0'
GROUP BY
	[Country Name];
	



