
# ------ DOWNLOAD RAW DATA
data <- read.csv('SFPD_Incidents_-_from_1_January_2003.csv', stringsAsFactors = FALSE)

# ------ CREATE CLEAN DATA-FRAME
data2 <- data.frame("IncidntNum" = data$IncidntNum)

# TIME - Numeric
data2$Year <- as.numeric(format(as.Date(data$Date,"%m/%d/%Y"), format = "%Y"))
data2$Month <- as.numeric(format(as.Date(data$Date,"%m/%d/%Y"), format = "%m"))
data2$Day <- as.numeric(format(as.Date(data$Date,"%m/%d/%Y"), format = "%d"))
data2$Hour <- as.numeric(gsub("[^[:digit:]]", "", data$Time))

# TIME - Character
data2$DayOfWeek <- data$DayOfWeek
data2$Date <- data$Date
data2$Time <- data$Time

# CATEGORY and RESOLUTION - Character

# Big Category
dict_category <- as.data.frame(table(data$Category), stringsAsFactors = FALSE)
# Mapping (alphabetic order for the crimes)
dict_category$BigCateg <- c(3,2,1,1,1,3,3,3,3,1,1,2,1,1,3,2,1,3,3,2,0,0,3,3,0,1,3,3,2,2,1,2,3,3,3,3,1,0,3)

map_Category <- function(x){
  dict_category$BigCateg[dict_category$Var1 == x]
}

data2$BigCategory <- apply(as.matrix(data$Category), MARGIN = 1,FUN = map_Category)
data2$Category <- data$Category
data2$Descript <- data$Descript
data2$Resolution <- data$Resolution


# LOCATION
data2$PdDistrict <- data$PdDistrict
data2$Adress <- data$Address
data2$X <- data$X
data2$Y <- data$Y
data2$Location <- data$Location

# ---- ORDER DATA
data2 <- data2[with(data2, order(Date, Time)), ]

