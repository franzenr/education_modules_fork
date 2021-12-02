# ---------------
# Scatterplots
# ---------------

# the libraries we'll be using
library(readr)
library(dplyr)
library(ggplot2)

breast_cancer_data <- read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/00451/dataR2.csv")

# basic scatter plot
ggplot(breast_cancer_data, mapping = aes(y=Glucose, x=Age)) +
  geom_point()

# use color to add information about a continuous variable
ggplot(breast_cancer_data, mapping = aes(y=Glucose, x=Age, color = BMI)) +
  geom_point()

# the Classification variable is currently treated as numeric,
# so convert it to a factor
breast_cancer_data <- breast_cancer_data %>%
  mutate(Class_factor = factor(Classification,
                                 levels = c(1,2),
                                 labels = c("Class 1", "Class 2")))

# use color to add information about a categorical variable
ggplot(breast_cancer_data, mapping = aes(y=Glucose, x=Age, color = Class_factor)) +
  geom_point()

# save the colors you want to use as a vector
# you can specify colors by name (e.g. "blue"),
# or use HTML codes, as from https://htmlcolorcodes.com/color-picker/
class_colors <- c(`Class 1` = "#FEB648", `Class 2` = "#3390FF")

# add a layer with scale_color_manual to specify the colors you want to use
ggplot(breast_cancer_data, mapping = aes(y=Glucose, x=Age, color = Class_factor)) +
  geom_point() +
  scale_color_manual(values = class_colors)

# add shape as a second signal to distinguish Classification
ggplot(breast_cancer_data, mapping = aes(y=Glucose, x=Age, color = Class_factor,
                               shape = Class_factor)) +
  geom_point() +
  scale_color_manual(values = class_colors)

# change the theme to theme_bw()
ggplot(breast_cancer_data, mapping = aes(y=Glucose, x=Age, color = Class_factor,
                               shape = Class_factor)) +
  geom_point() +
  scale_color_manual(values = class_colors) +
  theme_bw()

# manually adjust color for a continuous variable
ggplot(breast_cancer_data, mapping = aes(y=Glucose, x=Age, color = BMI)) +
  geom_point() +
  scale_color_gradient(low = "lightgrey", high ="darkred") +
  theme_bw()

# ---------------
# Histograms
# ---------------

# a basic histogram
ggplot(breast_cancer_data, mapping = aes(x=Glucose)) +
  geom_histogram() +
  theme_bw()

# try fewer bins
ggplot(breast_cancer_data, mapping = aes(x=Glucose)) +
  geom_histogram(bins=10) +
  theme_bw()

# try more bins
ggplot(breast_cancer_data, mapping = aes(x=Glucose)) +
  geom_histogram(bins=100) +
  theme_bw()

# use color to show Classification as well
ggplot(breast_cancer_data, mapping = aes(x=Glucose, fill = Class_factor)) +
  geom_histogram(bins=30) +
  scale_fill_manual(values = class_colors) +
  theme_bw()

# plot as two overlapping histograms, rather than stacked bins
# use alpha to control transparency
ggplot(breast_cancer_data, mapping = aes(x=Glucose, fill = Class_factor)) +
  geom_histogram(bins=30, alpha = .5, position = "identity") +
  scale_fill_manual(values = class_colors) +
  theme_bw()

# a histogram of a positively skewed variable
ggplot(breast_cancer_data, mapping = aes(x=Insulin)) +
  geom_histogram(bins=30) +
  theme_bw()

# transform the x-axis to show more detail at lower values
ggplot(breast_cancer_data, mapping = aes(x=Insulin)) +
  geom_histogram(bins=30) +
  scale_x_continuous(trans = "log10") +
  theme_bw()

# ---------------
# Line plots
# ---------------

# to learn more about the Seatbelts dataset
?Seatbelts

# make the time series data into a dataframe, so we can use it for plotting
seatbelt_data <- Seatbelts %>% 
  as.data.frame() %>%
  # add a column specifying the date
  mutate(date = seq(from = as.Date("1969-01-01"), to = as.Date("1984-12-01"), by="month"))

# basic line plot
ggplot(seatbelt_data, mapping = aes(x = date, y=drivers)) + 
  geom_line() +
  theme_bw()


# using color and line type to show groups
# option 1: multiple geom_line layers
ggplot(seatbelt_data, mapping = aes(x = date)) + 
  geom_line(mapping = aes(y=drivers), color = "red", linetype = 1) +
  geom_line(mapping = aes(y=front), color = "blue", linetype = 2) +
  geom_line(mapping = aes(y=rear), color = "darkgreen", linetype = 3) +
  theme_bw()

# option 2: make variable part of aes()
seatbelt_data_long <- seatbelt_data %>% 
  pivot_longer(cols = c(drivers, front, rear), names_to = "seat", values_to = "deaths")
ggplot(seatbelt_data_long, mapping = aes(x=date, y=deaths, color = seat, linetype = seat)) + 
  geom_line() + 
  theme_bw()


# add a reference line
ggplot(seatbelt_data, mapping = aes(x = date, y=drivers)) + 
  geom_line() +
  geom_vline(xintercept = as.Date("1983-01-031"), linetype = 2, color = "red") + 
  theme_bw()

# ---------------
# Trend lines
# ---------------
