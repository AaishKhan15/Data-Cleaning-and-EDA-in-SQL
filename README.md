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
- Standardized inconsistent company names (e.g. "Ada" vs. "Ada Support") via a self join to catch different format variants
- Standardized industry and country labels (e.g. "Crypto Currency" → "Crypto")
- Converted `date` from text to proper `DATE` type for time based analysis
- Backfilled missing industry values using matching rows for the same company

📄 Full cleaning writeup: [`Data_cleaning Overview.md`](https://github.com/AaishKhan15/Data-Cleaning-and-EDA-in-SQL/edit/main/README.md)  🧾 Full SQL script: [Data Cleaning in SQL (layoffs).sql](https://github.com/AaishKhan15/Data-Cleaning-and-EDA-in-SQL/blob/main/Data%20Cleaning%20in%20SQL%20(layoffs).sql)

### **Key Insights:**
Across ~3 years of data (Mar 2020 – Mar 2023), companies laid off 383,659 
employees despite having raised $1.6T+ in funding collectively.

- **Layoffs spiked roughly 10x almost overnight**: Low in 2021 (15,823), surging to 160,661 in 2022 and staying elevated into early 2023, aligning with the broader 2022 "tech correction" as rising interest rates cut off cheap funding.
- **Funding and maturity didn't protect against layoffs**: No correlation was found between funds raised and layoff size, and Post-IPO companies had the highest total layoffs of any stage.
- **The US spread its layoffs thin, Netherlands and Sweden concentrated theirs**: 1,294 US companies were affected vs. just 12–17 each in Netherlands and Sweden, pointing to very different underlying patterns despite similar looking totals.
- **Consumer and Retail bore the brunt**: Likely tied to, pandemic era demand for goods reversing, as spending patterns normalized post 2021.
- **The US and India had the most repeated layoff rounds**: Suggesting downsizing was an ongoing process for some companies rather than a single cut.
- **Amazon, Google, Meta, Salesforce, and Microsoft led total layoffs**: Peaking in different years (2022 vs. 2023), raising the question of whether size at a big tech company still means job security.
  
📄 Detailed Analysis and reasoning:[`Insights.md`](Insights.md) 
🧾 Full SQL script: [EDA (layoffs).sql](https://github.com/AaishKhan15/Data-Cleaning-and-EDA-in-SQL/blob/main/EDA%20(layoffs).sql)

### Skills Demonstrated
- SQL
- Data Cleaning
- Exploratory Data Analysis
- Business Insights




