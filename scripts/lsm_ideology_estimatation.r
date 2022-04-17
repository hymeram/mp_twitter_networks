#### Set-up ####
library("latentnet") 
library('network')
library('sna')
library('dplyr')
library('ggplot2')

setwd("C:/Users/Alex/Documents/Misc/mp_twitter_networks")

#### Data Prep #####
df <- read.csv('data/like_matrix.csv',encoding="UTF-8")

rownames(df) <- df$X
df <- subset(df, select = -c(X))
diag(df) <- 0 # remove self-loops

#### Network ####
m <- as.matrix(df)
network <- network(m, directed = FALSE, weighted=TRUE)
set.edge.value(network,"weight",m)

#### Latent Space Model #### 
lsm_fit <- ergmm(network ~ rsociality
                   + euclidean(d=2),
                   family="Poisson",
                   verbose=TRUE, 
                   response = "weight")
summary(lsm_fit)

#### Plotting MP ideology ####

#getting the data ready
mp_details <- read.csv('data/MP_Twitter_Accounts_2021.csv',encoding="UTF-8")

ideology <- lsm_fit$mcmc.pmode$Z %>% #extracting latent positions from model
            as.data.frame()
ideology$mp <- rownames(df) 
ideology <- merge(ideology, mp_details, by.x='mp', by.y='display_name') 
ideology <- ideology %>% 
  mutate(party2 = 
           case_when(party == "Conservative" ~ "Conservative", 
                     party == "Labour" ~ "Labour",
                     party == "Liberal Democrat" ~ "Liberal Democrat", 
                     party == "Scottish National Party" ~ "SNP",
                     party == "Sinn Féin " ~ "Sinn Féin", 
                     party == "Democratic Unionist Party" ~"DUP", 
                     TRUE ~ "Other"))

#plotting
ggplot(data=ideology, aes(V1,V2,colour=party2)) + 
  geom_point(size=1) + 
  theme_minimal() + 
  theme(axis.title = element_blank()) +
  scale_colour_manual("Party",
                      values=c("blue","red","orange","gold",
                               "lightgreen","black","grey"), 
                      breaks = c("Conservative", "Labour", "Liberal Democrat", 
                                 "SNP","Sinn Féin","DUP","Other"))
   
  
ggsave("MP_latent_space_plot.png",
       width=10, height=6, units="in",dpi=600,
       bg="white")  