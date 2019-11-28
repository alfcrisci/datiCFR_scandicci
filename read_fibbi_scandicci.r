library(readr)
library(utils)
source("weather_aux.r")
utils::unzip("dbout.zip")

scandicci=readr::read_delim("dbout.csv", "\t",col_names = TRUE)

names(scandicci)=c("data","ora","Tair","RH","wind","rain","SunJ")

scandicci[scandicci=="-999"]=NA
scandicci[scandicci=="START"]=NA
scandicci[scandicci=="-9.999"]=NA
scandicci[scandicci=="-999.9"]=NA
     
   
scandicci$data=as.Date(as.character(scandicci$data),format="%d/%m/%Y")
scandicci$time=as.POSIXlt(paste0(scandicci$data," ",scandicci$ora,":00"),format="%Y-%m-%d %H:%M")

scandicci$Tair=as.numeric(as.character(scandicci$Tair))
scandicci$RH=as.numeric(as.character(scandicci$RH))
scandicci$wind=as.numeric(as.character(scandicci$wind))
scandicci$rain=as.numeric(as.character(scandicci$rain)) 
scandicci$SunJ=as.numeric(scandicci$SunJ)  
scandicci=scandicci[c("time","data","ora","Tair","RH","wind","rain","SunJ")]        
saveRDS(scandicci,"scandicci_sangiusto_1992_2019_rawdata.rds")
scandicci_df=as.data.frame(scandicci)
scandicci_df_ref=scandicci_df[scandicci_df$data=="2017-08-01",]
XLConnect::writeWorksheetToFile("Riferimento_clima_scandicci_2017-08-01.xls",scandicci_df_ref,"dati 15 min")

