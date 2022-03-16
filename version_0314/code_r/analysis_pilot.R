library(rcicr)
library(pracma)
library(fields)
library(OpenImageR)
library(ggplot2)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#clean environment
rm(list= ls())

#load data

source("Wimport.R")
mydir = "./exp_data_0315/"
d = W_csv(mydir)

process <- function(x){
  # x = d[[1]]$data
  fname = x$filename
  x = x$data
  gd = x$gender[3]
  # gd = strsplit(as.character(gd),':')[[1]][2]
  idx = x$response %in% c('f','j')
  x = x[idx,]
  c = (x$response == "j") - (x$response == "f") 
  od = 1:length(c)
  rdirs = c("./stimuli/male/rcic_seed_1_time_Mar_14_2022_15_38.Rdata","./stimuli/female/rcic_seed_1_time_Mar_14_2022_15_36.Rdata")
  rdir = rdirs[(gd == "Female") + 1]
  out = list()
  out$x = x
  out$ci = generateCI(od, c, "base", rdir ,save_as_png = TRUE, filename = fname, targetpath = "./cis/")
  return(out)
}


out = matrix(list(),1,length(d))
for (i in 1:length(d)){
  print(sprintf('%d/%d',i, length(d)))
  out[[i]] = process(d[[i]])
}


# Path to rdata-file holding all stimulus parameters, cre- ated when generating stimuli
rdata_female <- "./stimuli/female/rcic_seed_1_time_Mar_14_2022_15_36.Rdata"
load(rdata_female)
#load image
for (i in 1:10){
  stri = strcat("random_", as.character(i))
  c_random = sample(c(-1,1),100, replace=TRUE)
  od_random = 1:100
  ci_ramdon <- generateCI(od_random, c_random, "base", rdata_female,save_as_png = TRUE, filename = stri, targetpath = "./cis_random/")
}


d_1 = d[[1]]$data
d_1 = d_1[-c(1,2,3,4,10,dim(d_1)[1]),]
d_1$trial_index = 1:dim(d_1)[1]


nsub = length(out)
rtmat = matrix(NA, nsub, 100)
for (i in 1:nsub){
  rtmat[i,] = out[[i]]$x$rt
}
rtmat = rtmat /1000

rtmat[rtmat > quantile(rtmat, 0.99)] = NA
avrt = colMeans(rtmat, na.rm = T)
sert = apply(rtmat, 2, function(x){return(sd(x, na.rm = T))})
library(Hmisc)
errbar(1:100, avrt, avrt - sert, avrt + sert, lty = 1)
lines(1:100, avrt)

#

