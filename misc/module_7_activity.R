## xml activity ##
install.packages("xml2")
library("xml2")

# read xml
xmldoc <- read_xml("data/search_results.xml")

# extract abstracts
abstract <- xml_text(xml_find_all(xmldoc, "//ab"))

# clean abstracts
abstract <- trimws(abstract)

# generate doc IDs
doc_ids <- seq_along(abstract)

# combine abstract with doc IDs into a data frame
abstract_data <- data.frame(doc_id = doc_ids, text = abstract)

# write to a csv file with headers
write.csv(abstract_data, file = "abstract.csv", row.names = FALSE)



## text pre-processing activity ##
install.packages("tm")
install.packages("SnowballC")
library("tm")
library("SnowballC")

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



## calculate term frequency ##
# create doc-term matrix
dtm <- DocumentTermMatrix(textCorpus)

# collapse matrix
freq <- colSums(as.matrix(dtm))

# length should be total num of terms
length(freq)

# create sort order (descending)
ord <- order(freq, decreasing=TRUE)

# list terms in decreasing order of freq and save to csv
write.csv(freq[ord], file="term_freq.csv")










