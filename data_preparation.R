library("tidyverse")

genderdf <- read.csv("gender.csv")
citizenshipdf <- read.csv("citizenship.csv")


genderdf <- genderdf[1:9]
citizenshipdf <- citizenshipdf[1:9]

genderdf <- genderdf[-c(1,3:5,7,8)]
genderdf <- spread(genderdf, key = Gender, value = Value)
genderdf <- replace(genderdf, is.na(genderdf), 0)

citizenshipdf <- citizenshipdf[-c(1,3:5,7,8)]
citizenshipdf <- spread(citizenshipdf, key = Citizenship, value = Value)
citizenshipdf <- replace(citizenshipdf, is.na(citizenshipdf), 0)


universitydf <- merge(citizenshipdf, genderdf)



ratios <- list()
for (i in 3:6){
  ratios <- assign("ratios", universitydf[i]/universitydf$total)
  names(ratios) <- paste0(names(universitydf[i]),"_ratio",sep="")
  universitydf <- cbind(universitydf, ratios)
}

universitydf <- universitydf[-c(3:6)]#remove absolute numbers

universitydf <- universitydf[-c(4,6)]#remove male, italian


write.csv(universitydf, file="data.csv")