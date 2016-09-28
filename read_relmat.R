
# file="1001relmat_2R.txt"
args = commandArgs(trailingOnly=TRUE)
file=args[1]
print(file)

A<-read.table(file,fill=T,header=T)
A<-A[,-1136]
rownames(A)
colnames(A)
length(rownames(A))
length(colnames(A))
rownames(A)=colnames(A)


A[1:10,1:10]
A[1130:1134,1130:1135]

save(A,file=paste0(file,".RData"))
