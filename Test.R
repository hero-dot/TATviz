library("dplyr")
library("lubridate")
library("fields")
library("magrittr")
#import data
test.data <- read.csv("test_data.csv")
head(test.data)

test.data$ord <- ymd_hms(test.data$ord)
test.data$res <- ymd_hms(test.data$res)
test.data <- mutate(test.data,otf = difftime(res,ord,units="min"))
test.data <- mutate(test.data,dow = wday(ord))
test.data <- mutate(test.data,hod = as.numeric(format(test.data$ord, "%H")))

#prepare an empty matrix
heat.data <- matrix(rep(NA,7*24),nrow = 7, ncol = 24)
#loop over the days and hours and calculate the median TAT
for(i in 1:7){
  for(j in 0:23){
    heat.data[i,j+1] <- subset(test.data, test.data$dow==i & test.data$hod==j)$otf %>% median
  }
}

image.plot(1:7,seq(from=0.5, to=23.5, by = 1),heat.data,axes=FALSE, 
           xlab = "Day of Week", ylab = "Hour of Day", ylim=c(0,24))
# the following pointless command is necessary to make the custom axis labels non-transparent
# google revealed this among a number of other workarounds.
points(0,0)
# now these will display properly
axis(side=1, at=1:7, labels=as.character(wday(1:7, label=TRUE)), las=2, cex.axis = 0.8)
axis(side=2, at= 0:24, labels=0:24, las=1, cex.axis=0.8)

image.plot(1:7,seq(from=0.5, to=23.5, by = 1),heat.data,axes=FALSE, 
           xlab = "Day of Week", ylab = "Hour of Day", ylim=c(0,24))
points(0,0) #random command that resets par
axis(side=1, at=1:7, labels=as.character(wday(1:7, label=TRUE)), las=2, cex.axis = 0.8)
axis(side=2, at= 0:24, labels=0:24, las=1, cex.axis=0.8)

# calculate the lowest and highest TAT
min.z <- min(heat.data)
max.z <- max(heat.data)
# determine which TAT's will have yellow to green shading
z.yellows <- min.z + (max.z - min.z)/64*c(20,45) 
# print the labels
for(i in 1:7){
  for(j in 1:24){
    if((heat.data[i,j] > z.yellows[1])&(heat.data[i,j] < z.yellows[2])){
      text(i,j-0.5,heat.data[i,j], col="black", cex = 0.8)
    }else{
      text(i,j-0.5,heat.data[i,j], col="white", cex = 0.8)     
    }
  }
}

#prepare an empty matrix
heat.data <- matrix(rep(NA,7*24),nrow = 7, ncol = 24)
#loop over the days and hours and calculate the median TAT
for(i in 1:7){
  for(j in 0:23){
    heat.data[i,j+1] <- subset(test.data, test.data$dow==i & test.data$hod==j)$otf %>% quantile(.,probs=0.75)
  }
}