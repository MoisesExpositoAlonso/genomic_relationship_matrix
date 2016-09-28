

# file="~/ebio/abt6_projects9/ath_1001G_image_pheno/experiment_218_droughtgwa/polquagwa/topSNPmatrix.hIBS.kinf"
args = commandArgs(trailingOnly=TRUE)

file=args[1]
  
K<-read.table(file,fill=T,header=F)
K[1:15,1:15]
dim(K)

save(K,file=paste0(file,"kinship.RData"))
# 