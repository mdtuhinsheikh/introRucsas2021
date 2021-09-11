## R as a calculator
5+7                          # 12
exp(5)                       # 148.4132   
log(2)                       # 0.6931472

## Ask for help?
?mean                       # Search mean function
help.search("print") 

## Assigning operator
x <- "Hello World"
x                 # [1] "Hello World"
x = 5
x                 # [1] 5
5 -> x
x                 # [1] 5
x <- c(2, 5, 8)       # [1] 2 5 8
x[2]                  # [1] 5
x[1:2]                # [1] 2 5
x[1]**2               # [1] 4
exp(x)                # [1]    7.389056  148.413159 2980.957987
x[1] %% 2             # [1] 0
x[1] == 2             # [1] TRUE
x[1] < 2              # [1] FALSE
x[1] != 2             # [1] FALSE

## Some useful R functions
rep(c(1, 2, 3), times = 2)                 # 1 2 3 1 2 3
rep(c(1, 2, 3), each = 2)                  # 1 1 2 2 3 3

## Quiz solution
x <- c(3, 3, 5, 5, 10, 20)  
length(x)        # 6
unique(x)        # 5 3 10 20
sort(x)          # 3 5 10 20 
table(x)         # 3 5 10 20 
                 # 2 2  1  1 

## Basic R data structure
x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
x[2]          # Second element 5.6
x <- list(c(1, 2), c(5, 8, 9))
x[[1]]        # [1] 1 2
x[[2]]        # [1] 5 8 9
x <- array(1:12, dim = c(3,2,2))
x[ , , 1] ##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
x <- matrix(1:6, nrow = 2)
x

## Quiz solution
A <- matrix(c(1, 2, 3, 4), ncol = 2, byrow = TRUE)
B <- matrix(c(10, 20, 30, 40), ncol = 2, byrow = TRUE)
dim(A)
dim(B)

## Find the determinant of $A$ and $B$.
det(A)
det(B)

## Quiz solution 
A %*% B
solve(A)
solve(B)

## Example: function of evaluating absolute value
find_abs <- function(x) {
  if (x > 0) {
    return(x)
  }
  x * -1
}
find_abs(-5)       # 5

## Quiz solution
pow <- function(x, y) {
  result <- x^y
  return(result)
}
pow(2, 3) 


## Loop and condition
for(i in 1:5){
  index <- i
  print(index)
}

i=1
while(i <= 5){
  index <- i
  print(index)
  i = i + 1
}

for(i in 1:5){
  if(i != 2){
    index <- i
    print(index)
  }
}


## Quiz 
A <- matrix(c(1, 2, 3, 4), ncol = 2, byrow = TRUE)
B <- matrix(c(10, 20, 30, 40), ncol = 2, byrow = TRUE)

dim(A)
dim(B)

if (dim(A)[2] == dim(B)[1]){
  print("The multiplication is possible")
} else {
  print("The multiplication is not possible")
}

## Data application
install.packages("Lahman")
library(Lahman)
data(package = "Lahman")

## Read data from package 
data("Batting", package = "Lahman")

## To learn about the variables
str(Batting)

## Display few rows of the data
head(Batting)

## Indexing works similar to matrix
Batting[, 1:4]
Batting$playerID
Batting[, c("playerID")]
# Displayes all rows of playerID variable
Batting[1:10, c("playerID", "yearID")]
# Displayes 10 rows of playerID and yearID variables

## Create new variable
Batting$CS_SO <- with(Batting, CS + SO)
head(Batting[, c("CS", "SO", "CS_SO")])

## Quiz on Batting data
## - Display data from 1871 only
## - Find the frequency of unique number of players, teams, and year information
## - Create a separate dataframe for year 1872 only.

## Quiz solution
## - Conditioning on the dataframe
Batting[Batting$yearID == "1871", ]   # Displays data from 1871 only
# Displays data for aardsda01 from 1871
Batting[Batting$yearID == "1871" & Batting$playerID == "aardsda01", ]   

## - Unique number of players, teams, and year information:
length(unique(Batting$playerID))        # [1] 19428
length(unique(Batting$teamID))          # [1] 149
length(unique(Batting$yearID))          # [1] 148

## - Alternative way: using **apply()** function
apply(Batting, 2, function(x) {length(unique(x))})
# playerID   yearID    stint   teamID ...
#    19428      148        5      149 ...

## - Create new dataframe
Batting_1872 <- Batting[Batting$yearID == "1872", ]


## Data management using "dplyr" package
install.packages("dplyr")
library(dplyr)

data("Salaries", package = "Lahman")
head(Salaries)

## Let us create a subset of "Salary" data without "lgID"
salaries <- Salaries %>% select(playerID, yearID, teamID, salary)
head(salaries)

## We want to add salary info of the players in our Batting data
batting <- left_join(Batting, salaries, 
                     by =c("playerID", "yearID", "teamID"))

## Mean salary
mean(batting$salary, na.rm =  TRUE)

## Arrange the data with respect to multiple variables in order
batting <- batting %>% arrange(playerID, yearID, stint)

## Quiz solution
## - Filter the data with eiligible players after the year 1899 and with a minimum of 20 base on balls
eligibleHitters <- batting %>% filter(yearID >= 1900 & BB > 20)

## - Arrange the eligible players by decreasing order of base on balls.
goodPlayers <- eligibleHitters %>% arrange(desc(BB))


