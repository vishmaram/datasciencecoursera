# list.files function lists all the files in the folder
?list.files

#params:
#path, pattern, all.files (incl. hidden), full.names(incl. dir path)
#recursive(inside folders), ignore.case, include.dirs( sub dir listing)
# no.. --> Should both "." and ".." be excluded also from non-recursive listings?


#args() to list the arguments
args(list.files)


#dir.exists(paths) --> To check if the dir exists in the path

#dir.create(path,showWarnings=TRUE,recursive=FALSE,mode="0777")
# mode is ignored in windows
# recursive will create all the foldr along the path



# Using Chmod in linux to change the permission for the owner(u), group(g) and others(o)
# https://www.youtube.com/watch?v=OOhrUcm0Chc

# umask in linux to change the default permissions. Below link is useful.
# https://en.wikipedia.org/wiki/Umask  

Sys.chmod(paths, mode = "0777", use_umask = TRUE)
Sys.umask(mode = NA)

#for changing permissions in R



# file.create() to create a file
#other functions file.exists(), file.remove(), file.rename, file.append(file1, file2), file.copy
#file.symlink, file.link, Sys.junction(from,to), file.info(),file.path()
# unlink() --> To delete the folder


# Below is used to create sequence of real numbers,  incremented by 1
pi:10

#Below is the negative increment by 1
15:1 

?`:`

#seq()
seq(1,10,by=0.5)
seq(1,10,length=30)

my_seq <- seq(5,10,length=30)

seq(along.with =my_seq)

seq_along(my_seq)

#length()

#rep()
rep(0, times=40)
rep(c(0,1,2), times=10) # 10 times of 0,1,2
rep(c(0,1,2), each=10) # 10 1's 10 2's and so on

#Atomic Vector
num_vect <- c(0.5,55,-10,6)
tf <- num_vect<1

# tf is logical vector

# paste() --> To combine all the character vectors into one string
# paste can also combine multiple character vectors --> element wise combining

my_char <- c("My","name","is")
paste(my_char, collapse = " ")
#[1] "My name is"


# Adding extra element to the vector
my_name <- c(my_char,"Vish")


paste(1:3,c("X","Y","Z"), sep="")
#[1] "1X" "2Y" "3Z"

# in the below example 1 to 4 recycles as this length is less than letters
paste(LETTERS,1:4,sep="_")

#values multiplied with NA will be NA
x <- c(44,NA,5,NA)
x*3

#rnorm(n) --> To get the random number of standard normal distribution with default mean 0 and std. dev 1
# n is number of observations

#pnorm(q) --> cummulative distribution function 
# q- is vector of quantiles

#qnorm(p) --> quantiles function
# p- is vector of probablities

#dnorm(x) --> Density function
# x is vector of quantities


#sample(x,size = n)
# to get sample of n elements from vector x
?sample


#is.na(x) to get logical vector of x if na 
#my_data == NA  is NOT VALID. its not same as is.na()

#| The trick is to recognize that underneath the surface, R represents TRUE as the number 1 and FALSE 
#as the number0. Therefore, if we take the sum of a bunch of TRUEs and FALSEs, we get the total number 
#of TRUEs

#sum(my_na) , number of trues in logical vector my_na as TRUE is represented by 1 


#NaN --> below will generate NaNs
Inf-Inf
0/0

#x[is.na(x)] --> will give vector with all NAs where x is a vector

#x is a vector with NAs, positive values and negative values
# By x[x>0], we will get both positive as well as NAs as R cannot perform on NA but below works
#x[!is.na(x) & x>0]

# In R, the first element index starts with 1 but not 0

# x is a vector of 40 elements
# finding x[0] will give numeric(0) and x[3000] will give NA, but R does not throw exception


#x[c(-2,-10)]
#x[-c(2,10)]



# Numeric vector with named elements
vect <- c(foo = 11, bar = 2, norf = NA)
vect2 <- c(11,2,NA)

#names(x) --> To get or set names of R object
names(vect)
names(vect2) <- c("foo","bar","norf")

vect["bar"] # returns 2nd element

#identical() --> to check if two objects are exactly equal

###### MATRICES AND DATA FRAMES ###########

#The main difference, as you'll see, is that matrices can only contain a single class of data, 
#while data frames can consist of many different classes of data.


# dim() --> gives the dimension of the object
my_vector<-1:20
dim(my_vector) # will return NULL as it is  a vector
length(my_vector) # length will give length of the vector
dim(my_vector) <- c(4,5) # giving dimension to the above vector -- after this it is a matrix

class(my_vector) # to know the class of the my_vector object

#attributes() --> gives the attributes of the object
attributes(my_vector) # gives following result
#$dim
#[1] 4 5


my_matrix <- my_vector

# other direct way of creating matrix
my_matrix2 <- matrix(data=1:20,nrow = 4, ncol = 5, byrow = FALSE)

# Assuming each row is one patient and each column is obs.
patients <- c("Bill","Gina","Kelly","Sean")

#cbind() to add column to the existing matrix
cbind(patients,my_matrix)

#because matrix can only have one data type, it changes all the elements to characters with above cbind
# this is where dataframe comes into picture. Each column can have different data type

my_data <- data.frame(patients, my_matrix)


# Adding column names to the data frame
cnames <- c("patient","age","weight","bp","rating","test")
colnames(my_data) <- cnames


###### LOGICAL #####################

#| You can use the `&` operator to evaluate AND across a vector. 
#The `&&` version of AND only evaluates the first member of a vector. 
#Let's test both for practice. Type the expression TRUE & c(TRUE, FALSE, FALSE).

#As you may recall, arithmetic has an order of operations and so do logical expressions. 
#All AND operators are evaluated before OR operators. Let's look at an example of an ambiguous case. 
5 > 8 || 6 != 8 && 4 > 3.9

#isTRUE() function
isTRUE(6>4)

#xor() - Exclusive OR. If one argument is TRUE and other is FALSE, function will return TRUE or else FALSE.
# Even if both the arguments are true false will be returned in xor()

#which() function takes logical vector as argument and returns indices of the vector that are TRUE

# any(logical vec) function will return TRUE if one of more elements are TRUE
# all(logical vec) function will return TRUE if all the elements are TRUE


##############  FUNCTIONS  ##########

Sys.Date() # returns date in "2016-01-19" format


