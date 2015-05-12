############### PROBABILITY AND DISTRIBUTION
# The functions available for each distribution follow this format:
# dname( )	density or probability function
# pname( )	cumulative density function
# qname( )	quantile function
# rname( )	random deviates

# binomial distribution
# two types: discrete and continuous
# there are 12 questions in a quiz, 
# each with five answers one of which is 
# correct
# a student answers the test completely at random
# what is the probability of having four or 
# fewer correct answers?
dbinom(0, size=12, prob=0.2) + dbinom(1, size=12, prob=0.2) +
  dbinom(2, size=12, prob=0.2) + dbinom(3, size=12, prob=0.2) + 
  dbinom(4, size=12, prob=0.2)
# or find the cumulative probability
pbinom(4, size=12, prob=0.2)

# Poisson distribution
# the average number of times the word "the" appears 
# on a page in a particular book is 16
# what is the probability that a given page 
# has 17 or more "the's"
# Poisson parameter (lambda) = 16
ppois(17, lambda=16)   # lower tail: probability of 16 or fewer "the's"
ppois(17, lambda=16,lower=FALSE)   # upper tail: probability of 17 or more "the's"

# uniform distribution
runif(25, min=1, max=3) # 25 numbers from a uniform distribution on (1,3)

# exponential distribution
# applies to waiting time for an event (or analogous situations)
# the mean checkout time of a 
# supermarket cashier is three minutes
# what is the probability of a checkout 
# being completed in less than 2 minutes?
# processing rate = 1/3 (parameter of the exponential distribution, mu)
pexp(2, rate=1/3)

# normal distribution
# average height of men in the USA is 175.5 cm (mu) and SD is 7.4 cm (sigma)
# what is the probability of a randomly chosen man being 181 cm or more in height?
pnorm(181, mean=175.5, sd=7.4, lower.tail=FALSE) 
pnorm(161, mean=175.5, sd=7.4, lower.tail=TRUE) # prob less than 161 cm
# fit a normal distribution
# compare theoretical quantiles to sample quantiles (using Q-Q plots)
# create sample data 
x <- rnorm(100, mean=0, sd=1) # draw from a standard normal distribution
# normal fit 
qqnorm(x)
qqline(x)
abline(0,1,lwd=3,col="blue") # overlay the 1:1 line

ks.test(x,"pnorm") # Kolmogorov-Smirnov test
shapiro.test(x) # Shapiro-Wilk test

y <- runif(1000, min=0, max=10) # sample from uniform distribution
qqnorm(y,col=rgb(0,0,1,0.1),pch=16,cex=0.8)
qqline(y,lwd=3)
abline(0,1,lwd=3,col="red")
ks.test(y,"pnorm")
shapiro.test(y)


# Display the Student's t distributions with various
# degrees of freedom and compare to the normal distribution
x <- seq(-4, 4, length=100)
hx <- dnorm(x) #density of the normal distribution
degf <- c(1, 3, 8, 30)
colors <- c("red", "blue", "darkgreen", "gold", "black")
labels <- c("df=1", "df=3", "df=8", "df=30", "normal")
plot(x, hx, type="l", lty=2, xlab="x value",
     ylab="Density", main="Comparison of t Distributions")
for (i in 1:4)
{
  lines(x, dt(x,degf[i]), lwd=2, col=colors[i])
}
legend("topright", inset=.05, title="Distributions",labels, lwd=2, 
       lty=c(1, 1, 1, 1, 2), col=colors)

