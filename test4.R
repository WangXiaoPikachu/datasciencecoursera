Q1Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(Q1Url) 
Q1 <- read.csv(Q1Url)
Q1_colnames <- names(Q1)
strsplit(Q1_colnames, "^wgtp")[[123]]
####q2
Q2_Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
Q2_Path <- "/home/cabunic/Data Science/Coursera/3 - Getting and Cleaning Data/Week 4/Q3GDP.csv"
download.file(Q2_Url, Q2_Path, method = "curl")
Q2_File <- read.csv(Q2_Path, nrow = 190, skip = 4)
Q2_File <- Q2_File[,c(1, 2, 4, 5)]
colnames(Q2_File) <- c("CountryCode", "Rank", "Country", "Total")
Q2_File
Q2_File$Total <- as.integer(gsub(",", "", Q2_File$Total))
mean(Q2_File$Total, na.rm = T)
####q3
Q2_File$Country <- as.character(Q2_File$Country)
Q2_File$Country[99] <- "C??te d¡¯Ivoire"
Q2_File$Country[186] <- "S??o Tom¨¦ and Pr¨ªncipe"
Q2_File$Country[grep("^United", Q2_File$Country)]
#####q4
library(data.table)
Q4GDP_Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
Q4GDP_Path <- "/home/cabunic/Data Science/Coursera/3 - Getting and Cleaning Data/Week 3/Q3GDP.csv"
Q4Edu_Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
Q4Edu_Path <- "/home/cabunic/Data Science/Coursera/3 - Getting and Cleaning Data/Week 3/Q3Edu.csv"

download.file(Q4GDP_Url, Q4GDP_Path, method = "curl")
download.file(Q4Edu_Url, Q4Edu_Path, method = "curl")
Q4GDP <- fread(Q4GDP_Path, skip = 5, nrows = 190, select = c(1, 2, 4, 5), col.names = c("CountryCode", "Rank", "Economy", "Total"))
Q4Edu <- fread(Q4Edu_Path)
Q4_Merge <- merge(Q4GDP, Q4Edu, by = 'CountryCode')
Q4_Merge
FiscalJune <- grep("Fiscal year end: June", Q4_Merge$`Special Notes`)
NROW(FiscalJune)
###q5
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN", auto.assign=FALSE)
sampleTimes = index(amzn)
amzn2012 <- sampleTimes[grep("^2012", sampleTimes)]
NROW(amzn2012)
NROW(amzn2012[weekdays(amzn2012) == "Monday"])
