# Load Library
library(lattice)
library(ggplot2)
# Load the dataset
employment <- read.csv("us_employment.csv")

# Convert Month into a date
employment$Date <- as.Date(
  paste("01", employment$Month),
  format = "%d %Y %b"
)

# Select three employment categories
selected_employment <- subset(
  employment,
  Title %in% c(
    "Total Private",
    "Goods-Producing",
    "Private Service-Providing"
  )
)

# Check the data
head(employment)
head(selected_employment)


# Keep only Total Private employment
private <- subset(
  employment,
  Title == "Total Private"
)

# Base Plots
# Plot 1: Employment over time
plot(
  private$Date,
  private$Employed,
  type = "l",
  main = "U.S. Private Employment Over Time",
  xlab = "Year",
  ylab = "Employment (thousands)"
)

# Plot 2: Distribution of employment
hist(
  private$Employed,
  main = "Distribution of Private Employment",
  xlab = "Employment (thousands)",
  breaks = 25
)


# Lattice Plot
xyplot(
  Employed ~ Date | Title,
  data = selected_employment,
  type = "l",
  layout = c(1, 3),
  main = "Employment Trends by Industry Category",
  xlab = "Year",
  ylab = "Employment (thousands)"
)

# ggplot


ggplot(
  selected_employment,
  aes(x = Date, y = Employed, color = Title)
) +
  geom_line(linewidth = 0.6) +
  labs(
    title = "U.S. Employment Trends by Industry",
    x = "Year",
    y = "Employment (thousands)",
    color = "Industry Category"
  ) +
  theme_minimal()


