## Lecture on Power Analysis
## Time: 4th March, 2025
## Location: Leslokaal 4.5, H. Dunantlaan 2.
## Preparation: Laptop, G-power, R (Rstudio)
## Content:
##    Type I and Type II errors
##    Power and Sample Size
##    Power analysis of between-subject design (example: G-power)
##    Power analysis of within-subject design (example: simulation-based analysis)
##    Hands-on

## References:
# 1) https://rpsychologist.com/d3/nhst/
# 2) https://aaroncaldwell.us/Superpower/
# 3) Lakens, D., & Caldwell, A. R. (2021). 
#    Simulation-Based Power Analysis for Factorial Analysis of Variance Designs. 
#    Advances in Methods and Practices in Psychological Science, 4(1), 251524592095150. 
#    https://doi.org/10.1177/2515245920951503

## G-power and exisiting R package (e.g. pwr) can only handle no more than one within-subject factor.
## When there are more than one within-subject factors, you need to use simulation-based power analysis.
## This script provides an example of power analysis of 2-by-2 within-subject ANOVA using simulation.

# import package
library(Superpower)

# experimental design
string = "2w*2w" # 2 within-subject factors, factor A has 2 level, factor B has 2 level
labelnames = c("FactorA", "A1", "A2", "FactorB", "B1", "B2")

# parameters from literature
n <- 60 # sample size per condition
mu = c(70, 60, 60, 70) # mean values per condition
sd <- c(25, 25, 25, 25) # standard deviation per conditions
r <- 0.5 # hypothetical correlation between dependent variables
alpha_level <- 0.05

# design object
design_result <- ANOVA_design(design = string,
                              n = n, 
                              mu = mu, 
                              sd = sd, 
                              r = r, 
                              labelnames = labelnames)
nsims <- 100 # the number of simulation
simulation_result <- ANOVA_power(design_result, 
                                 alpha_level = alpha_level, 
                                 nsims = nsims)
plot_power(design_result,
           max_n = 100,
           desired_power = 80)
