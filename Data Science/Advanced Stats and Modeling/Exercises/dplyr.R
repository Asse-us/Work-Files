# dplyr
# this is a package from Hadley Wickham,
# the author of the grammar of graphics (ggplot)
# this is a significant advance over previous packages
# for data manipulation, such as plyr
# the grammar metaphor is also used here
# basically dplyr provides 6 "verbs", or actions
# that are commonly used in data manipulation
# 1. filter
# 2. select
# 3. mutate
# 4. arrange
# 5. group_by
# 6. summarize

library(dplyr)

# subsetting according to some condition
dat8 <- filter(tp,brand=="colgate")
head(dat8)
dim(filter(tp,brand=="colgate"))

dat9 <- filter(tp,brand=="colgate"|brand=="crest")
head(dat9)
dim(filter(tp,brand=="colgate"|brand=="crest"))

# selecting columns
dat10 <- select(tp,brand,INCOME,feat)
head(dat10)

# excluding columns
dat11 <- select(tp,-brand,-INCOME,-feat)
head(dat11)

# creating a new column
dat12 <- mutate(tp,logIncome=log(INCOME))
head(dat12)


# arranging data 
dat13 <- arrange(tp,INCOME) # default = ascending
dat14 <- arrange(tp,desc(INCOME)) # descending
dat14 <- arrange(tp,-INCOME) # descending - alternative way

# groupwise summaries
gr_brand <- group_by(tp,brand)
summarize(gr_brand,mean(INCOME),sd(INCOME))

gr_brand1 <- group_by(tp,brand,feat)
summarize(gr_brand1,
		mean(INCOME),
        sd(INCOME),
        min(ETHNIC),
        var(AGE60))

# Task: Find the mean price paid by 
# all people whose income is >= 10.5
# Base R code
mean(tp[tp$INCOME>=10.5,"price"])

#dplyr code
summarize(filter(tp,INCOME>=10.5),mean(price))

# Pipelines
tp %>% filter(INCOME>=10.5) %>% 
  summarize(mean(price))
tp %>% 
  filter(price>=2.5) %>% 
  mutate(logIncome=log(INCOME)) %>% 
  summarize(mean(logIncome),median(logIncome),
            sd(logIncome))

