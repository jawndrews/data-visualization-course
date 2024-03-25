# install and load library
install.packages("bibliometrix")
library(bibliometrix)

# scopus sample to data frame
M <- convert2df("data/scopus.bib", dbsource="scopus", format="bibtex")

# results and summary
results <- biblioAnalysis(M, sep=";")
summary <- summary(object=results, pause=TRUE)

# plot results
plot(x=results, pause=TRUE)

# author collaboration
NetMatrix <- biblioNetwork(M, analysis="collaboration", network="authors", sep=";")
net <- networkPlot(NetMatrix, n=25, type="kamada", labelsize=1)

# country collaboration
M2 <- metaTagExtraction(M, Field="AU_CO", sep=";")
NetMatrix <- biblioNetwork(M2, analysis="collaboration", network="countries", sep=";")
net <- networkPlot(NetMatrix, n=20, size=TRUE, labelsize=1)

# keyword co-occurrence
NetMatrix <- biblioNetwork(M, analysis="co-occurrences", network="keywords", sep=";")
net <- networkPlot(NetMatrix, n=25, size=TRUE, labelsize=1)
