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
Across ~3 years of data (Mar 2020 – Mar 2023), companies laid off 383,659 
employees despite having raised $1.6T+ in funding collectively.

- **Layoffs spiked 10x almost overnight**: low in 2021, then surged in 2022, aligning with the broader tech industry correction.
- **Funding and maturity didn't shield companies from layoffs**: Post-IPO, well funded companies had the highest layoff totals.
- **The US spread its layoffs thin; smaller countries concentrated theirs**: While these countries were at the top interms of highest layoffs, 1,294 US companies were affected vs. just 12–17 in Netherlands/Sweden.
- **Consumer and Retail bore the brunt** — likely tied to pandemic-era demand reversing post-2021.

**Tools used:**
- SQL
  



How to run it:
