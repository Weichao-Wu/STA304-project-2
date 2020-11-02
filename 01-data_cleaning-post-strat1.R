#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [https://usa.ipums.org/usa/]
# Original Author: Rohan Alexander and Sam Caetano
# Author: Erdong Zhang, Xiaoran Zhang, Weichao Wu, Haoji Ye
# Data: 2 November 2020
# Contact: weichao.wu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data.
setwd("C:/Users/Sammi-Jo/Desktop/PS3")
raw_data <- read_dta("inputs/usa_00002.dta.gz")


# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_data <- 
  raw_data %>% 
  select(#region,
         #stateicp,
         sex, 
         age)#, 
         #race, 
         #hispan,
         #marst, 
         #bpl,
         #citizen,
         #educd,
         #labforce,
         #labforce)
         

#### What's next? ####

## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)

reduced_data <- 
  reduced_data %>%
  count(age) %>%
  group_by(age) 

reduced_data <- 
  reduced_data %>% 
  filter(age != "less than 1 year old") %>%
  filter(age != "90 (90+ in 1980 and 1990)")

reduced_data$age <- as.integer(reduced_data$age)

# Saving the census data as a csv file in my
# working directory
write_csv(reduced_data, "outputs/census_data.csv")



         