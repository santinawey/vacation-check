# Vacation Check

**Vacation Check** is a fun and interactive web application designed to help you decide where your next holiday should be—based on the weather you prefer! Built using SAS, this project explores new functionalities in **SAS Visual Analytics** and demonstrates how data cleaning, integration, and analysis can support decision-making in a playful and practical way.

This repository contains the SAS code used to clean and preprocess the dataset for the Vacation Destination Check web application. The project includes:

- Importing datasets
- Cleaning and transforming variables
- Joining tables
- Uploading data to CAS for analysis

The final dataset powers a web app that visualizes weather data across countries, helping users find destinations that match their ideal climate.

---

## ⚙️ Prerequisites

To run this project, you’ll need:

- **SAS Viya 4** or access to **SAS Studio**
- Downloaded data files (see `data/` folder)
- Configured CAS environment

---

## 🚀 Getting Started

1. Clone the repository: `git clone [repository URL]`
2. Open SAS or SAS Studio and navigate to the project directory.
3. Update the libref paths in the code to match the location of your data files. Modify the following lines accordingly:

```sas
/* Set library references */
libname public cas caslib=public;
libname dc "data/Dashboard Challenge/Tables";
```

4. Run each section of the code in sequence to import, clean, and integrate the datasets.
5. Review the log and output windows for any error messages or warnings. Make sure the code runs without any issues.

## 🧹 Cleaning Data

The code includes various data cleaning steps to ensure the quality of the data. It covers tasks such as:

- Formatting variables
- Deleting extreme values
- Handling missing values
- Cleaning country names

Review the code comments to understand each step in the data cleaning process.

## 🔗 Joining Data

The code also demonstrates joining two datasets using SQL. It joins the "weather_iso_country_clean" dataset with the "rainfall" dataset based on a common variable, "ISO2".

## ☁️ Uploading Data to CAS

After joining and selecting the desired columns, the resulting dataset, "daily_weather_data", is uploaded to the CAS server using the CASLIB "public". This step allows for further analysis and processing in a distributed environment.
