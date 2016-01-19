# Objective of the course
# Finding and Extracting Data
# tidy data principles
# Practical Implementation through a range of R programs

# Raw Data, Processed data, code book (meta data), steps to get from raw data to processed data

#relative path
# cd .. command will take to one directory up
# cd ../folder2 command will take one directory up and to folder 2 in that parent folder

#set working directory

setwd("./gettingAndCleaningData")

getwd()

file.exists("folderName")

dir.create("data")

file.exists("data")

#downloading a file from URL

fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

?download.file

# method to download a single file. Because link has https we need to set the method as curl
# In windows default default method  should be sufficient to download

## if method auto, libcurl will be used for https:// and ftps:// URL provided  
#capabilities ("libcurl") is true
## curl and wget methods will block all the other activities on the R process until 
#they are complete

## libcurl and wget methods follow http:// and https:// redirections, but the "internal"
#method does not

download.file(url=fileURL,destfile = "data/camera.CSV", method="curl")


list.files("./data")

dateDownloaded <- date()

# to get list of all packages
installed.packages()

?installed.packages

# find packages
find.package("curl")

?find.package


# reading data

cameraData <-read.csv("data/camera.CSV")

camearaData <- read.table("data/camera.CSV",sep=",", header=TRUE)

# important params in read. table
# quote = ""
# na.string to set the character that has missing values
# nrows
# skip number of lines to skip

?read.table

# Excel files

if(!file.exists("data")){dir.create("data")}
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(url=fileURL,destfile = "data/camerasExcel.xlsx", method="curl")


# R libraries for reading excel is xlsx package
find.package("xlsx")
# xlsx was not present so install the package
install.packages("xlsx")

library(xlsx)
cameraData <- read.xlsx("./data/camerasExcel.xlsx",sheetIndex=1, header=TRUE)


# to read specic rows and specific columns
rowIndex <- 3:4
colIndex <- 1:5
cameraData <- read.xlsx("data/camerasExcel.xlsx", sheetIndex=1, rowIndex = rowIndex, colIndex = colIndex)

# write.xlsx can be used to write out and excel with arguments
# read.xlsx2() is much faster than read.xlsx() but when reading subsets it might be unstable

# XLConnect package has more options for writing and manipulating Excel files
# XLConnect Vignette is a good place to start for the same

############Reading XML

find.package("xml")
install.packages("XML")

library(XML)
fileURL <- "http://www.w3schools.com/xml/simple.xml"
download.file(url=fileURL, destfile ="data/simple.xml", method="curl" )
?xmlTreeParse

doc <- xmlTreeParse(file="data/simple.xml", useInternalNodes = TRUE)
# user Internal Nodes = TRUE is needed is required for xpath to use nodeset
# or can directly assign to object from fileURL

doc <- xmlTreeParse(file=fileURL, useInternalNodes = TRUE)

rootNode <- xmlRoot(doc) # will give acutal tags portion of the xml

xmlName(rootNode) # will give the top tag of the xml

names(rootNode) # give sub nodes of the main root node

# XML is similar to a list containing a set of lists and below
# in simple of xml breakfast_menu is a list containing lists of food

# to access first item in the list you can use below similar to list
rootNode[[1]]

# to access first element of the first list in the main list you have to do one more subset
rootNode[[1]][[1]]

#looping over programatically
?xmlSApply
xmlSApply(rootNode,xmlValue)
xmlApply(rootNode[[1]], xmlAttrs)

xmlSApply(rootNode[[1]], xmlSize)

## XPath language is use to access the XML file
# below leture is useful
# /node  --> to get top level node
# //node --> to get ndoe any level
# node[@attr-name] --> Node with attribute name
# node[@attr-name='bob'] --> Node with attribute name bob

# to get all the nodes with node name 
xpathSApply(rootNode,"//name",xmlValue)

# to get all the values with the node name as price
xpathSApply(rootNode,"//price",xmlValue)

fileURL <- "http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf"
download.file(url=fileURL, "data/XPath-XML.pdf", method="libcurl")

### html parsing 
fileURL <- "http://www.99acres.com/search/property/buy/residential-all/nanakramguda-hyderabad?search_type=QS&search_location=CP38&lstAcn=CP_R&lstAcnId=38&src=CLUSTER&preference=S&selected_tab=1&city=269&res_com=R&property_type=R&isvoicesearch=N&keyword_suggest=nanakramguda%2C%20hyderabad%3Bmanikonda%2C%20hyderabad%3Bgachibowli%2C%20hyderabad%3B&fullSelectedSuggestions=nanakramguda%2C%20hyderabad%3Bmanikonda%2C%20hyderabad%3Bgachibowli%2C%20hyderabad&strEntityMap=W3sidHlwZSI6ImxvY2FsaXR5In0seyIxIjpbIm5hbmFrcmFtZ3VkYSwgaHlkZXJhYmFkIiwiQ0lUWV8yNjksIExPQ0FMSVRZXzg3MiwgUFJFRkVSRU5DRV9TLCBSRVNDT01fUiJdfSx7IjIiOlsibWFuaWtvbmRhLCBoeWRlcmFiYWQiLCJDSVRZXzI2OSwgTE9DQUxJVFlfODA0NSwgUFJFRkVSRU5DRV9TLCBSRVNDT01fUiJdfSx7IjMiOlsiZ2FjaGlib3dsaSwgaHlkZXJhYmFkIiwiQ0lUWV8yNjksIExPQ0FMSVRZXzUxMzYsIFBSRUZFUkVOQ0VfUywgUkVTQ09NX1IiXX1d&texttypedtillsuggestion=nanakram&refine_results=Y&Refine_Localities=Refine%20Localities&action=%2Fdo%2Fquicksearch%2Fsearch&suggestion=CITY_269%2C%20LOCALITY_872%2C%20PREFERENCE_S%2C%20RESCOM_R&searchform=1&locality=8045%2C5136%2C872&price_min=null&price_max=null"

doc <- htmlTreeParse(file =  fileURL,useInternalNodes =  TRUE)

projList <- xpathSApply(doc,"//div[@class='lf f13 hm10 mb5']",xmlValue)
costList <- xpathSApply(doc, "//div[@class='srpDataWrap']",xmlValue)

# xml package document short version
fileURL <- "http://www.omegahat.org/RSXML/shortIntro.pdf"
download.file(url=fileURL, "data/shortXMLPackageIntro.pdf",method="libcurl")

## Reading JSON
find.package("jsonlite")

library(jsonlite)

# from JSON method will return a dataframe. an obervation can be a dataframe within dataframe
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
jsonData <- fromJSON("data/sampleJSON.txt")

names(jsonData)
names(jsonData$glossary)
names(jsonData$glossary$GlossDiv$GlossList$GlossEntry)

#converting dataframe to JSON
jsonvar <- toJSON(jsonData)

jsonvar

# data.table instead of data.frame
# data.table inherits same properties as data.frame
# It is written in C and is much faster
# much faster at subsetting and updating

install.packages("data.table")

library(data.table)
?data.table

# data frame
DF <- data.frame(x=c("c","b","a","z","d"), y=rnorm(5))
DF

# data table is created exactly in the same fashion as data frame
DT <- data.table(x=c("c","b","a","z","d"), y=rnorm(5))
DT

# can convert data.frame to data table easily

DF_DT <- data.table(DF)
DF

# to see list of tables
tables()

sapply(DT, class)

# Rows will be ordered based on the key.
# Key can have one or more column and there can only be one key

DT[2,]  # to select row 2

DT[x=="b", ] # to select row with x == b

DT$x

# since there are no row names the following does not work
cat(try(DT["b",],silent = TRUE)) 

setkey(DT,x)

# notice when we print DT the rows are ordered based on key
DT

# Now when we print tables() key will be shown
tables()

# Now DT has a key let's try below and this time it will work
DT["b",]

# Also comma is optional
DT["b"]

# the mult argument allow to fetch first or last row of the subset if here are two rows with 
# x value as b
DT["b", mult="first"]

grpsize <- ceiling(1e7/26^2) # 10 million rows and 676 groups

# time taken to create data frame
# runif --> is random uniform values
DF_time <- system.time(
  DF <- data.frame(x=rep(LETTERS,each=26*grpsize), 
                   y=rep(letters,each=grpsize),
                   v=runif(grpsize*26^2),
                   stringsAsFactors = FALSE)
)

head(DF,3)

DF_time

dim(DF)

# time taken to scan a vector

DF_vec_time <- system.time(ans1<- DF[DF$x=="R" & DF$y =="h",])

DF_vec_time

head(ans1,3)

# Now convert the same data frame to data table and extract

DT <- data.table(DF)

# set the key

system.time(setkey(DT,x,y))


DT_vec_time <- system.time(ans2<- DT[list("R","h")])

DT_vec_time

# This below statement also works but it is using data.table badly
DT_vec_time <- system.time(ans2<- DT[DT$x == "R" & DT$y == "h",])
DT_vec_time

identical( DT[list("R","h"),],DT[.("R","h"),])

# the second argument in DT[...] consists of expressions 
# the second argument in data table and data frame are slightly different

# the sum(v) in the 2nd arg is an expression
DT[,sum(v)]

# the below expression sums the v which are grouped by x
DT[, sum(v), by=x]

# the by in data.table is fast. Let's compare with tapply
ttt <- system.time( tt<-tapply(DT$v,DT$x,sum))
ttt

sss<-system.time(ss <- DT[,sum(v),by=x])
sss

ttt <- system.time( tt<-tapply(DT$v,list(DT$x,DT$y),sum))
ttt

sss<-system.time(ss <- DT[,sum(v),by="x,y"])
sss

# Joining using keys

DT1 <-data.table(x=c('a','a','b','dt1'), y=1:4)
DT2 <- data.table(x=c('a','b','dt2'),z=5:7)
setkey(DT1,x)
setkey(DT2,x)
DT3 <- merge(DT1,DT2)

DT1
DT2
DT3
# Adding new columns using data.table
# below new variable w is added
DT[,w:=v^2]
head(DT)

DT2 <- DT

DT[,z:=2]

# you can see that both DT2 and DT values have changed even though we just used DT
# to copy we have to use copy function specifically
DT
DT2

DT2 <- copy(DT)

DT[,a:=2^2]

# now as you can see only DT variable has changed
head(DT)
head(DT2)

#multiple operations

# In the below first tmp variable is calculated and this intun is used in other expression
# Finally the other expresssion is added to the column m
DT[,m:={tmp<-(w+z);log2(tmp+5)}]

head(DT,5)

#plyr like operations
DT[,b:=v>0.1]

head(DT,5)

DT[ ,c:=mean(w+v), by=b]
head(DT)

#Special variables

set.seed(1234)

# number of rows by x
DT[,.N,by=x]


# Fast reading
rm(list=ls())
big_data_frame <- data.frame(x=rnorm(1E6),y=rnorm(1E6))
file <- tempfile()
write.table(big_data_frame,file=file,row.names = FALSE,col.names=TRUE,sep="\t",quote=FALSE)

t<- system.time(fread(file))
t
# fread is much faster than below read.table
system.time(read.table(file=file, header = TRUE,sep="\t"))

library(swirl)
install_from_swirl("Getting and Cleaning Data")
