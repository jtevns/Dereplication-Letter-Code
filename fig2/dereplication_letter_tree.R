library(ggtree)
library(ggplot2)
library(ggstance)
library(reshape)
library(dplyr)

tree <- ggtree(read.tree("codon_tree.tre")) + theme_tree2() + geom_tiplab()
tree

all_tmp <- read.csv("all_avg_cov.csv",header = FALSE)
colnames(all_tmp) <- c('id','all_avg')

dRep_default_tmp <- read.csv("dRep_default_avg_cov.csv",header = FALSE)
colnames(dRep_default_tmp) <- c('id','dRep_default_avg')

dRep_gani99_tmp <- read.csv("dRep_gani99_avg_cov.csv",header = FALSE)
colnames(dRep_gani99_tmp) <- c('id','dRep_gani99_avg')

dRep_gani965_tmp <- read.csv("dRep_gani965_avg_cov.csv",header = FALSE)
colnames(dRep_gani965_tmp) <- c('id','dRep_gani965_avg')

pyani_tmp <- read.csv("pyani_avg_cov.csv",header = FALSE)
colnames(pyani_tmp) <- c('id','pyani_avg')

abund <- full_join(all_tmp,dRep_default_tmp)
abund <- full_join(abund,dRep_gani99_tmp)
abund <- full_join(abund,dRep_gani965_tmp)
abund <- full_join(abund,pyani_tmp)

colnames(abund) <- c("id","all","dRep_default","gani_99","gani_96.5","pyani")
#melt abund and add id column

long_abund <- melt(abund,id = 'id')
temp <- long_abund
temp$variable <- paste(temp$variable,"empty",sep = "_")
temp$value <- 2000 - temp$value

long_abund <- rbind(long_abund,temp)

#split DF by derep strat
split_df <- split(long_abund,long_abund$variable)

#generate facetted plots


f1 <- facet_plot(tree, panel = "All Genomes" , 
                 data = as.data.frame(rbind(split_df$all,split_df$all_empty)), geom = geom_barh,
                 mapping = aes(x=value,fill = variable),
                 stat='identity',
                 position = position_stack(reverse = TRUE),
                 color = "black") #+ scale_fill_manual(values=c(all="black",all_empty= "white"))

f2 <- facet_plot(f1, panel = "dRep Default" , 
                 data = as.data.frame(rbind(split_df$dRep_default,split_df$dRep_default_empty)), geom = geom_barh,
                 mapping = aes(x=value,fill = variable),
                 stat='identity',
                 position = position_stack(reverse = TRUE),
                 color = "black") #+ scale_fill_manual(values=c(dRep_default="black",dRep_default_empty= "white"))

f3 <- facet_plot(f2, panel = "Pyani ANIb" , 
                 data = as.data.frame(rbind(split_df$pyani,split_df$pyani_empty)), geom = geom_barh,
                 mapping = aes(x=value,fill = variable),
                 stat='identity',
                 position = position_stack(reverse = TRUE),
                 color = "black") #+ scale_fill_manual(values=c(pyani="black",pyani_empty= "white"))

f4 <- facet_plot(f3, panel = "dRep gani 96.5" , 
                 data = as.data.frame(rbind(split_df$gani_96.5,split_df$gani_96.5_empty)), geom = geom_barh,
                 mapping = aes(x=value,fill = variable),
                 stat='identity',
                 position = position_stack(reverse = TRUE),
                 color = "black") #+ scale_fill_manual(values=c(dRep_gani96.5="black",dRep_gani96.5_empty= "white"))

f5 <- facet_plot(f4, panel = "dRep gani 99" , 
                 data = as.data.frame(rbind(split_df$gani_99,split_df$gani_99_empty)), geom = geom_barh,
                 mapping = aes(x=value,fill = variable),
                 stat='identity',
                 position = position_stack(reverse = TRUE),
                 color = "black") #+ scale_fill_manual(values=c(dRep_gani99="black",dRep_gani99_empty= "white"))

f5 

test <- geom_barh()
