# Exploratory Data Analysis Course Project - Week 1
## Project Description
#########################################################################################################################################
### This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. In particular, 
### we will be using the "Individual household electric power consumption Data Set" which I have made available on the course web site:
### * Dataset: Electric power consumption [20Mb]
### * Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different 
###                electrical quantities and some sub-metering values are available.

### The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
### 1. Date: Date in format dd/mm/yyyy
### 2. Time: time in format hh:mm:ss
### 3. Global_active_power: household global minute-averaged active power (in kilowatt)
### 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
### 5. Voltage: minute-averaged voltage (in volt)
### 6. Global_intensity: household global minute-averaged current intensity (in ampere)
### 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, 
###    an oven and a microwave (hot plates are not electric but gas powered).
### 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, 
###    a tumble-drier, a refrigerator and a light.
### 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

## Review Criteria:
#########################################################################################################################################
### 1. Was a valid GitHub URL containing a git repository submitted?
### 2. Does the GitHub repository contain at least one commit beyond the original fork?
### 3. Please examine the plot files in the GitHub repository. Do the plot files appear to be of the correct graphics file format?
### 4. Does each plot appear correct?
### 5. Does each set of R code appear to create the reference plot?

## Loading the data
#########################################################################################################################################
### When loading the dataset into R, please consider the following:
### * The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before 
###   reading into R. Make sure your computer has enough memory (most modern computers should be fine).
### * We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than 
###   reading in the entire dataset and subsetting to those dates.
### * You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime()  and as.Date() functions.
### * Note that in this dataset missing values are coded as ?.

## Making Plots
#########################################################################################################################################
### Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. Your task is to reconstruct 
### the following plots below, all of which were constructed using the base plotting system.

### First you will need to fork and clone the following GitHub repository: https://github.com/rdpeng/ExData_Plotting1

### For each plot you should
### * Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
### * Name each of the plot files as plot1.png, plot2.png, etc.
### * Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. 
###   Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the 
###   PNG file.
### * Add the PNG file and R code file to the top-level folder of your git repository (no need for separate sub-folders)

### When you are finished with the assignment, push your git repository to GitHub so that the GitHub version of your repository is up to date. There 
### should be four PNG files and four R code files, a total of eight files in the top-level folder of the repo.
#########################################################################################################################################


# Clearing varibles before program execution.
rm(list = ls())

# User-defined Variables that define desired working directory and date of download.
cwdir <- "C:/Users/mkee1/Documents/Coursera-JH-Data-Science/04_Exploratory_Data_Analysis/Week 1/Peer Review Projects/ExData_Plotting1/"
filename <- "Raw Data"
dateDownloaded <- date()

# User-defined variables to assist with downloading the data files for analysis.
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destDL <- "./Electric_Power_Consumption.zip"

# Setting working directory using user-defined function "setdesiredwd".
source("setdesiredwd.R")
setdesiredwd(cwdir)

# Checking to see if file exist desired working directory. If not, then one is created. 
if (!file.exists(filename)) {dir.create(filename)}
list.files()

# Downloading files of interest & extracting data from the zip file under desired working directory.
if (!file.exists("Electric_Power_Consumption.zip")) 
{
        download.file(fileURL, destfile = destDL)
        print(dateDownloaded)
        unzip("Electric_Power_Consumption.zip", exdir = "./Raw Data")
}
list.files("Raw Data")

# Reading headers & data into R & using the str() function to view.
headers <- read.table("./Raw Data/household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, nrows = 1 )
dt0 <- read.table("./Raw Data/household_power_consumption.txt", sep = ";", as.is = TRUE, skip = 66637, nrows = 2880, na.strings = c("?","","NA"," "))
names(dt0)<- headers
str(dt0)

# Checking to see if there is data missing from this subset. If there is missing data, then it will be omitted.
chk4NAs <- sum(is.na.data.frame(dt0))
if (chk4NAs == 0) 
{print("There are no missing values")} else 
{sprintf("The number of missing values is: %i", chk4NAs)}

# PNG Plot 2: Time-series Line Graph of Global Active Power (kilowatts) With Respect To Day
DateTimeVect <- with(dt0, as.POSIXlt(paste(dt0$Date, dt0$Time), format ="%d/%m/%Y %H:%M:%S")) #Coercing date-time data from character to POSIXlt date-time format

png("plot2.png",width = 480,height = 480) #Launching PNG graphic device

plot(DateTimeVect,dt0$Global_active_power,type = "l",xlab = "", ylab = "Global Active Power (kilowatts)") #Creating the line graph according to specification

dev.off() #Closing graphic device

#End-PS0723