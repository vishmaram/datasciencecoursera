communityDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(url=communityDataUrl,destfile = "data/communityData.csv",method="libcurl")

DT <- fread("data/communityData.csv")
head(DT)
codeBookUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"

download.file(url=codeBookUrl,destfile = "data/communityDataCodeBook.pdf",method="libcurl")

communityData <- read.csv("data/communityData.csv")

head(communityData)

nrow(communityData[communityData$VAL==24 & !is.na(communityData$VAL),])

communitydf <- tbl_df(communityData)

library(dplyr)
select(communitydf,FES)

naturalGasDataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

download.file(url=naturalGasDataURL,destfile = "data/naturalGasData.xlsx",method="libcurl")

library(xlsx)
dat <- naturalGasData <- read.xlsx("data/naturalGasData.xlsx", sheetIndex = 1,rowIndex = 18:23,colIndex = 7:15)

sum(dat$Zip*dat$Ext,na.rm=T)

restDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(url=restDataUrl,"data/RestaurantData.xml",method="libcurl")

library(XML)

doc <- xmlTreeParse(file="data/RestaurantData.xml",useInternalNodes = TRUE)

rootNode <- xmlRoot(doc)

doc2 <- xpathSApply(rootNode,"//zipcode",xmlValue)
head(doc2)

length(doc2[doc2==21231])
