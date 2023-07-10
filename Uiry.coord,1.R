install.packages("rgdal")
library(openxlsx)
library(ggplot2)
library(readxl)


Sys.setlocale("LC_ALL", "Korean")

cooord <- read_excel("C:/RRR/Uiry.xlsx",sheet = 5)

cooord <- subset(cooord, NO != 99)  # 맘에 안드는 행 뺄수 있음
cooord

ggplot(data = cooord,aes(x = lon, y = lat)) + geom_point() + 
  geom_text( aes(label = NO, hjust = 0.5, vjust = -1)) #  +    
 # geom_polygon(data = sorted_points, aes(x = x, y = y), fill = "transparent", color = "red", size = 0.1)
#이거 polygon쓸려면 순서 맞춰줘야 됨

library(sp)


# 좌표값을 가진 점들로 다각형 생성
points <- data.frame(x = cooord$lon, y = cooord$lat,No = cooord$NO)
order_list <- c(59,52,56,57,54,45,44,6,58,63,59)# 순서 맞출려고 넣은거
sorted_points <- points[match(order_list, points$No), c("x", "y", "No")]  #match되는 값을 저장
sorted_points
# 점들의 좌표를 이용하여 다각형 형태를 정의
polygon <- st_polygon(list(as.matrix(sorted_points[, c("x", "y")])))
plot(polygon)
# 면적 계산
area <- st_area(polygon)
#이거 좌표계 lon *lat값이라 작게 나옴 / 알아서 환산해야됨/ 하는법은 ㅁ?ㄹ
# 면적 출력
area








