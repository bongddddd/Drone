# 거창군에서 찍은 사진의 경도x 위도y 고도 z 가 담긴 plot를 만들긴 했는데 시각화 했을때 고도가 너무 왜곡되어있음
# 위,경도는 시분초 단위를 쓰는데 고도는 m단위가 그럼, 이거는 R geo 부분 보고 다시함
#https://r.geocompx.org/spatial-class#vector-data


library(exiftoolr)
library(ggplot2)
# 거창의 timestamps.MKR 파일임임
gch.1.1 <- "E:/Uiry/GCH/GCH-1_1/107_Timestamp.MRK"
gch.1.1
gch.1.2 <- "E:/Uiry/GCH/GCH-1_2/108_Timestamp.MRK"
gch.1.2

# CSV 파일 읽기 위도, 경도, 고도만 가져옴옴
data <- read.csv(gch.1.1, sep = "," , header = FALSE)
data
data <- data[,4:6]
data$V4 <- gsub("V\t","",data$V4)   # gsub == global substitution
data$V5 <- gsub("Lat\t","", data$V5) # 특정 패턴을 찾아 다른 문자열로 교체하는 함수 substitution
data$V6 <- gsub("Lon\t","",data$V6)  # global은 문자열 전체에서 해당 패턴을 찾는다는 뜻뜻
gch1.1 <- data 
gch1.2 <- data
gch1.1
gch1.2
gch1 <- rbind(gch1.1,gch1.2)  # 1,2을 행 방향으로 묶어줌줌
gch1

# ggplot(gch1) + geom_point(aes(x = V5, y = V4))  # x는 경도, y는 위도임 근데 이상하게 휘어지고 줄의 값도 안나옴옴

# 1. 점의 갯수를 1개로, 2. 좌표 붙이기, 사진에서도 뽑기, PPk 한것도 가져와서 비교 ㄱ  
# 내 드론은 6개의 카메라가 한번에 사진을 찍음 > 좌표를 하나로 줄일 생각
i <- 1
while(i <= nrow(gch1)) {       # i가 gch1의 행수보다 길어지면 FALSE가 되면서서 반복이 끝남
if(i == 1) {gch <- gch1[1,]}  # gch를 gch[1,] 을 가진 데이터프레임으로 정의의
  else if((i-1)%%6 == 0) {     # else if((i-1)%%6 == 0){gch <- gch1[i,]} 이거는 걍 재 정의임
    gch <- rbind(gch, gch1[i,])}    # ()와 {} 사이를 떨어트려 놔야함
i <-  i+1
}
ggplot(gch) + geom_point(aes(x = V5, y = V4)) + coord_quickmap() # 이것도 이상함, 아마 3D를 2D로 구현해서 그런듯
# plotly 패키지 설치
install.packages("plotly")
# plotly 패키지 불러오기
library(plotly)

plot_ly(data = gch, x = gch$V5, y =gch$V4, z = gch$V6, type = "scatter3d", size = 0.2) # 단위가 너무 크게 왜곡되서 보임임

# 그리고 저번에 보다만거 벡터부분도 보자자







