## ----Install required libraries---------
install.packages(c("tidyverse","corrplot", "ggplot2","dplyr", "tidyr"))

#Load the libraries
library(tidyverse)
library(corrplot)
library(ggplot2)
library(dplyr)
library(tidyr)

## ----Q1. Load and Inspect the Dataset-----------
#Load the dataset
data <- read_csv("kenya_student_data.csv")

#display data structure
cat("\n Structure of the data \n")
str(data)

# display first few rows
cat("\n First 6 rows of the data \n")
head(data)


## ----Q1.How many numerical and categorical variables are there-------------
#Count how many columns are numeric vs categorical
numeric_count <- sum(sapply (data, class) == "numeric")

categorical_count <- sum(sapply (data, class) == "character")

# Output the counts
cat("📊 Numeric columns:", numeric_count, "\n")
cat("🔤 Categorical columns:", categorical_count, "\n")


## ----Q2: Summary Stats for Numerical Variables-----------
#Summary Stats for Numerical Variables
data |> select(where(is.numeric)) |>  summary()



## ----Q3: Bar Plot of academic_performance-------------
# View class distribution - class counts
table(data$academic_performance)

#Plot bargraph
data |> ggplot(aes(academic_performance)) +
        geom_bar(fill = "grey") +
        labs(title = "Distribution of Academic Performance",
            x = "Academic Performance",
            y = "Count") +
         theme_minimal()


## ----Q4: Histogram of study_hours_weekly (Urban vs Rural)---------------------
#Histogram of study hours by residency
data |> ggplot(aes(study_hours_weekly)) +
        geom_histogram (binwidth = 2, fill = "darkorange", color = "white") +
        facet_wrap(~residency) +
        labs(title = "Study Hours by Residency", 
             x = "Study Hours per Week",
            y = "Number of Students") +
        theme_minimal()


## ----Q5: Boxplots of math_score by performance and gender--------------------
#Boxplots of math_score by performance and gender
data |> ggplot(aes(x = academic_performance, y = math_score)) +
        geom_boxplot(aes(fill = gender)) +
        labs (title= "Math Score by Academic Performance and Gender",
                x = "Academic Performance",
                y = "Math Score") +
        theme_minimal()


## ----Q6: Proportions in extracurricular_activities and faculty----------------
# Proportions for extracurricular_activities
data |> count(extracurricular_activities) |> 
        mutate(prop = n/ sum(n) *100)

# Proportions for faculty
data |> count(faculty) |> 
        mutate(prop = n/ sum(n) *100)


## ----Q7: Correlation Matrix (exclude student_id)------------------------------
# Select the numeric variables, excluding 'student_id'
num_data <- data |>  
    select(where(is.numeric), -student_id)

# Compute correlation matrix
corr_matrix <- cor(num_data, use = "complete.obs")

# Visualize correlation matrix using a heatmap
corrplot(corr_matrix, method = "color", type = "lower")

corrplot(corr_matrix, method = "color", type = "lower", 
         tl.col = "red", tl.srt = 45, addCoef.col = "black",
         number.cex = 0.7,  col = colorRampPalette(c("blue", "white", "red"))(200))



## ----Q8: Chi-squared Test (internet_access vs academic_performance)---------------
# Create a contingency table
cont_table <- table(data$internet_access, data$academic_performance)

# Run chi-squared test
chisq.test(cont_table)



## ----Q9: Identify Missing Values--------------------
# Calculate number and percentage of missing values per column
missing_summary <- sapply(data, function(x) sum(is.na(x)))
missing_percent <- round(missing_summary / nrow(data) *100, 2)

# Combine and display
missing_report <- data.frame( Column = names(missing_summary),
                              Missing_Count = missing_summary,
                              Missing_Percent = missing_percent)

# Show only columns with missing data
missing_report[missing_report$Missing_Count > 0, ]



## ----Q10: Impute family_income and math_score with median--------------------
# Impute family_income with median
median_income <- median(data$family_income, na.rm = TRUE)
data$family_income[is.na(data$family_income)] <- median_income

# Impute math_score with median
median_math <- median(data$math_score, na.rm = TRUE)
data$math_score[is.na(data$math_score)] <- median_math



## ----Q11: Impute attendance_rate with mean + Histogram-----------------------
# Histogram before imputation
data |> ggplot(aes(attendance_rate)) +
      geom_histogram(fill = "skyblue", color = "black", na.rm = TRUE) +
      labs(title = "Attendance Rate Before Imputation", x = "Attendance Rate", y = "Count")

# Impute missing values with the mean
data$attendance_rate[is.na(data$attendance_rate)] <- mean(data$attendance_rate, na.rm = TRUE)

# Histogram after imputation
data |> ggplot(aes(attendance_rate)) +
        geom_histogram(fill = "tomato", color = "black") +
        labs(title = "Attendance Rate After Imputation", x = "Attendance Rate", y = "Count")



## ----Q12: Detect Outliers (IQR method)--------------------------------------
# Compute Q1, Q3, and IQR
Q1 <- quantile(data$family_income, 0.25, na.rm = TRUE)
Q3 <- quantile(data$family_income, 0.75, na.rm = TRUE)
IQR<- Q3 - Q1

# Define outlier thresholds
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR

# Detect outliers
outliers <- length(data$family_income[data$family_income < lower_bound | data$family_income > upper_bound])

# Print results
cat("Number of outliers in family income:", outliers, "\n")



## ----Q13: Cap Outliers + Boxplot------------------------------------
# Cap values 
data$family_income_capped <- data$family_income
data$family_income_capped[data$family_income > upper_bound] <- upper_bound
data$family_income_capped[data$family_income < lower_bound] <- lower_bound

# Prepare data for plotting
income_df <- data |> 
  select(family_income, family_income_capped) |> 
  pivot_longer(cols = everything(), names_to = "Version", values_to = "Income") |> 
  mutate(Version = recode(Version,
                          "family_income" = "Before Capping",
                          "family_income_capped" = "After Capping"))

# Plot boxplots
ggplot(income_df, aes(x = Version, y = Income, fill = Version)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 1, width = 0.6) +
  labs(title = "Boxplot of Family Income Before and After Capping",
       x = "", y = "Family Income") +
  theme_minimal()



## ----Q14.Discretize study_hours_weekly into bins---------------------------------
# use the cut() function to categorize the continuous variable; discretize into 4 bins ***
data$study_hours_binned <- cut(data$study_hours_weekly,
                      breaks = c(-Inf, 5, 15, 25, Inf), # Define fixed breakpoints
                      labels = c("Low", "Moderate", "High", "Very High"), right = TRUE)

# Bar plot of the binned variable
data |> ggplot(aes(study_hours_binned)) +
        geom_bar(fill = "steelblue") +
        #facet_wrap(~academic_performance) +
        labs(title = "Study Hours per Week (Binned)",
             x = "Study Hours Category",
            y = "Number of Students") +
       theme_minimal()



## ----Q15. Discretize family_income into quartiles------------------------------
# Discretize into quartiles with meaningful labels
data <- data |> 
  mutate(family_income_binned = cut(family_income,
    breaks = quantile(family_income, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE),
    include.lowest = TRUE,
    labels = c("Low", "Medium-Low", "Medium-High", "High")))

# correlation with academic_performance using contingency table (counts)
cont_table <- table(data$family_income_binned, data$academic_performance)
cont_table



## ----Q16. Create average score------------------------------------------------
# Create total_score by averaging the three subject scores
data$total_score <- rowMeans(data[, c("math_score", "science_score", "english_score")], na.rm = TRUE)

# Plot the distribution of total_score
data |> ggplot(aes(x = total_score)) +
        geom_histogram(binwidth = 4, fill = "salmon", color = "black") +
      labs(title = "Distribution of Total Score",
       x = "Total Score (Average of 3 Subjects)",
       y = "Number of Students") +
      theme_minimal()



## ----Q17. Contingency table-------------------------------------
#Contingency table for extracurricular_activities vs. academic_performance
activity_perf <- table(data$extracurricular_activities, data$academic_performance)
activity_perf



## ----Q18: Scatter Plot---------------------------------
#scatter plot between study_hours_weekly and total_score colored by residency
data |> ggplot(aes(study_hours_weekly, total_score, color = residency)) +
        geom_point(alpha = 0.6) +
        geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
        labs(title = "Study Hours vs Total Score by Residency",
              x = "Weekly Study Hours",
              y = "Total Score") +
        theme_minimal()



## ----Save preprocessed dataset----------------------
#Saving preprocessed dataset
write_csv(data, "kenya_student_data_preprocessed.csv")


