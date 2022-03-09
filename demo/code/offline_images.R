library(rstudioapi)
library(rcicr)
library(png)
library(tictoc)
library(pracma)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#clean environment
rm(list= ls())

# get base image
bi= readPNG('../code/base_image/base_male.png')
grid::grid.raster(bi)
graphics.off()

# generate stimulus
#tic()
generateStimuli2IFC(list(base ="../code/base_image/base_male.png"), n_trials = 100, img_size = 320, noise_type = 'sinusoid', maximize_baseimage_contrast = T, stimulus_path = "../code/stimuli/Male/")
#toc()

# generate path of stimulus images 
# fprintf("", file = 'a.txt', append = F)
# n0 <- function(i, n = 5){
#    ni = ceil(log(i+1)/log(10))
#    if (ni < n){
#      out = rep('0',n - ni)
#      out = paste(out, collapse = '')
#    }else {
#      out = ''
#    }
#    out = sprintf('%s%d', out, i)
#    return(out)
# }
# for (i in 1:100) {
#   fprintf("'code/stimuli/rcic_base_1_%s_inv.png',\n'code/stimuli/rcic_base_1_%s_ori.png',\n", n0(i), n0(i), file = 'a.txt', append = T)
# }


# # generate display images in pair
# fprintf("", file = 'b.txt', append = F)
# for ( ii in 0:99) {
#    fprintf("{firstImage: images[%d], secondImage: images[%d]},\n", 2*ii, 2*ii+1, file = 'b.txt', append = T)
# }

