library(rcicr)
library(pracma)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#clean environment
rm(list= ls())

data_aly = read.csv("./exp_data_0315/FinishPilot_RC_Aly_20220314T054142PM.csv")
# data_sw = read.csv("./data/pilot_sw.csv")
# data_yw = read.csv("./data/pilot_yw.csv")

data_aly = data_aly[-c(1,2,3,4,10,106),]
# data_dw = data_dw[3:dim(data_dw)[1],]
# data_sw = data_sw[3:dim(data_sw)[1],]
# data_yw = data_yw[3:dim(data_yw)[1],]

# Path to rdata-file holding all stimulus parameters, cre- ated when generating stimuli
rdata <- "./stimuli/female/rcic_seed_1_time_Mar_14_2022_15_36.Rdata"
load(rdata)

c_aly = (data_aly$response == "j") - (data_aly$response == "f")
# c_dw = (data_dw$response == "j") - (data_dw$response == "f")
# c_sw = (data_sw$response == "j") - (data_sw$response == "f")
# c_yw = (data_yw$response == "j") - (data_yw$response == "f")


library(stringr)
library(pracma)
od_aly = c(1:100)
#od_dw = c(arrayfun(function(x)str2num(x[4]),str_split(data_dw$firstImage,'_')))
# od_sw = c(arrayfun(function(x)str2num(x[4]),str_split(data_sw$firstImage,'_')))
# od_yw = c(arrayfun(function(x)str2num(x[4]),str_split(data_yw$firstImage,'_')))


ci_aly <- generateCI(od_aly, c_aly, "base", rdata)
#ci_dw <- generateCI(od_dw, c_dw, "base", rdata)
# ci_sw <- generateCI(od_sw, c_sw, "base", rdata)
# ci_yw <- generateCI(od_yw, c_yw, "base", rdata)
# ci_w <- generateCI(c(od_dw, od_sw, od_yw), c(c_dw, c_sw, c_yw), "base", rdata)

#ci2_dw <- generateCI(od_dw, -c_dw, "base", rdata)
# ci2_sw <- generateCI(od_sw, -c_sw, "base", rdata)
# ci2_yw <- generateCI(od_yw, -c_yw, "base", rdata)
# ci2_w <- generateCI(c(od_dw, od_sw, od_yw), -c(c_dw, c_sw, c_yw), "base", rdata)
library(fields)
library(OpenImageR)
a = flipImage(t(ci_aly$combined))
yimage <- function(x){
  image(x, col = gray.colors(10, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL))
}
yimage(a)
# par(mfrow = c(2,3))
# image(flipImage(t(ci_dw$combined)), col = gray.colors(10, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL))
# image(flipImage(t(ci_sw$combined)), col = gray.colors(10, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL))
# image(flipImage(t(ci_yw$combined)), col = gray.colors(10, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL))
# 
# image(flipImage(t(ci2_dw$combined)), col = gray.colors(10, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL))
# image(flipImage(t(ci2_sw$combined)), col = gray.colors(10, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL))
# image(flipImage(t(ci2_yw$combined)), col = gray.colors(10, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL))
# 
# par(mfrow = c(2,1))
# image(flipImage(t(ci_w$combined)), col = gray.colors(10, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL))
# image(flipImage(t(ci2_w$combined)), col = gray.colors(10, start = 0.3, end = 0.9, gamma = 2.2, alpha = NULL))

