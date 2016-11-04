# Data frame containing dates 
# The data frame contains two columns
# ord                 res
# YYYY-MM-DD HH:MM:SS YYYY-MM-DD HH:MM:SS
# YYYY-MM-DD HH:MM:SS YYYY-MM-DD HH:MM:SS
# YYYY-MM-DD HH:MM:SS YYYY-MM-DD HH:MM:SS
# YYYY-MM-DD HH:MM:SS YYYY-MM-DD HH:MM:SS

# Algorithm 1
# create a sequence of days in the year 
start <- as.POSIXct("2012-01-01")
interval <- 60
end <- start + as.difftime(365, units = "days")

daysInYear <- as.list(seq(from = start, by = interval*60*24, to = end))

ord <- NULL
res <- NULL
for (day in daysInYear) 
  {
# Set a random amount of transactions
  amounTrans <- sample(1:500,1,replace = T)
  for (transaction in 1:amounTrans) 
    {
#   increment the start date by a random amount of seconds 
    tempStart <- day + sample(1:interval*60*24,1)
    ord <- append(ord, tempStart)
#   increment the random start date by a random TAT
    tempEnd  <- tempStart + sample(1:interval*60*24,1)
    res <- append(res, tempEnd)
    }
  }
timeDates <- data.frame(ord,res)


# Create a .csv file containing dates and times for TAT
write.csv(timeDates,file = "test_data.csv")

#Algorithm 2
start <- as.POSIXct("2012-01-01")
interval <- 60
end <- start + as.difftime(365, units = "days")

daysInYear <- as.data.frame(seq(from = start, by = interval*60*24, to = end))
colnames(daysInYear)<- c("Day")
test_1 <- mutate(daysInYear,dow = wday(Day,label = T))

for(level in levels(test_1$dow))
{test_1[test_1$dow==level,]}

