library(tidyverse)
library(sf)
library(biscale)
library(cowplot)


# 1. Reading vector data --------------------------------------------------

data <- st_read("biscale_bogota_testing.gpkg")
data_biscale <- bi_class(
  data,
  x = CNSST1517L3,
  y = APSPM25MEAN2018L3,
  style = "quantile",
  dim = 3
)

custom_pal3 <- c(
  "1-1" = "#d3d3d3", # low x, low y
  "2-1" = "#ba8890",
  "3-1" = "#9e3547", # high x, low y
  "1-2" = "#8aa6c2",
  "2-2" = "#7a6b84", # medium x, medium y
  "3-2" = "#682a41",
  "1-3" = "#4279b0", # low x, high y
  "2-3" = "#3a4e78",
  "3-3" = "#311e3b" # high x, high y
)

# draw map
map <- ggplot() +
  geom_sf(data = data_biscale, aes(fill = bi_class), color = "white", size = 0.1, show.legend = FALSE) +
  bi_scale_fill(pal = custom_pal3, dim = 3) +
  labs(
    title = "Race and Income in St. Louis, MO",
    subtitle = "Custom Palette"
  ) +
  theme_bw()

# draw legend
legend <- bi_legend(pal = custom_pal3,
                    xlab = "Higher A",
                    ylab = "Higher B",
                    size = 12)
# combine map with legend
finalPlot <- ggdraw() +
  draw_plot(map, 0, 0, 1, 1) +
  draw_plot(legend, -0.01, 0.6, 0.2, 0.2)
finalPlot

# 3D
plot_gg(
  finalPlot,
  multicore = TRUE,
  width = 5,
  height = 5,
  scale = 200,
  phi = 30,
  zoom = 0.5)



