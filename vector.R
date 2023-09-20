#9/19
# https://r.geocompx.org/spatial-class#vector-data 백터부분
# 목표표 - 사진의 좌표, mkr, ppk 좌표를 비교  > 7/12일과 8/1 내용 비교교

library(sf) # 비 투영 데이터를 투영 데이터로 변환시킬수 있다? / simple features
# sf는 크게 4개로 구성 S2는 구형 기하학 엔진, GEOS는 평면 기하학 엔진진
#Linking to GEOS 3.11.2, GDAL 3.6.2, PROJ 9.2.0; sf_use_s2() is TRUE / sf 가져올때 나오는거거
# 위 내용을 통해 S2가 기본적으로 켜져 있음을 알수있음, sf::sf_use_s2(FALSE)
library(spData)
library(tidyverse) # sf는  tidyverse와 호환성이 있음 / 파이프 연산자도 사용가능!
# st_read - df / sf_read - tibble(dplyr과 호환됨)


world
class(world)
names(world) # geom라는 열이있음/이거는 모든 국가 모형의 좌표를 가긴 열임
#[1] "iso_a2"    "name_long" "continent" "region_un" "subregion" "type"      "area_km2"  "pop"       "lifeExp"   "gdpPercap" "geom"
plot(world)
summary(world["lifeExp"]) # lifeExp     geom / lifeExp만 불렀는데 geom도 나옴 = geom는 기본값임 / the "sticky" behavior
#The "sticky" bahavior 예시
world_mini <- world[1:2,1:3]
world_mini # Geometry type: MULTIPOLYGON Dimension:     XY Bounding box:  xmin: -180 ymin: -18.28799 xmax: 180 ymax: -0.95 
            # Geodetic CRS:  WGS 84 / 지리 정보 메타 데이터터가 추가됨, 그리고 geom열이 붙어있음
# sf는 geom열 이 있는것을 제외하면 데이터프레인과 유사함, 이러한 열은 sfc클래스의 리스트 열임, 
# sfc의 객체는 sfg클래스의 하나 이상의 객체로 구성됨됨
#sfc는 여러개의 sfg클래스의 객체를 관리하는데 사용됨 / simple features column
#sfg는 지리정보를 가진 지오메트리 객체임(ex 폴리곤, 점, 도형등) / simple features geometry

# 2.2.3 조금 위 위 
st_as_sf() # st로 형식 변환
plot() # sf패키지 내용중 하나임 , col = 로 색상 지정 가능 but 색상바 안 생김
# 객체의 각 변수에 대한 하위-그림(sub-plot) 생성

world_asia <- world[world$continent == "Asia", ]
Asia <- st_union(world_asia) # 속성 날려버리고 하나로 통합해버림
plot(Asia)
Asia
world_asia
plot(world["pop"], reset= FALSE)  # reset 막음 / world["pop"] / world에서 pop열을 선택하라! ""는 필수수
plot(Asia, add = TRUE, col = "red" ) # 한 층 (layer) 더해줌 add, col은 색깔지정 근데 저거하면 색 범위 바 안생

#9/20
# 도형을 도형 줌심의 점으로 변환
plot(world["continent"], reset = FALSE)
cex <- sqrt(world$pop) / 10000 # cex = sqrt(world["pop"]) / 100000 => non-numeric-alike variable(s) in data frame: geom /지오메메라고 안됨됨
# world$pop 이거는 df의 열을 추출 /  world["pop"] 이거는 sf의 열을 추출
world_cent <- st_centroid(world, of_largest_polygon =  TRUE) # st_centroid는 폴리곤을 점(도형의 중심 점)으로 변경함
plot(st_geometry(world_cent), add = TRUE, cex = cex) # cex = character expansion
# add = TRUE 현재의 그림위에 새로운 그림을 추가, 겹침 / reset = FALSE 현재의 그림을 유지한 채채로 새 그림을 그림, 겹치는거 X

#인도 강조
india = world[world$name_long == "India", ] # 인도의 관한 모든 행 가져옴 / 대,소문자!
class(india)
plot(india)  # 모든 열마다 하나 plot가 생성됨됨
plot(st_geometry(india), reset = FALSE) # sf객체의 geom 정보를 추출함 > geom정보만 있는 하나의 plot가 생성됨
plot(st_geometry(india), expandBB = c(0, 0.2, 0.1, 1), lwd = 3 ) # expandBB는 바운더리를 확장함, 아래 > 왼 > 위 > 오른 순서
# expandBB = expand Bounding Box, col = color, lwd = line width
plot(st_geometry(world_asia), add = TRUE)











