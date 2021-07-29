library(tidyverse)
library(sf)

haven::read_dta('gq2013sample.dta') %>% 
  st_as_sf(coords = c("经度", "纬度"), crs = 4326) %>% 
  st_transform('+proj=lcc +lat_1=30 +lat_2=62 +lat_0=0 +lon_0=105 +x_0=0 +y_0=0 +ellps=krass +units=m +no_defs') -> sf

sf %>% 
  st_drop_geometry() %>% 
  bind_cols(sf %>% 
              st_coordinates() %>% 
              as_tibble()) %>% 
  rename(x = X, y = Y) %>% 
  haven::write_dta('兰伯特等角投影.dta')
