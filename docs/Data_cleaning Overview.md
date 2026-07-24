## Data Cleaning Overview
Raw data was first transferred to a staging table before any modifications, to preserve the original dataset. The key cleaning steps were:

#### 1. Removed Duplicates: 
- Since the dataset had no unique ID, used ROW_NUMBER() partitioned across all columns to identify exact duplicate rows, then deleted rows beyond the first occurrence.
- Any row where row_num > 1 meant that exact combination of values had already appeared earlier in the table (a true duplicate), not just a company that appeared more than once for a genuinely different layoff event.

**One limitation:** CTEs and window function results in MySQL cannot be directly updated or deleted from. To get around this, the row_num result was converted into a new physical table (layoff_staging2), which could then have rows deleted from it directly


#### 2. Standardized company names:
The distinct company list was too long to review manually without risking missed inconsistencies,  So instead of scanning the list by eye, the distinct company list was self-joined against itself, matching any pair of names where one was a prefix of the other: 

This surfaced several pairs that were actually the same company written inconsistently:
- "Impossible Foods" vs. "Impossible Foods copy"
- "Ada" vs. "Ada Support"
- "Lido" vs. "Lido Learning"
- "Olive" vs. "Olive AI"
- "Stash" vs. "Stash Financial"

Before merging any pair, each was checked individually (e.g. comparing industry, country, and location for the matching rows) to confirm they genuinely referred to the same company, rather than two different companies that simply happen to share a similar name. Once confirmed, each pair was merged into a single consistent name using targeted UPDATE statements.

Additionally, company names were trimmed of any leading/trailing whitespace using TRIM(), since stray spaces can otherwise cause two visually identical names to be treated as distinct values in SQL.

#### 3. Standardized industry and country values: 
Reviewed distinct values in each column and merged inconsistent variants into single consistent labels (e.g. "Crypto", "CryptoCurrency", and "Crypto Currency" → "Crypto"; "United States" and "United States." → "United States").
Unlike the company column, the industry and country columns had a small number of distinct values meaning they could be reviewed directly with a simple SELECT DISTINCT, without needing a more complex matching technique.

This surfaced two clear inconsistencies:

- **Industry:** "Crypto", "CryptoCurrency", and "Crypto Currency" were all being used to describe the same industry. These were merged into a single "Crypto" label:
- **Country:** "United States" appeared with a trailing inconsistency (an extra period in some rows), effectively creating two separate values for what should be one country.

#### 4. Checking Location-country consistency
A basic rule of geography should hold in this dataset: a country can contain many cities, but a given city name should only belong to one country. To check whether this held true, the data was grouped by location and checked for cases where more than one distinct country was associated with the same city name

This returned a handful of cases which showed two different underlying situations:
- **Genuinely ambiguous city names**: Some city names legitimately exist in more than one country (e.g. a city name shared between two countries), which isn't a data error at all, just a natural naming overlap.
- **Actual data entry mismatches** In at least one case (a company listed with country = United States but location = New Delhi), the country field clearly didn't match where the company was actually based.

This inconsistency was identified and documented, but not corrected in this pass as determining the "correct" country/location for each ambiguous case would require external research per company, which was out of scope for this cleaning project. It's noted here as a known data quality limitation rather than silently left unaddressed.
  
#### 5. Fixed date formatting: 
The date column was stored as text in MM/DD/YYYY format, which meant it couldn't be used for any real date based operations (sorting chronologically, extracting year/month, calculating date ranges), "3/1/2023" and "12/1/2020" would sort alphabetically rather than chronologically, giving wrong results in any time based analysis.

- The column was first reformatted into a proper date string using STR_TO_DATE()
- Then the column's actual data type was changed from text to DATE using  ALTER TABLE ... MODIFY COLUMN

This two step process was necessary because ALTER TABLE ... MODIFY COLUMN converts the data type of a column, but doesn't reinterpret text that isn't already in a format MySQL recognizes as a valid date. Hence the values first had to be converted into a recognizable date format first, before the column type itself could be safely changed.

#### 6. Handled missing industry values: 
Each key column was checked individually for blank or NULL values. Industry was one of the columns with missing values. Other columns, like total_laid_off and percentage_laid_off, also had missing values, but unlike industry, there wasn't enough related data elsewhere in the table to reliably populate them.

For industry, blank strings were first converted to actual NULL values, since blanks and NULLs can otherwise be treated inconsistently by different SQL functions.
Since several companies appeared in the dataset more than once (e.g. multiple layoff events over time), and in some cases the industry was filled in on one row but missing on another row for the same company. Rather than leaving these as permanently missing, the table was self joined against itself, matching rows by company and location, to backfill the missing industry using the value from another row where it was already known:












