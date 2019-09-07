library(dplyr)
library(reshape)
getwd()
###q1
Q1=read.csv("datacleaningtest2.csv",header=TRUE)
tbl_df(Q1)
Q1$agricultureLogical=NULL
Q1$agricultureLogical=ifelse(Q1$ACR ==3&Q1$AGS==6,TRUE,FALSE)
which(Q1$agricultureLogical)
###q2
library(jpeg)
###q3
Q3.EDU=read.csv("test2EDU.csv",header=TRUE)
Q3.GDP=read.csv("test2GDP.csv",header=TRUE)
names(Q3.GDP)[1]<-"CountryCode"
names(Q3.GDP)[2]<-"RANK"
names(Q3.GDP)[4]<-"Economy"
names(Q3.GDP)[5]<-"Total"
Q3.GDP$RANK<-as.numeric(as.character(Q3.GDP$RANK)

tbl_df(Q3.EDU)
tbl_df(Q3.GDP)
join<-merge(Q3.EDU,Q3.GDP,by="CountryCode")
arranged=arrange(join,desc(RANK))
paste(nrow(arranged), " matches, 13th country is ", arranged$Economy[13])
######q4
join$RANK<-as.numeric(as.character(join$RANK))
join%>%group_by(Income.Group)%>%
  filter("High income: OECD"%in% Income.Group | "High income: nonOECD" %in% Income.Group)%>%
  summarize(Average = mean(RANK, na.rm = T)) %>%
    arrange(desc(Income.Group))
#######Q5
join$RankGroups <- cut(join$RANK, breaks = 5)

vs <- table(join$RankGroups, join$Income.Group)
vs
vs[1, "Lower middle income"]


