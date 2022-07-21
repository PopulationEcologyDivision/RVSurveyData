tt<- GSDET
tt<- tt[!is.na(tt$FWT),c("MISSION", "SETNO", "FWT")]
tt$TOTWGTchk<- ifelse(!is.na(tt$TOTWGT) & tt$TOTWGT>0,yes = 99, ifelse(is.na(tt$TOTWGT),NA,0))

tt<- merge(GSDET, GSINF, by=c("MISSION"), all.x=T)
tt<- merge(tt, GSMISSIONS, by=c("MISSION"), all.x=T)
tt <- tt[,c("YEAR","SEASON", "TOTWGT")]
tt$TOTWGTchk<- ifelse(!is.na(tt$TOTWGT) & tt$TOTWGT>0,yes = 99, ifelse(is.na(tt$TOTWGT),NA,0))
tt$TOTWGT <- NULL

SPRING <- tt[tt$SEASON=="SPRING",c("TOTWGTchk", "YEAR")]
SUMMER <- tt[tt$SEASON=="SUMMER",c("TOTWGTchk", "YEAR")]

cnames <- c("YEAR","VAL","FREQ")

SPRINGfreq<-data.frame(table(SPRING$YEAR, SPRING$TOTWGTchk))
names(SPRINGfreq) <- cnames
SPRINGfreq<- SPRINGfreq[SPRINGfreq$VAL == 0,]

SUMMERfreq<-data.frame(table(SUMMER$YEAR, SUMMER$TOTWGTchk))
names(SUMMERfreq) <- cnames
SUMMERfreq<- SUMMERfreq[SUMMERfreq$VAL == 0,]

#herring
herring<- res$GSDET[res$GSDET$SPEC==60,]
herring <- herring[,c("MISSION", "FLEN", "FWT")]
herring<- herring[!is.na(herring$FLEN),]
herring<- herring[!is.na(herring$FWT),]
herring<- herring[herring$MISSION %in% c("NED2016016","NED2016116","NED2017020"),]
# herring<- merge(herring, res$GSMISSIONS[,c("MISSION", "YEAR", "SEASON")], all.x = T, by="MISSION")

#cm plot(herring[herring$MISSION=="NED2015002","FWT"], herring[herring$MISSION=="NED2015002","FLEN"])
#cm plot(herring[herring$MISSION=="NED2015017","FWT"], herring[herring$MISSION=="NED2015017","FLEN"])
#cm plot(herring[herring$MISSION=="TEL2016002","FWT"], herring[herring$MISSION=="TEL2016002","FLEN"])
#cm plot(herring[herring$MISSION=="TEL2016003","FWT"], herring[herring$MISSION=="TEL2016003","FLEN"])

#mm plot(herring[herring$MISSION=="NED2016016","FWT"], herring[herring$MISSION=="NED2016016","FLEN"])
#mm plot(herring[herring$MISSION=="TEL2017002","FWT"], herring[herring$MISSION=="TEL2017002","FLEN"])
#mm plot(herring[herring$MISSION=="NED2017020","FWT"], herring[herring$MISSION=="NED2017020","FLEN"])

herring <- herring %>%
  group_by(MISSION, YEAR, SEASON) %>%
  summarise(FLEN = mean(FLEN))

# Grenadiers
grenadiers <- GSSPECIES[grepl(x = GSSPECIES$COMM, pattern = "GRENADIER"), "CODE"]
grenadiers <- res$GSDET[res$GSDET$SPEC %in% grenadiers,]
grenadiers <- grenadiers[!is.na(grenadiers$FWT),]
grenadiers <- grenadiers[!is.na(grenadiers$FLEN),]
grenadiers <- grenadiers[!is.na(grenadiers$FLEN),]
grenadiers$YEAR <- as.numeric(substr(grenadiers$MISSION, 4,7))
grenadiers<-grenadiers[grenadiers$YEAR>=2010,]
head(grenadiers)

grenadiers <<- grenadiers

Don <- res$GSDET
Don <- Don[Don$SPEC<1000 & !is.na(Don$FLEN) & !is.na(Don$CLEN),]
Don$TOTWGTchk<- ifelse(!is.na(Don$FWT) & Don$FWT>0,yes = 99, ifelse(is.na(Don$FWT),0,-1))
Don<- merge(res$GSMISSIONS, Don, all.y = T)
Don<- Don[,c("SEASON","YEAR", "FLEN","TOTWGTchk")]
DonSPRING <- Don[Don$SEASON=="SPRING",c("TOTWGTchk", "FLEN","YEAR")]
DonSUMMER <- Don[Don$SEASON=="SUMMER",c("TOTWGTchk", "FLEN","YEAR")]

cnames <- c("YEAR","VAL","FREQ")

SPRINGfreq<-data.frame(table(DonSPRING$YEAR, DonSPRING$TOTWGTchk))
names(SPRINGfreq) <- cnames
SPRINGfreq<- SPRINGfreq[SPRINGfreq$VAL == 0,]

SUMMERfreq<-data.frame(table(DonSUMMER$YEAR, DonSUMMER$TOTWGTchk))
names(SUMMERfreq) <- cnames
SUMMERfreq<- SUMMERfreq[SUMMERfreq$VAL == 0,]

Don1 <- Don %>%
  group_by(MISSION, YEAR) %>%
  summarise(FLEN = mean(FLEN))
