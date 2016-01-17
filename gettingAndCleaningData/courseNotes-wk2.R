# Getting data from MySQL
rm(list = ls())
install.packages("RMySQL")

library(RMySQL)

dbConn <- dbConnect(MySQL(),user="root",password ="solarsys",host="localhost") # Connect db server
result <- dbGetQuery(dbConn,"Show Databases;")
dbDisconnect(dbConn) # Disconnect after the dbconn is ues

result # When we print it will give list of databases


# connect wfmsweden database
dbConn <- dbConnect(MySQL(),user="root",password ="solarsys",host="localhost", db="wfmmcdsweden")
allTables <- dbListTables(conn = dbConn)
head(allTables) 
length(allTables)

dbListFields(dbConn, name = "TRACE_USER") # lists all the column names in the table trace user
dbGetQuery(dbConn, "select * from trace_user where unit_id = 'SES000041'")

# Below command is used to read all the data
traceUserData <- dbReadTable(dbConn, "trace_user")
head(traceUserData)

#dbSendquery only submits and syschronously executes the SQL statement to the database engine.
# it does not fetch any records.
?dbSendQuery
query<-dbSendQuery(dbConn,"select * from trace_user where unit_id = 'CORP'")

#dbFetch and fetch returns n elements from the database
?dbFetch
traceUserData <- dbFetch(query)
traceUserData <- fetch(query)
traceUserData <- fetch(query,n=10) # 10 rows is fetched here

# dbSendQuery - The statement is submitted for synchronous execution to the server connected through 
# the conn object. The DBMS executes the statement, possibly generating vast amounts of data. 
# Where these data reside is driver-specific: some drivers may choose to leave the output on 
# the server and transfer them piecemeal to R, others may transfer all the data to the 
# client – but not necessarily to the memory that R manages. See the individual 
# drivers' dbSendQuery method for implementation detail

# In order to clear data from server we need to run below clear command after sendquery
dbClearResult(query)
dbDisconnect(dbConn)


# Basic for HDF5 can be learned in below site
# https://www.hdfgroup.org/HDF5/Tutor/introductory.html
# http://neondataskills.org/HDF5/About/
# Another very good link for using HDF5 in R
# http://neondataskills.org/HDF5/Intro-To-HDF5-In-R/

# Rhdf5 package is part of the bioconductor suite so we need to first source in that suite

source("http://bioconductor.org/biocLite.R")
?BiocUpgrade
biocLite("BiocUpgrade")
biocLite("rhdf5")

library(rhdf5)


# to create h5 file returns true or not
 h5createFile("sampleH5File.h5")

 #create create 
 h5createGroup("sampleH5File.h5","Employee")
 h5createGroup("sampleH5File.h5","Unit")
 h5createGroup("sampleH5File.h5","Employee/skills") #subgroup of skills within employee
 h5ls("sampleH5File.h5")
 
 # writing to groups
 A = matrix(1:10,nrow=2,ncol=5)
 h5write(A,"sampleH5File.h5","Employee/A")
 
 B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
 h5write(B,"sampleH5File.h5","Employee/skills/B")
 
 h5ls("sampleH5File.h5")
 
 #writing a dataset
 df = data.frame(1L:5L,seq(0.1,length.out = 5),c("ab","bc","cd","de","ef"),stringsAsFactors = FALSE)
 h5write(df,"sampleH5File.h5","df")
 
 h5ls("sampleH5File.h5")
 
 #Reading Data
 readA <- h5read("sampleH5File.h5","Employee/A")
 readB <- h5read("sampleH5File.h5","Employee/skills/B")
 readdf <- h5read("sampleH5File.h5","df")
 
 readA
 
 #writing and reading chunks - index tells to what rows and columns the values should be updated
 h5write(c(12,13,14),"sampleH5File.h5","Employee/A",index=list(2,2:4))
 
 h5ls("sampleH5File.h5")
 readA <- h5read("sampleH5File.h5","Employee/A")
 readA
 