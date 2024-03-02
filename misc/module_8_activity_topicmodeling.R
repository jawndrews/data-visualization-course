## topic modeling activity ##
# install and load packages
install.packages("tm")
install.packages("SnowballC")
install.packages("topicmodels")

library("tm")
library("SnowballC")
library("topicmodels")


# read abstract csv
textData <- read.csv("data/abstract.csv", header=TRUE, sep=",")

# create a text corpus and filter
textCorpus <- Corpus(DataframeSource(textData))
textCorpus <- tm_map(textCorpus, content_transformer(tolower)) #transform to lowercase
textCorpus <- tm_map(textCorpus, removePunctuation) #remove puncuation
textCorpus <- tm_map(textCorpus, removeNumbers) #remove numbers
textCorpus <- tm_map(textCorpus, removeWords, stopwords("english")) #remove stopwords
textCorpus <- tm_map(textCorpus, stripWhitespace) #remove whitespace
textCorpus <- tm_map(textCorpus, stemDocument) #stem document
myStopwords <- c("can", "say", "one", "way", "tend", "dont", "cant", "didnt")
textCorpus <- tm_map(textCorpus, removeWords, myStopwords)

# create doc-term matrix
dtm <- DocumentTermMatrix(textCorpus)

# number of topics
k <- 15

# LDA using Gibbs sampling method
ldaOut <- LDA(dtm, k, method="Gibbs", control=list(nstart=5, 
              seed=list(2003, 5, 63, 100001, 765), best=TRUE, 
              burnin=4000, iter=2000, thin=500))

# top 10 terms in each topic
ldaOut.terms <- as.matrix(terms(ldaOut, 10))
write.csv(ldaOut.terms, file="data/TopicModelResult.csv")

# probabilities of each document associated with each topic assignment
topicProbabilities <- as.data.frame(ldaOut@gamma)
write.csv(topicProbabilities, file="data/TopicProbabilities.csv")




