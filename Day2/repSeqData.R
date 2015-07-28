
## ------------------------------------------------------------------------
library(IRanges)
ir <- IRanges(
start = c(7,9,12,14,22:24), 
end=c(15,11,13,18,26,27,28))
str(ir)

## ------------------------------------------------------------------------
ir

## ------------------------------------------------------------------------
ir <- IRanges(
start = c(7,9,12,14,22:24), 
end=c(15,11,13,18,26,27,28),names=LETTERS[1:7])
ir

## ------------------------------------------------------------------------
ir[1:2]
ir[c(2,4,6)]

## ------------------------------------------------------------------------
start(ir)
end(ir)
width(ir)

## ------------------------------------------------------------------------
width(ir) == 5
ir[width(ir)==5]

## ------------------------------------------------------------------------
start(ir) > 10
end(ir) < 27
ir[start(ir) > 10]

## ------------------------------------------------------------------------
ir[end(ir) < 27]
ir[start(ir) > 10 & end(ir) < 27]


## ------------------------------------------------------------------------
ir
shift(ir, 5)


ir
resize(ir,3)


cvg <- coverage(ir)
cvg
as.vector(cvg)



ir3 <- IRanges(start = c(1, 14, 27), end = c(13,
    18, 30),names=c("X","Y","Z"))
ir3



query <- ir
subject <- ir3
ov <- findOverlaps(query, subject)
ov

## ------------------------------------------------------------------------
queryHits(ov)

## ------------------------------------------------------------------------
subjectHits(ov)

## ------------------------------------------------------------------------
query[queryHits(ov)[1]]
subject[subjectHits(ov)[1]]


query[queryHits(ov)[2]]
subject[subjectHits(ov)[2]]


query[queryHits(ov)[3]]
subject[subjectHits(ov)[3]]


countOverlaps(query,subject)

## ------------------------------------------------------------------------
countOverlaps(subject,query)

## ------------------------------------------------------------------------
findOverlaps(query,subject,type="within")


findOverlaps(query,subject,type="within")


intersect(ir,ir3)



setdiff(ir,ir3)


rand <- sapply(1:100, function(x) paste(sample(c("A", "T", 
          "G", "C"), sample(10:20),replace=TRUE),
          collapse=""))
randomStrings <- rand

## ------------------------------------------------------------------------
library(Biostrings)
myseq <- DNAStringSet(randomStrings)
myseq

## ------------------------------------------------------------------------
str(myseq)

## ------------------------------------------------------------------------
myseq[1:5]

## ------------------------------------------------------------------------
width(myseq)

head(as.character(myseq))

## ------------------------------------------------------------------------
myseq[width(myseq)>19]

## ------------------------------------------------------------------------
myseq[subseq(myseq,1,3) == "TTC"]

## ------------------------------------------------------------------------
af <- alphabetFrequency(myseq, baseOnly=TRUE)
head(af)

## ----fig.height=3--------------------------------------------------------
myseq[af[,1] ==0,]
boxplot(af)


## ----warning=FALSE-------------------------------------------------------
reverse(myseq)
reverseComplement(myseq)
translate(myseq)

library(BSgenome)
head(available.genomes())

## ------------------------------------------------------------------------
ag <- available.genomes()
ag[grep("Hsapiens",ag)]

## ----message=FALSE-------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg19)
hg19 <- BSgenome.Hsapiens.UCSC.hg19::Hsapiens
hg19

## ------------------------------------------------------------------------
head(names(hg19))
chrX <- hg19[["chrX"]]
chrX
alphabetFrequency(chrX,baseOnly=TRUE)

## ------------------------------------------------------------------------
tp53 <- getSeq(hg19, "chr17", 7577851, 7590863)
tp53
as.character(tp53[1:10])
alphabetFrequency(tp53,baseOnly=TRUE)
subseq(tp53, 1000,1010)

## ------------------------------------------------------------------------
system.time(tp53 <- getSeq(hg19, "chr17", 7577851, 7598063))

## ------------------------------------------------------------------------
translate(subseq(tp53, 1000,1010))
reverseComplement(subseq(tp53, 1000,2000))

## ----message=FALSE-------------------------------------------------------
library(GenomicRanges)
gr <- GRanges(c("A","A","A","B","B","B","B"), ranges=ir)
gr

## ------------------------------------------------------------------------
mcols(gr) <- data.frame(Count = runif(length(gr)), Gene =sample(LETTERS,length(gr)))
gr
gr[mcols(gr)$Count > 0.5]

## ------------------------------------------------------------------------
mygene <- GRanges("chr17", ranges=IRanges(7577851, 7598063))
myseq <- getSeq(hg19, mygene)
myseq
tp53

## ----echo=FALSE----------------------------------------------------------
suppressPackageStartupMessages(library(pasillaBamSubset))
suppressPackageStartupMessages(library(Rsamtools))

mybam <- untreated3_chr4()
options(width=60)

## ----message=FALSE-------------------------------------------------------
library(GenomicAlignments)
bam <- readGAlignments(mybam,use.names = TRUE)
str(bam)

## ------------------------------------------------------------------------
bam


## ------------------------------------------------------------------------
length(bam)
bam[1:5]
bam[sample(1:length(bam),5)]

## ------------------------------------------------------------------------
table(strand(bam))
summary(width(bam))
range(start(bam))
head(cigar(bam))

## ------------------------------------------------------------------------
gr <- GRanges("chr4", IRanges(start = 20000, end = 20100))
gr
findOverlaps(gr,bam)

## ----echo=FALSE----------------------------------------------------------
morereads <- bam[subjectHits(findOverlaps(flank(gr,130,both=TRUE),bam))]
subreads <- bam[subjectHits(findOverlaps(gr,bam))]
fll <- rep("white", length(morereads))
Overlap <-names(morereads) %in% names(subreads)
rname <- 1:length(morereads)
tracks(autoplot(gr),autoplot(morereads, aes(fill=Overlap,labels=rname)))

## ------------------------------------------------------------------------
bam.sub <- bam[bam %over% gr]
bam.sub


## ------------------------------------------------------------------------
gr <- GRanges("4", IRanges(start = 20000, end = 20100))
gr
findOverlaps(gr,bam)

## ------------------------------------------------------------------------
gr
gr <- renameSeqlevels(gr, c("4"="chr4"))
gr

## ----eval=FALSE----------------------------------------------------------
## ?ScanBamParam

## ------------------------------------------------------------------------
bam.extra <- readGAlignments(file=mybam,param=ScanBamParam(what=c("mapq","qual","flag")))
bam.extra[1:5]
table(mcols(bam.extra)$flag)

## ------------------------------------------------------------------------
dupReads <- readGAlignments(file=mybam,param=ScanBamParam(scanBamFlag(isDuplicate = TRUE)))
nodupReads <- readGAlignments(file=mybam,param=ScanBamParam(scanBamFlag(isDuplicate = FALSE)))
allreads <- readGAlignments(file=mybam,param=ScanBamParam(scanBamFlag(isDuplicate = NA)))
length(dupReads)
length(nodupReads)
length(allreads)
length(allreads) - length(dupReads)

## ------------------------------------------------------------------------
bam.sub2 <-
  readGAlignments(file=mybam,param=ScanBamParam(which=gr),use.names = TRUE)
length(bam.sub2)
bam.sub2

