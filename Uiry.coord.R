install.packages("openxlsx")
library(ggplot2)
library(rgdal)
library(FNN)
library(dplyr)
library(cluster)
library(dist)
library(openxlsx)



Sys.setlocale("LC_ALL", "Korean") # it can make to read korea latter


ccord <- read.csv("C:/RRR/U_XY_rev.csv")   # it brings coordinate

k <- 5
km <- kmeans(ccord[,c("lon","lat")], centers = k) # Use "lon", "lat" to perform clustering

?kmeans
head(km$cluster)
cluster_data <- as.data.frame(ccord[,c("lon","lat")]) # Create a variable with lon, lat
cluster_data$cluster <- as.factor(km$cluster) # add cluster

?as.factor 

ggplot() +  
  geom_point(data = cluster_data, aes(x = lon, y = lat, color = cluster)) +
  coord_equal() + theme_minimal() +
  geom_text(data = ccord, aes(x = lon, y = lat, label = NO,hjust = 0.5, vjust = -1))  # make plot 

x

# save it to excel
wb <- createWorkbook() # create sheet

uiry <- order(ccord$cluster) # Arrange the cluster to match the correct numbers
uiry1 <- ccord[uiry,]  # Use "Uiri" to properly align "ccord"

uiry_scale <- split(uiry1, uiry1$cluster)  #  divide "uiry1" by the same number
uiry_scale


for (cluster_name in names(uiry_scale)) {    # "names" returns string vector
  df <- uiry_scale[[cluster_name]]    # save date split-ed by cluster number
  addWorksheet(wb, sheetName = cluster_name) # add work sheet 
  writeData(wb, sheet = cluster_name, x = df)  
}   

# ?—‘??€ ?ŒŒ?¼ ??€?ž¥
saveWorkbook(wb, "Uiry.xlsx",overwrite = TRUE)

sorted_points





