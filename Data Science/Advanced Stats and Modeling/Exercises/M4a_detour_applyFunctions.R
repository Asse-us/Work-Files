# apply
# 
# When you want to apply a function to the rows or 
# columns of a matrix (and higher-dimensional analogues).

# Two dimensional matrix

M <- matrix(seq(1,16), 4, 4)

# apply min to rows
apply(M, 1, min)

# apply max to columns
apply(M, 2, max)

# 3 dimensional array
M <- array( seq(32), dim = c(4,4,2))

# Apply sum across each row
apply(M, 1, sum)
# Result is one-dimensional

# Apply sum across each M[*, *, ] - i.e Sum across 3rd dimension
apply(M, c(1,2), sum)
# Result is two-dimensional

# If you want row/column means or sums for a 2D matrix,
# be sure to investigate the highly optimized, lightning-quick 
# colMeans, rowMeans, colSums, rowSums.

# lapply
# When you want to apply a function to each element of a list in 
# turn and get a list back.

x <- list(a = 1, b = 1:3, c = 10:100) 
lapply(x, FUN = length) 
lapply(x, FUN = sum) 

# sapply
# When you want to apply a function to each element of a 
# list in turn, but you want a vector back, rather than a list.

x <- list(a = 1, b = 1:3, c = 10:100)
#Compare with above; a named vector, not a list 
sapply(x, FUN = length)  
sapply(x, FUN = sum)   

# In more advanced uses of sapply it will attempt to coerce the 
# result to a multi-dimensional array, if appropriate. For example,
# if our function returns vectors of the same length, sapply will 
# use them as columns of a matrix:
  
sapply(1:5,function(x) rnorm(3,x))

# If our function returns a 2 dimensional matrix,
# sapply will do essentially the same thing, treating
# each returned matrix as a single long vector:
  
sapply(1:5,function(x) matrix(x,2,2))

# Unless we specify simplify = "array", in which case it will
# use the individual matrices to build a multi-dimensional array:
  
sapply(1:5,function(x) matrix(x,2,2), simplify = "array")

# vapply
# When you want to use sapply but perhaps need to squeeze 
# some more speed out of your code.
 
# For vapply, you basically give R an example of what 
# your function will return, which can save some time 
# coercing returned values to fit in a single atomic vector.

x <- list(a = 1, b = 1:3, c = 10:100)

# Note that since the advantage here is mainly speed, this
# example is only for illustration. We're telling R that
# everything returned by length() should be an integer of 
# length 1. 

vapply(x, FUN = length, FUN.VALUE = 0L) 

# mapply
# For when you have several data structures (e.g. vectors, lists)
# and you want to apply a function to the 1st elements of each,
# and then the 2nd elements of each, etc., coercing the result 
# to a vector/array as in sapply.

# This is multivariate in the sense that your function must accept 
# multiple arguments.

#Sums the 1st elements, the 2nd elements, etc. 

mapply(sum, 1:5, 1:5, 1:5) 

#To do rep(1,4), rep(2,3), etc.
mapply(rep, 1:4, 4:1)   

# Map
# A wrapper to mapply with SIMPLIFY = FALSE,
# so it is guaranteed to return a list.

Map(sum, 1:5, 1:5, 1:5)

# tapply
# For when you want to apply a function to subsets of a vector 
# and the subsets are defined by some other vector, usually a factor.
# A vector:
x <- 1:20

# A factor (of the same length) defining groups:
y <- factor(rep(letters[1:5], each = 4))

# Add up the values in x within each subgroup defined by y:
tapply(x, y, sum)  

