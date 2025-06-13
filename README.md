**Project Overview and Purpose**
This project aimed to explore and preprocess a dataset of Kenyan students, analyzing how factors like family income, study habits, attendance, and extracurricular activities influence academic performance. We conducted exploratory data analysis (EDA) by examining numerical and categorical variables, evaluating distributions, identifying outliers (using IQR), and addressing missing data—such as imputing median values for family income and math scores to minimize skewness. Variables like study hours and family income were grouped into meaningful categories, and trends were visualized using histograms, boxplots, and scatter plots. Statistical methods, including chi-squared tests, helped assess associations, while correlation analysis revealed connections between numerical features.

**Instructions to Run the R Script**
1. Required Libraries
Before running the script, ensure you have these R packages installed: install.packages(c("tidyverse","corrplot", "ggplot2","dplyr", "tidyr"))
2. Load the Dataset
Ensure the file kenya_student_data.csv is in your working directory. You can load it using: data <- read_csv("kenya_student_data.csv")
3. Run the Script
Source or run it in your R environment (RStudio / VS Code)

**Summary of key findings**
Study hours, total scores, and family income displayed relatively balanced distributions, with no strong correlations between income and academic performance. Urban students generally studied more weekly, though math performance varied little by gender or achievement level. Outliers in family income were adjusted to limit their influence. Notably, extracurricular activities showed no significant link to academic outcomes. These findings provide a basis for future predictive modeling or policy interventions to enhance education in Kenya.

**Structure of the repository**
Kenya_students_data_project/
├── data/
│ ├── kenya_student_data.csv # Original dataset
│ └── kenya_student_data_preprocessed.csv # Dataset after preprocessing
│
├── scripts/
│ ├── eda_preprocessing.R # R script for EDA and preprocessing
│
├── reports/
│ ├── Assignment 1- EDA and Data Preprocessing.R # R script file
│ └── Assignment 1- EDA and Data Preprocessing.pdf # PDF output (final report)
│
├── figures/
│ ├── study_hours_histogram.png # Example of a plot
│ ├── math_score_boxplot.png # Example of a boxplot
│ ├── family_income_boxplot_before.png
│ ├── family_income_boxplot_after.png
│ └── total_score_scatter.png
│
│ └── README.md # Project overview and instructions


