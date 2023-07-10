install.packages("magick")
library(readxl)
library(ggplot2)
library(st)
library(sp)

uiry_togok <- "C:/Users/User/OneDrive/문서/종합/Uriy_data/Uiry_coordRGB.xlsx"
uiry_togok  # it is just a path assignment
# values specified as "character" but i don't know why
uiry_togok$Long <- as.numeric(uiry_togok$Long)
uiry_togok$Lat <- as.numeric(uiry_togok$Lat)
class(uiry_togok$Long[1])
# convert those
uiry_coord <- "C:/Users/User/OneDrive/문서/종합/Uriy_data/Uiry_cluster.xlsx"
togok <- read_excel(uiry_coord, sheet = "cluster1") # it brings sheet "cluster1" of uiry_coord
togok

ggplot(data = togok_R,aes(x = lon, y = lat)) + geom_point( ) +
  geom_text(aes(label = NO, hjust = 0.5, vjust = -1)) +
  geom_polygon(data = togok_A, aes(x = x, y = y), fill = "transparent", color = "red", size = 0.1) +
  geom_point(data = uiry_togok ,aes(x = Long, y = Lat)) 
#  geom_text(data = uiry_togok, aes(x = Long, y = Lat, label = name, hjust = 0.5, vjust = -1))

togok_R <- subset(togok, !(NO %in% c(92,88,90,43)))
togok_R <- togok_R[1:14,c(1,5,6)]
# it eliminate those numbers

points <- data.frame(x = togok_R$lon, y = togok_R$lat,No = togok_R$NO)
order_list <- c(84,79,77,76,94,80,86,89,93,85,87,84)# 순서 맞출려고 넣은거
togok_A <- points[match(order_list, points$No), c("x", "y", "No")] 




# step 1: 영역 그리기
# step 2: 사진의 좌표 넣기
# step 3: 그 좌표에 사진넣기!

library(magick)

# 배경 이미지 생성
background <- image_blank(width = total_width, height = total_height, format = "JPEG")

# 작은 사진들을 배경 이미지에 이어붙이기
for (i in 1:length(photo_files)) {
  photo <- image_read(photo_files[i])
  background <- image_composite(background, photo, offset = "+x_offset+y_offset")
}













# 처음 정렬시킬때는 눈으로 보고 골랐는데 그러기 보다는 자동으로 정해줬으면 싶어서 했다가 시류ㅐ함 난중에 시간나면 다시 해봄봄
togok_RR <- togok_R[1:14,c(1,5,6)]
# function "order" doesn't use type "DF", if you want to use DF, must assign its columns

togok_p <- SpatialPoints(coord = togok_RR[,c("lon","lat")])
class(togok_p)
# it coverts DF to "SP" # spatialPoints
togok_A <- togok_p[order(togok_p@coords[,"lon"]),-order(togok_p@coords[,"lat"])]
togok_A <- as.data.frame(togok_A)

polygon <- st_polygon(list(as.matrix(togok_A[, c("lon", "lat")])))
plot(polygon)
# 면적 계산
area <- st_area(polygon)
#이거 좌표계 lon *lat값이라 작게 나옴 / 알아서 환산해야됨/ 하는법은 ㅁ?ㄹ
# 면적 출력
area




# 처음 정렬시킬때는 눈으로 보고 골랐는데 그러기 보다는 자동으로 정해줬으면 싶어서 했다가 시류ㅐ함 난중에 시간나면 다시 해봄






