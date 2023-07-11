# Vacation Check
Here is the SAS code utilized to clean and preprocess the dataset for the "Vacation Destination Check" web application. This project involves data cleaning, data integration, and analysis using SAS. 
It includes importing datasets, cleaning data, transforming variables, and joining tables to create a consolidated dataset for further analysis. 
For more detailed information, please visit my website at santinawey.com/vacation-destination-check.

## Prerequisites

To run this project, you need to have the following software and resources installed:

- SAS software [Viya 4]
- Download the required data files 
- Access to a SAS environment or SAS Studio

## Getting Started

1. Clone the repository: `git clone [repository URL]`
2. Open SAS or SAS Studio and navigate to the project directory.
3. Update the libref paths in the code to match the location of your data files. Modify the following lines accordingly:

```sas
/* Set library references */
libname public cas caslib=public;
libname dc "/mnt/nfs/data/Dashboard Challenge/Tables";
```

4. Run each section of the code in sequence to import, clean, and integrate the datasets.
5. Review the log and output windows for any error messages or warnings. Make sure the code runs without any issues.

## Cleaning Data

The code includes various data cleaning steps to ensure the quality of the data. It covers tasks such as:

- Formatting variables
- Deleting extreme values
- Handling missing values
- Cleaning country names

Review the code comments to understand each step in the data cleaning process.

## Joining Data

The code also demonstrates joining two datasets using SQL. It joins the "weather_iso_country_clean" dataset with the "rainfall" dataset based on a common variable, "ISO2".

## Uploading Data to CAS

After joining and selecting the desired columns, the resulting dataset, "daily_weather_data", is uploaded to the CAS server using the CASLIB "public". This step allows for further analysis and processing in a distributed environment.

## Author
Santina Wey
