library(rcicr)
library(pracma)
library(fields)
library(OpenImageR)
library(plyr)
library(readr)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#clean environment
rm(list= ls())

#load data
# data_aly = read.csv("./exp_data_0315/FinishPilot_RC_Aly_20220314T054142PM.csv")
# data_aly = data_aly[-c(1,2,3,4,10,106),]

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
  out = generateCI(od, c, "base", rdir ,save_as_png = TRUE, filename = fname, targetpath = "./cis/")
  return(out)
}
library(pracma)
out = matrix(list(),1,length(d))
for (i in 1:length(d)){
  print(sprintf('%d/%d',i, length(d)))
   out[[i]] = process(d[[i]])
}














myfiles = list.files(path=mydir, pattern="*.csv", full.names=TRUE)

myfiles
# #import all files to a new dataset
# dat_csv = ldply(myfiles, read_csv)
# dat_csv
ydata<- function(x){ 
  data_x = read.csv(myfiles[x])
  data_x = data_x[-c(1,2,3,4,10,106),])
}

data_1 = ydata(1)
data_2 = ydata(2)
#data_4 = ydata(4)




# Path to rdata-file holding all stimulus parameters, cre- ated when generating stimuli
rdata_female <- "./stimuli/female/rcic_seed_1_time_Mar_14_2022_15_36.Rdata"
load(rdata_female)

#load choice
ychoice<- function(x){
  c_x = (data_x$response == "j") - (data_x$response == "f")
}
c_1 = (data_1$response == "j") - (data_1$response == "f")
c_2 = ychoice(2)

od_1 = c(1:dim(data_1)[1])

#load image
ci_1 <- generateCI(od_1, c_1, "base", rdata_female,save_as_png = TRUE, filename = "1", targetpath = "./cis/")

pilot_1 = flipImage(t(ci_1$combined))

yimage <- function(x){
  image(x, col = gray.colors(10, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL))
}
yimage(pilot_1)
