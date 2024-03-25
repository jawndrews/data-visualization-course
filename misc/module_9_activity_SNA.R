# install and load igraph package
install.packages("igraph")
library("igraph")

# read CSV as a matrix
friends <- read.csv("data/friendsTies.csv", header=TRUE, row.names=1)
friendsMatrix <- as.matrix(friends)

# create an adjacency network
friendsNetwork <- graph.adjacency(friendsMatrix, mode="undirected", diag=FALSE)

# visualize the network
plot(friendsNetwork, vertex.size=15)

# calculate degree centrality for each node
degree(friendsNetwork, mode="all")

# modify the node size based on degree centrality
plot(friendsNetwork, vertex.size=degree(friendsNetwork) *5)

# calculate between centrality for each node
betweenness(friendsNetwork, directed=FALSE)

# modify the node size based on degree centrality
plot(friendsNetwork, vertex.size=betweenness(friendsNetwork))

# change layout
plot(friendsNetwork, layout=layout.random)

# change layout
plot(friendsNetwork, layout=layout.reingold.tilford(friendsNetwork, root="Greta"))

# change layout
plot(friendsNetwork, layout=layout.circle)