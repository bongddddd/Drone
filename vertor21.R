# WKB Well-known binary / simple feature geometry를 인코딩 하는데 사용되는 표준 형식 (16진법)
# gis및 공간 데이터베이스에서 geometry object를 저장, 전송하는데 WKB 사용함
# WKT Well-known text 간단한 공간 geometry를 기술하는데 사용

library(sf) # sf는 simple feature geometry column(sfc) 과 attributes(data.frame or tibble)로 구성 됨
# point, linestring, polygon 같은 도형(geometry = 도형 및 그것이 차지하고 있는 공간의 성질) > sfg > sfc / 이게 st_sf로 sfc와 df가 합쳐짐 > sf


ind_point <- st_point(c(0.1, 51.5)) # point is one of geometry types
class(ind_point)
ind_geom <- st_sfc(ind_point, crs = "EPSG:4326") # sfg였던 점을 sfc로 바꿔줌
class(ind_geom)
ind_geom
ind_attrib <- data.frame(      # sf에 넣을 attributes 정보보
  name = "London",   # 줄 바꿀때 뒤에 , 넣어야 되는 듯
  temperature = 25,
  date = as.Date("2017-06-21")
)
lan_sf <- st_sf(ind_attrib, geometry = ind_geom) # st_sf는 (df(속성 정보 가짐), 뒤에는 추가 속성이나 
#sfc(여러개 가능), sfg(df 열의 형식과 데이터 유형을 일치시켜야 함 )) / SpatialDataFrame
class(lan_sf)




point1 <- st_point(c(0, 0))
point2 <- st_point(c(1, 1))
point3 <- st_point(c(2, 2))

# POINT 객체들을 st_multipoint() 함수로 결합하여 Multipoint 객체 생성
multipoint <- st_multipoint(c(point1, point2, point3))


xx <- rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2))

xxx <- st_linestring(xx)
xxx
plot(xxx)

mpolygon <- list(rbind(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))) # 아니 이거 왜 rbind 2번함?
st_multipolygon(mpolygon)
# Error in MtrxSetSet(x, dim, type = "MULTIPOLYGON", needClosed = TRUE) :   / &&은 and 연산자
# is.list(x) && all(vapply(x, is.list, TRUE)) is not TRUE / vapply(X, Y, Z, ...) 벡터 X의 각 요소에에 함수 Y를 적용, 그 결과를 Z형식으로 반환환


polygon_list = list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
st_polygon(polygon_list)
plot(polygon_list)

polygon_border = rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))
polygon_hole = rbind(c(2, 4), c(3, 4), c(3, 3), c(2, 3), c(2, 4))
polygon_with_hole_list = list(polygon_border, polygon_hole)
st_polygon(polygon_with_hole_list)
plot(polygon_with_hole_list)


# 2.2.6 sf는 점, 선, 도형, 다중 점, 선, 면 기하학 모음이 있고 이것은 
# A numeric vector(point), A matrix(점, 다중 점, 선 linestring) 그리고 A list로 구성됨

