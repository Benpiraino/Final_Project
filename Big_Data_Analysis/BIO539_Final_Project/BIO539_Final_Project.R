#this is the R script for the final BIO539 project to 
#convert data gained from GFP-Retention assays performed on the
#flourometer into an analyzable graph and data table

install.packages("ggplot2")
library(ggplot2)
install.packages("tidyverse")
library(tidyverse)
Binding_Assay_Edited <- Binding_Assay_Data_for_R_project_Sheet1[,-1]

ggplot(Binding_Data_For_R_Project_4) + 
  geom_bar( aes(ClpX_Mutant,MqsA_1_76_GFP_Retained), stat="identity", fill="skyblue", alpha=0.7) +
  geom_errorbar( aes(x=ClpX_Mutant, ymin=MqsA_1_76_GFP_Retained-SD, ymax=MqsA_1_76_GFP_Retained+SD),
                 width=0.4, color="orange", alpha=0.9, size=1.3) +
  labs(title = "Binding and Retention of GFP-MqsA 1-76 by ClpX N-terminal Mutants" , 
       x = "ClpX Mutant" , y = "GFP-MqsA 1-76 Retained (A.U.)")

Binding_Data_For_R_Project_4 %>%
  summary(MqsA_1_76_GFP_Retained)
#Provides the mean binding amongst all ClpX mutants

ggplot(ATP_Hydrolysis_Data_for_R_Project_3) + 
  geom_bar( aes(ClpX_Mutant,Avg_Hydrolysis), stat="identity", fill="skyblue", alpha=0.7) +
  geom_errorbar( aes(x=ClpX_Mutant, ymin=Avg_Hydrolysis-SD, ymax=Avg_Hydrolysis+SD),
                 width=0.4, color="orange", alpha=0.9, size=1.3) +
  labs(title = "ATP Hydrolysis Rate at Ten Minutes by ClpX N-terminal Mutants" , 
       x = "ClpX Mutant" , y = "nmol Pi")

ATP_Hydrolysis_Data_for_R_Project_3 %>%
  summary(Avg_Hydrolysis)
#Provides the mean hydrolysis for all mutants

ATP_vs_Binding <- left_join(ATP_Hydrolysis_Data_for_R_Project_3, Binding_Data_For_R_Project_4,
                            by = c("ClpX_Mutant","ClpX_Mutant"))

ggplot(ATP_vs_Binding) + 
  geom_point( aes(MqsA_1_76_GFP_Retained,Avg_Hydrolysis, color = ClpX_Mutant)) +
  theme_bw() + 
  labs(title = "How ClpX N-terminal Mutant ATP Hydrolysis Effects Binding of MqsA 1-76" , 
       x = "GFP-MqsA 1-76 Retained (A.U.)" , y = "ATP Hydrolysis (nmol Pi)", color = " ") +
  theme(legend.position = "right")


ggplot(MqsA_NTD_Degradation_R_Project_2) + 
  geom_bar( aes(ClpX_Mutant,MqsA_NTD_Degradation), stat="identity", fill="skyblue", alpha=0.7) +
  geom_errorbar( aes(x=ClpX_Mutant, ymin=MqsA_NTD_Degradation-SD, ymax=MqsA_NTD_Degradation+SD),
                 width=0.4, color="orange", alpha=0.9, size=1.3) +
  labs(title = "MqsA-NTD Degradation After 180 min. Incubation with ClpX Mutants" , 
       x = "ClpX Mutant" , y = "Percent Substrate Remaining")

MqsA_NTD_Degradation_R_Project_2 %>%
  summary(MqsA_NTD_Degradation)
#Provides mean MqsA degradation rate for all mutants

Degradation_vs_Binding <- left_join(MqsA_NTD_Degradation_R_Project_2, Binding_Data_For_R_Project_4,
                            by = c("ClpX_Mutant","ClpX_Mutant"))

ggplot(Degradation_vs_Binding) + 
  geom_point( aes(MqsA_1_76_GFP_Retained,MqsA_NTD_Degradation, color = ClpX_Mutant)) +
  theme_bw() + 
  labs(title = "How ClpX N-terminal Mutant ATP Hydrolysis Effects Binding of MqsA 1-76" , 
       x = "Percent Substrate Remaining" , y = "GFP-MqsA 1-76 Retained (A.U.)", color = " ") +
  theme(legend.position = "right")

#Binding_Degradation_Hydrolysis <- left_join(Degradation_vs_Binding, ATP_Hydrolysis_Data_for_R_Project_3,
                                            by = c("ClpX_Mutant","ClpX_Mutant"))

#ggplot(Binding_Degradation_Hydrolysis) + 
  geom_point( aes(Avg_Hydrolysis,MqsA_NTD_Degradation, color = MqsA_1_76_GFP_Retained)) +
  theme_bw() + 
  labs(title = "How ClpX N-terminal Mutant ATP Hydrolysis Effects Binding of MqsA 1-76" , 
       x = "nmol Pi" , y = "Percent Substrate Remaining", color = " ") +
  theme(legend.position = "right")


