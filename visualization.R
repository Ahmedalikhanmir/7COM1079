# Load necessary libraries
library(ggplot2)

# Step 1: Load Your Data
d <- read.csv("25.csv")  
colnames(d)  # Display column names
nrow(d)      # Display number of rows

# Step 2: Create a PDF for Multiple Plots
pdf(file="visualization_Ahmad_Ali.pdf", width = 8, height = 7, bg = "white", paper = "A4")

# Create Histogram with Normal Curve Overlay
# Create histogram for Step Count
hist_plot = hist(d$Step.Count, main="Histogram of Step Count", xlab="Step Count",
                 col="green", border="black")

# Overlay normal curve
x_values <- seq(min(d$Step.Count), max(d$Step.Count), length = 100)
y_values <- dnorm(x_values, mean = mean(d$Step.Count), sd = sd(d$Step.Count))
y_values <- y_values * diff(hist_plot$mids[1:2]) * length(d$Step.Count)
lines(x_values, y_values, lwd = 2)

# Add a new page for the scatter plot
# Create a scatter plot with trendline
# Note: Use `print()` to ensure the plot is rendered in the PDF
print(ggplot(d, aes(x=Hours.of.Sleep, y=Calories.burned)) +
        geom_point(color="blue") +  # Add points in blue color
        geom_smooth(method=lm, color="red") +  # Add linear regression line in red
        labs(title="Scatter Plot of Calories Burned vs. Hours of Sleep",
             x="Hours of Sleep", y="Calories Burned") +
        theme_minimal())  # Use a minimal theme for better aesthetics

dev.off()  # Close the PDF device