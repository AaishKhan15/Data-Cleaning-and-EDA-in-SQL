# Data-Cleaning-EDA-SQL-
Project Overview:
This project is an open ended exploratory analysis of a layoffs dataset across companies globally. Rather than testing a specific hypothesis, this project is centered around exploring the data broadly, across multiple domains; like company, industry, time, geography and funding stage; to see what patterns and stories emerge. This project starts off with cleaning the data and then moves towards analyzing the dataset.

Data Cleaning Summary:
Raw data was first transferred to a staging table before any modifications, to preserve the original dataset. The key cleaning steps were:

1. Removed Duplicates: since the dataset had no unique ID, used `ROW_NUMBER()` partitioned across all columns to identify exact duplicate rows, then deleted rows beyond the first occurrence.
2. Standardized company names: The distinct company list was too long to review manually without risking missed inconsistencies, so self-joined the list against itself to systematically catch near-duplicate names caused by formatting differences (e.g. "Ada" vs. "Ada Support", "Olive" vs. "Olive AI", "Impossible Foods" vs. "Impossible Foods copy") and merged them into a single consistent name.
3. Standardized industry and country values: reviewed distinct values in each column and merged inconsistent variants into single consistent labels (e.g. "Crypto", "CryptoCurrency", and "Crypto Currency" → "Crypto"; "United States" and "United States." → "United States").
4. Fixed date formatting: converted the `date` column from text (`MM/DD/YYYY`string) into a proper SQL `DATE` type using `STR_TO_DATE()`, for accurate time based analysis (monthly/yearly aggregation, rolling totals).
5. Handled missing industry values: Converted blanks to NULL, then self-joined the table on company + location to fill in missing industry values from other rows of the same company where the industry was already known.


Key Insights:


Tools used:




How to run it:
