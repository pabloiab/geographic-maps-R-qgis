#MAKING A MAP WITH SHAPEFILE IN R


##Recommendations 
###Save the R script, the shapefile (.shp),
###and the Excel file with the coordinates in the same folder. 
###Set the working directory: Session/Set Working Directory/To Source File Location.


##Steps

###You will need three packages: tidyverse (for ggplot), readxl, and sf.
###Install these packages in the way you prefer.

library(tidyverse) 
library(readxl)
library(sf)


#Add the shp file
path_shapefile <- "C:/Users/Pablo Alarcon/Desktop/github_map_R" ###Add the path of the .shp file
shp_ecuador_gal <- st_read(path_shapefile)###Function from package "sf" that reads simple
                                          ###features or layers from file or database
                                          ###In this case, with this function you can read 
                                          ###the .shp file located in the previous folder.  


map_coordinates <- read_excel("map_coordinates_pa_1.xlsx")###Function from package "readxl"
                                                          ###used to read the Excel file
                                                          ###in which the coordinates are. 
sf_map <- st_as_sf(map_coordinates, coords = c("Longitude", "Latitude"), crs = 4326) ###Function from package "sf"
                                                                                     ###to make an sf object with the
                                                                                     ###coordinates.

                                                          
metadata_file <- read_excel("metadata_map.xlsx")###Function from package "readxl"
                                                ###used to read the Excel file
                                                ###in which the population/cluster classification are.
sf_map$pop <- (metadata_file$Population)###Add a column with the population/cluster/group classification
                                        ###to the Excel file with the coordinates.  




map1 <- ggplot() + 
  geom_sf(data = shp_ecuador_gal) + 
  geom_sf(data = sf_map, aes(fill = pop, shape = pop, colour = pop), size = 3) +
  scale_shape_manual(values = c(3, 19, 19, 3, 15, 17)) + 
  scale_color_manual(values = c("#6D72B4", "#788E30", "#BFA606", "#E12F89", "#E6341A", "#59BDB5")) +
  theme_classic()
map1
###Use ggplot2 package to plot the .shp and the samples with the coordinates. The function
###geom_sf() is used to visualize the "sf" objects.