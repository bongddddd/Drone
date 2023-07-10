library(exifr)
library(openxlsx)


# 상위 폴더 부르기기
file_path <- "C:/Users/User/Desktop/Uiry" # / = \\
xx <- list.files(file_path)
xx
wb <- createWorkbook()


# 해당 폴더의 하위 폴더 , 그 안의 사진폴더들 부르기기
# for(x in xx) means that x is xx[1], which repeats to the end of xx 
for (file_name in xx) {
  sheet <- addWorksheet(wb, file_name) # file_name의 이름을 가진 시트 추가
  header <- c("name","Time", "Lat", "Long" )
  writeData(wb, sheet,header[1] , startCol = 1, startRow = 1)
  writeData(wb, sheet, header[2], startCol = 2, startRow = 1)
  writeData(wb, sheet, header[3], startCol = 3, startRow = 1)
  writeData(wb, sheet, header[4], startCol = 4, startRow = 1)
#  writeData(wb, sheet, header[5], startCol = 5, startRow = 1)
 
 
  zxz <- list.files(paste(file_path, file_name, sep = "/" ), full.names = TRUE, pattern = "JPG$") # paste 는 걍 묵어주는 역활, sep give a / to a vaccum
  row = 2    # Row 1 already has information about the column    /                       "(JPG|TIF)$"
   
  for(pictures in zxz){
    attir <- read_exif(pictures)
 #   GSD <- (attir$GPSAltitude/3.281)/18.9
    dataa <- c(basename(pictures), attir$ModifyDate, attir$GPSLatitude, attir$GPSLongitude )
    writeData(wb, sheet, dataa[1], startCol = 1, startRow = row)  # name
    writeData(wb, sheet, dataa[2], startCol = 2, startRow = row)  # Time
    writeData(wb, sheet, dataa[3], startCol = 3, startRow = row)  # Lat
    writeData(wb, sheet, dataa[4], startCol = 4, startRow = row)  # Long
  #  writeData(wb, sheet, dataa[5], startCol = 5, startRow = row)  # Feet
   
    row <- row + 1
    
     }
 
}
getwd()
setwd("C:/Users/User/OneDrive/문서/종합")
#Don't forget! You need to locate and assign this file
saveWorkbook(wb, "Uiry_coordRGB.xlsx",overwrite = TRUE )


