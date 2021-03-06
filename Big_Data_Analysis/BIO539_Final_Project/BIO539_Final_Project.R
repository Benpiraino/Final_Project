#this is the R script for the final BIO539 project to observe the data obtained on 
#ClpX N-terminal mutations and their effects on MqsA substrate degradation, and analyze it
#for correlations between mutants and various assays.

install.packages("ggplot2")
library(ggplot2)
install.packages("tidyverse")
library(tidyverse)
install.packages("latexpdf")
library(latexpdf)
tinytex::install_tinytex()

Binding_Data_For_R_Project_4 <- read_csv("Big_Data_Analysis/BIO539_Final_Project/Binding_Data_For_R_Project_4.csv")
ATP_Hydrolysis_Data_for_R_Project_3 <- read_csv("Big_Data_Analysis/BIO539_Final_Project/ATP Hydrolysis Data for R Project 3.csv")
MqsA_NTD_Degradation_R_Project_2 <- read_csv("Big_Data_Analysis/BIO539_Final_Project/MqsA_NTD_Degradation_R_Project_2.csv")

ggplot(Binding_Data_For_R_Project_4) + 
  geom_bar( aes(ClpX_Mutant,MqsA_1_76_GFP_Retained), stat="identity", fill="skyblue", alpha=0.7) +
  geom_errorbar( aes(x=ClpX_Mutant, ymin=MqsA_1_76_GFP_Retained-SD, ymax=MqsA_1_76_GFP_Retained+SD),
                 width=0.4, color="orange", alpha=0.9, size=1.3) +
  labs(title = "Binding and Retention of GFP-MqsA 1-76 by ClpX N-terminal Mutants" , 
       x = "ClpX Mutant" , y = "GFP-MqsA 1-76 Retained (A.U.)")

Binding_Data_For_R_Project_4 %>%
  summary(MqsA_1_76_GFP_Retained)

ggplot(ATP_Hydrolysis_Data_for_R_Project_3) + 
  geom_bar( aes(ClpX_Mutant,Avg_Hydrolysis), stat="identity", fill="skyblue", alpha=0.7) +
  geom_errorbar( aes(x=ClpX_Mutant, ymin=Avg_Hydrolysis-SD, ymax=Avg_Hydrolysis+SD),
                 width=0.4, color="orange", alpha=0.9, size=1.3) +
  labs(title = "ATP Hydrolysis Rate at Ten Minutes by ClpX N-terminal Mutants" , 
       x = "ClpX Mutant" , y = "nmol Pi")

ATP_Hydrolysis_Data_for_R_Project_3 %>%
  summary(Avg_Hydrolysis)

ggplot(MqsA_NTD_Degradation_R_Project_2) + 
  geom_bar( aes(ClpX_Mutant,MqsA_NTD_Degradation), stat="identity", fill="skyblue", alpha=0.7) +
  geom_errorbar( aes(x=ClpX_Mutant, ymin=MqsA_NTD_Degradation-SD, ymax=MqsA_NTD_Degradation+SD),
                 width=0.4, color="orange", alpha=0.9, size=1.3) +
  labs(title = "MqsA-NTD Degradation After 180 min. Incubation with ClpX Mutants" , 
       x = "ClpX Mutant" , y = "Percent Substrate Remaining")

MqsA_NTD_Degradation_R_Project_2 %>%
  summary(MqsA_NTD_Degradation)


ATP_vs_Binding <- left_join(ATP_Hydrolysis_Data_for_R_Project_3, Binding_Data_For_R_Project_4,
                            by = c("ClpX_Mutant","ClpX_Mutant"))

ggplot(ATP_vs_Binding) + 
  geom_point( aes(MqsA_1_76_GFP_Retained,Avg_Hydrolysis, color = ClpX_Mutant)) +
  theme_bw() + 
  labs(title = "How ClpX N-terminal Mutant ATP Hydrolysis Effects Binding of MqsA 1-76" , 
       x = "GFP-MqsA 1-76 Retained (A.U.)" , y = "ATP Hydrolysis (nmol Pi)", color = " ") +
  theme(legend.position = "right")

Degradation_vs_Binding <- left_join(MqsA_NTD_Degradation_R_Project_2, Binding_Data_For_R_Project_4,
                            by = c("ClpX_Mutant","ClpX_Mutant"))

ggplot(Degradation_vs_Binding) + 
  geom_point( aes(MqsA_1_76_GFP_Retained,MqsA_NTD_Degradation, color = ClpX_Mutant)) +
  theme_bw() + 
  labs(title = "How the binding of GFP-MqsA 1-76 by ClpX N-terminal mutants relates to MqsA-NTD degradation" , 
       x = "GFP-MqsA 1-76 Retained (A.U.)" , y = "Percent Substrate Remaining", color = " ") +
  theme(legend.position = "right")

Degradation_vs_Hydrolysis <- left_join(MqsA_NTD_Degradation_R_Project_2, ATP_Hydrolysis_Data_for_R_Project_3,
                                       by = c("ClpX_Mutant", "ClpX_Mutant"))

ggplot(Degradation_vs_Hydrolysis) + 
  geom_point( aes(Avg_Hydrolysis,MqsA_NTD_Degradation, color = ClpX_Mutant)) +
  theme_bw() + 
  labs(title = "How ClpX N-terminal Mutant ATP Hydrolysis Effects Degradation of MqsA-NTD" , 
       x = "ATP Hydrolysis (nmol Pi)" , y = "Percent Substrate Remaining", color = " ") +
  theme(legend.position = "right")


