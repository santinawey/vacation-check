/**********************************
Librefs
 **********************************/
/*  Start CAS Session */
cas mysession sessopts=(caslib=casuser timeout=1800 locale="en_US");

/* Create librefs for */
libname public cas caslib=public;
CASLIB _ALL_ ASSIGN;
libname dc "/mnt/nfs/data/Dashboard Challenge/Tables";

/**********************************
Import Data Sets
 **********************************/
/* Import Weather Data Set with ISO_Codes*/
PROC IMPORT DATAFILE='/mnt/nfs/data/Dashboard Challenge/Data/weather_iso.xlsx' 
		DBMS=XLSX OUT=dc.weather_iso;
	GETNAMES=YES;
RUN;

/* Import Weather Data Set with ISO_Codes*/
PROC IMPORT DATAFILE='/mnt/nfs/data/Dashboard Challenge/Data/rainfall.xlsx' 
		DBMS=XLSX OUT=dc.rainfall;
	GETNAMES=YES;
RUN;

/**********************************
Cleaning
 **********************************/
/* Format weather_iso data */
data dc.weather_iso_format;
	format date date.
		name $char70.
		city $char50.
		latitude comma8.6 longitude comma8.6 tavg comma8.1 tmin comma8.1 tmax 
		comma8.1 wdir comma8.
		wspd comma8.1 pres comma8.1;
	set dc.weather_iso;
run;

/* Characterize data*/
PROC CONTENTS DATA=dc.weather_iso_format;
RUN;

PROC MEANS DATA=dc.weather_iso_format;
RUN;

/* Delete temperatures above 56.7 from the tmax column*/
DATA dc.weather_iso_no_extrems;
	SET dc.weather_iso_format;

	IF tmax <=56.7;
RUN;

/*check if extrems are deleted*/
PROC MEANS DATA=dc.weather_iso_no_extrems;
RUN;

/* Check for Missings*/
/* missing data explored via task; s. "Missing Data.ctk*/
/*delete missing values from the data set
data dc.weather_iso_no_missings;
set dc.weather_iso_no_extrems;

if cmiss(of _all_) then
delete;
run;*/
/* check if data set dc.weather_iso_no_missings is without any missing values;
s. Missing Data Check.ctk;
no more missing values*/

/**********************************
Clean Countries
 **********************************/
/*change country names*/
data dc.weather_iso_country_clean;
	set dc.weather_iso_no_extrems;

	if name="Aland Islands" then
		name="Åland Islands";

	if name="Abkhazia" then
		name="Georgia";

	if name="British Virgin Islands" then
		name="Virgin Islands (British)";

	if name="Brunei" then
		name="Brunei Darussalam";

	if name="Cape Verde" then
		name="Cabo Verde";

	if name="Congo (DRC)" then
		name="Congo, Democratic Republic of the";

	if name="Congo (Republic)" then
		name="Congo";

	if name="Czech Republic" then
		name="Czechia";

	if name="Falkland Islands (Islas Malvinas)" then
		name="Falkland Islands (Malvinas)";

	if name="Laos" then
		name="Lao People's Democratic Republic";

	if name="Macau" then
		name="Macao";

	if name="Macedonia (FYROM)" then
		name="North Macedonia";

	if name="Moldova" then
		name="Moldova, Republic of";

	if name="Myanmar (Burma)" then
		name="Myanmar";

	if name="North Korea" then
		name="Korea (Democratic People's Republic of)";

	if name="North Cyprus" then
		name="Cyprus";

	if name="Northern Cyprus" then
		name="Cyprus";

	if name="Palestine" then
		name="Palestine, State of";

	if name="Pitcairn Islands" then
		name="Pitcairn";

	if name="Russia" then
		name="Russian Federation";

	if name="São Tomé and Príncipe" then
		name="Sao Tome and Principe";

	if name="South Georgia and the South Sandw" then
		name="South Georgia and the South Sandwich Islands";

	if name="South Korea" then
		name="Korea, Republic of";

	if name="St. Barthélemy" then
		name="Saint Barthélemy";

	if name="St. Kitts and Nevis" then
		name="Saint Kitts and Nevis";

	if name="St. Lucia" then
		name="Saint Lucia";

	if name="St. Martin" then
		name="Saint Martin (French part)";

	if name="Taiwan" then
		name="Taiwan, Province of China";

	if name="Transnistria" then
		name="Moldova, Republic of";

	if name="Tristan da Cunha" then
		name="Saint Helena, Ascension and Tristan da Cunha";

	if name="U.S. Virgin Islands" then
		name="Virgin Islands (U.S.)";

	if name="United Kingdom" then
		name="United Kingdom of Great Britain and Northern Ireland";

	if name="United States" then
		name="United States of America";

	if name="Vatican City" then
		name="Holy See";

	if name="Vietnam" then
		name="Viet Nam";

	if name="Venezuela" then
		name="Venezuela (Bolivarian Republic of)";

	if name="Micronesia" then
		name="Micronesia (Federated States of)";

	if name="Netherlands Antilles" then
		name="Curaçao";
run;

/*check the countries*/
PROC FREQ DATA=dc.weather_iso_country_clean;
	TABLES name / NOPRINT OUT=unique_countries;
RUN;

PROC PRINT DATA=unique_countries;
	VAR name;
RUN;

/**********************************
Join ISO Codes to Weather Data
 **********************************/
/*Join Weather Data Set and ISO_Codes*/
/* Joining and selecting columns */
proc sql;
    create table dc.weather_iso_rainfall as
    select t1.*, t2.* from dc.weather_iso_country_clean as t1
    inner join dc.rainfall as t2
    on t1.ISO2 = t2.ISO2;
 quit;
 
/*Upload data from work library to CAS*/
proc casutil;
	load data=dc.weather_iso_rainfall outcaslib="public" 
		casout="daily_weather";
run;

/*Promote data in CAS*/
proc casutil;
	promote casdata="daily_weather" incaslib="public" casout="daily_weather_data" 
		outcaslib="public" drop;
run;
