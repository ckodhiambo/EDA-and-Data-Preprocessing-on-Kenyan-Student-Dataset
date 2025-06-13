**Project Overview**
This project focuses on exploratory data analysis (EDA) and data preprocessing for a dataset of Kenyan students. The dataset (kenya_student_data.csv) contains various features such as: Demographic attributes (e.g., gender, residency, family income), Academic metrics (e.g., math score, science score, English score, attendance rate, academic performance) and Lifestyle factors (e.g., study hours, extracurricular activities, internet access). The project systematically explores and cleans this data to uncover insights about student performance patterns, detect and handle missing or outlier values, and prepare the dataset for further analysis or modeling.

**Purpose of the Project**
The primary goals of this project are:
  1. Understand the characteristics of the dataset.
    Explore distributions of variables (e.g., study hours, family income) and identify relationships between variables (e.g., study habits vs. scores).

  2. Handle data quality issues
    Detect and impute missing values (e.g., family_income, attendance_rate) and identify and cap outliers (e.g., extreme family_income values)

  3. Create derived features
    Total academic score and binned versions of continuous variables (e.g., study hours categories)

  4. Generate actionable insights
    Examine associations (e.g., internet access vs. performance) and reveal trends by demographics (e.g., urban vs. rural differences)

  5. Prepare clean data for future analysis
    The processed data can feed into predictive models, policy analysis, or academic interventions.

**Summary**
Study Hours Variation by Residency
The analysis of study hours reveals similarities in study patterns between urban and rural students. This suggests that residency does not significantly impact study habits.

Histograms show symmetric distributions for both urban and rural students. ​
Most students cluster around similar study hours, indicating comparable academic effort.

Math Scores by Academic Performance and Gender
Boxplots illustrate the relationship between math scores, academic performance, and gender. ​ The findings highlight trends in academic achievement across different demographics.

Median math scores increase from Poor to Excellent performance categories. ​
Male and female students show similar median scores across performance categories. ​
Outliers are present in all performance categories, indicating variability in student performance.

Extracurricular Activities and Faculty Proportions
The dataset reveals insights into students' participation in extracurricular activities and their distribution across various faculties. ​ This information can inform resource allocation and support services.

Most common extracurricular activity: None (25.8%).
Faculty distribution: Education (20.6%), Arts (20.5%), Business (19.3%).

Correlation Analysis of Numerical Variables
A correlation matrix provides insights into relationships between numerical variables, highlighting potential areas for further investigation.

Strongest correlations: Age and family income (-0.01), mobile money usage and math score (-0.01). ​
Science score and library usage show a positive correlation of 0.04.

Chi-Squared Test for Internet Access and Academic Performance
The chi-squared test indicates a significant association between internet access and academic performance. ​ This suggests that access to the internet may influence educational outcomes.

Chi-squared statistic: 163.55; p-value < 2.2e-16. ​
Indicates a statistically significant relationship between the two variables.

Missing Values Analysis and Imputation
The analysis of missing values highlights the extent of data gaps and the strategies employed for imputation. This is crucial for maintaining data integrity.

Missing values: Family income (250), attendance rate (250), math score (150), academic performance (391). ​
Imputation methods: Median for family income and math score; mean for attendance rate. ​

Outlier Detection in Family Income
Outlier detection using the IQR method reveals significant variations in family income, which may reflect socioeconomic disparities. ​

Number of outliers in family income: 79.
Outliers may represent high-income families or data entry errors. ​

Capping Outliers in Family Income
Capping outliers in family income helps to reduce skewness and improve the robustness of statistical analyses. ​ This process is essential for accurate modeling.

Outliers were capped to upper and lower bounds based on IQR. ​
Boxplots show reduced skewness after capping, indicating a more normalized distribution.

Discretization of Study Hours and Family Income
Discretizing continuous variables into categories allows for easier analysis and interpretation of data trends. This can enhance understanding of student behaviors and outcomes.

Study hours binned into categories: Low, Moderate, High, Very High. ​
Family income categorized into quartiles: Low, Medium-Low, Medium-High, High. ​

Total Score Calculation and Distribution Visualization
The creation of a total score variable provides a comprehensive measure of student performance across subjects. The distribution of this score offers insights into overall academic achievement.

Total score is the average of math, science, and English scores.
The distribution is symmetric, indicating a balanced performance among students. ​

Contingency Table Analysis of Activities and Performance
The analysis of the contingency table reveals patterns in student involvement in extracurricular activities and their academic performance. ​ It suggests that participation in extracurriculars may not significantly influence academic outcomes. ​

The Sports group has the highest number of students achieving Excellent performance. ​
The None group, which does not participate in extracurricular activities, has slightly more students with Poor and Good performance compared to other categories. ​
Both Sports and Clubs show higher counts in Average performance, followed by Poor. ​
The findings indicate that other factors, such as socio-economic status, may play a larger role in academic performance. ​

Visualization of Study Hours and Total Score
The scatter plot visualizes the relationship between weekly study hours and total scores, differentiated by residency. ​ It indicates that the correlation between study hours and total score is similar across different residency types. ​

The regression line indicates a global trend across all students, regardless of residency. ​
Urban and Rural students show similar spread in data points, suggesting no strong difference in the relationship between study hours and total score. ​
Overall, there appears to be little correlation between study hours and total score across all students.

Data Saving and Preprocessing
The preprocessed dataset has been saved for further analysis. ​ This step ensures that the data is ready for future use and insights.

The dataset is saved as "kenya_student_data_preprocessed.csv". ​
This action facilitates easier access and analysis of the cleaned data in subsequent tasks.
