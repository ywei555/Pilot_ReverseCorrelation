library(rstudioapi)
library(rcicr)
library(png)
library(tictoc)
library(pracma)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#clean environment
rm(list= ls())

# get base image
bi= readPNG('../img/base.png')
grid::grid.raster(bi)
graphics.off()

# generate stimulus
#tic()
generateStimuli2IFC(list(base ="../img/base.png"), n_trials = 300, img_size = 224, noise_type = 'sinusoid', maximize_baseimage_contrast = T)
#toc()

# generate path of stimulus images 
fprintf("", file = 'a.txt', append = F)
n0 <- function(i, n = 5){
   ni = ceil(log(i+1)/log(10))
   if (ni < n){
     out = rep('0',n - ni)
     out = paste(out, collapse = '')
   }else {
     out = ''
   }
   out = sprintf('%s%d', out, i)
   return(out)
}
for (i in 1:300) {
  fprintf("'code/stimuli/rcic_base_1_%s_inv.png',\n'code/stimuli/rcic_base_1_%s_ori.png',\n", n0(i), n0(i), file = 'a.txt', append = T)
}

# for (a in 0:149){
#    print(sprintf("%d %d", 2*a, 2*a+1 ))
# }

# generate display images in pair
fprintf("", file = 'b.txt', append = F)
for ( ii in 0:299) {
   fprintf("{firstImage: images[%d], secondImage: images[%d]},\n", 2*ii, 2*ii+1, file = 'b.txt', append = T)
}
