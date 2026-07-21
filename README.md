# Data-Cleaning-EDA-SQL-
## **Project Overview:**
This project is an open ended exploratory analysis of a layoffs dataset across companies globally. Rather than testing a specific hypothesis, this project is centered around exploring the data broadly, across multiple domains; like company, industry, time, geography and funding stage; to see what patterns and stories emerge. This project starts off with cleaning the data and then moves towards analyzing the dataset.

## **Project Composition**
1. Data Cleaning
2. Exploratory Data Analysis (EDA)
3. Translating data into business insights
   
### **Data Cleaning Summary:**
Raw data was staged before any modifications to preserve the original dataset. Key steps:

- Removed exact duplicate rows (no unique ID existed, so used `ROW_NUMBER()` across all columns)
- Standardized inconsistent company names (e.g. "Ada" vs. "Ada Support") via a self-join to catch formatting variants systematically
- Standardized industry and country labels (e.g. "Crypto Currency" → "Crypto")
- Converted `date` from text to proper `DATE` type for time-based analysis
- Backfilled missing industry values using matching rows for the same company

### **Key Insights:**
**--- Company ----**
**--- Industry ---**
**--- Time ---**
**--- Geography ---**
**--- Funding Stage ---**

**Tools used:**
- SQL
  



How to run it:
