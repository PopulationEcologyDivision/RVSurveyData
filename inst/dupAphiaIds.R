
codes<- RVSurveyData::GSSPECIES[,c("APHIAID", "CODE")]
n_occur <- data.frame(table(codes$APHIAID))
repeatedAphias <- as.vector(n_occur[n_occur$Freq > 1,"Var1"])
dups <- RVSurveyData::GSSPECIES[RVSurveyData::GSSPECIES$APHIAID %in% repeatedAphias,c("CODE","APHIAID", "SPEC","COMM", "SPEC_SUGG" )]
dups <- dups[with(dups, order(APHIAID,CODE)), ]
View(dups)
write.csv(dups,"Mar_DuplicateAphiaIDs.csv")
