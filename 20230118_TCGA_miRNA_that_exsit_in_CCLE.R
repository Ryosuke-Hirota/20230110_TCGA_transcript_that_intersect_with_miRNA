# this script is to investigate TCGA miRNA and transcript as pri-miRNA (hg38 gencode v36) that exsit in CCLE (hg37 gencode v19)
# made 2023/01/17

# import list of transcript than intersect with miRNA in TCGA
# this list is located at ""
setwd("C:/Rdata/20230110_TCGA_transcript_that_intersect_with_miRNA")
tcga.list <-read.table("TCGA_hg38_transcript_intersect_with_miRNA.txt",sep="\t",header = F,stringsAsFactors = F)
tcga.list[,8] <-tcga.list[,8]+1
tcga.list <-tcga.list[tcga.list[,2]!=tcga.list[,8]&tcga.list[,3]!=tcga.list[,9],]
tcga.list <-tcga.list[,c(4,11)]

tcga.list <-subset(tcga.list,!duplicated(tcga.list))

# import table of CCLE pri-miRNA
# this table is located at ""
setwd("C:/Rdata/CCLE_data")
ccle.miRNA.list <-read.table("table_of_pri-miRNA_of_CCLE.txt",sep="\t",header = T,stringsAsFactors = F)
ccle.pri.miRNA <-unique(ccle.miRNA.list[,2])

# extract miRNAs exist in CCLE
for (i in 1:length(ccle.pri.miRNA)) {
  df <-tcga.list[tcga.list[,1]==ccle.pri.miRNA[i],]
  if(i==1){
    remain.df <-df
  }else{
    remain.df <-rbind(remain.df,df)
  }
}

# output
colnames(remain.df) <-c("miRNA","transcript")
setwd("C:/Rdata/20230110_TCGA_transcript_that_intersect_with_miRNA")
write.table(remain.df,"list_of_TCGA_pri-miRNA_that_exsit_in_CCLE.txt",sep="\t",row.names = F,quote = F)
