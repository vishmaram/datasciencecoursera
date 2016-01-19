#week 2 quiz
library(httr)

oauth_endpoints("github")

myapp <- oauth_app("TestAppVish",key="70570255960b2e8162eb",
                   secret = "e283a3158905d85b152d00f79993fdf6f1f20a32")

github_token <- oauth2.0_token(oauth2.0_token("github"),myapp)
sig <- sign_oauth1.0(myapp,toke="")

getwd()
setwd("./gettingAndCleaningData/data")

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url=url, destfile = "acs.CSV", method = "curl")
acs <- read.csv("acs.CSV")
install.packages("sqldf")
library(sqldf)
library(RMySQL)
sqldf("select pwgtp1 from acs where AGEP < 50")
?sqldf
head(acs)
sqldf("select * from acs where AGEP <50 ")

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
rcontent <-readLines(con)
rcontent
head(rcontent)
nchar(rcontent[[10]])
nchar(rcontent[[20]])
nchar(rcontent[[30]])
nchar(rcontent[[100]])



con <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
rcontent <-readLines(con)
head(rcontent)
df <-data.frame()

l <- rcontent[[6]]
l
substring(l,25,32)

df <- read.fwf(file = con, skip = 4, widths = c(10,9,5,8,5,8,5,8,4))
df$v9 = as.numeric(df$V9)
df$v4 = as.numeric(df$V4)
sum(df$v9)+sum(df$v4)



library(httr)
library(httpuv)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "70570255960b2e8162eb",
                   secret = "e283a3158905d85b152d00f79993fdf6f1f20a32")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp,cache = FALSE)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)
library(jsonlite)
json1 <- content(req) 
