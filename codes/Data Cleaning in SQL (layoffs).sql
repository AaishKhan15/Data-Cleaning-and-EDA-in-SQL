USE world_layoffs;
SELECT * FROM layoffs;

# ----- Create a staging table to work on
CREATE TABLE layoff_staging
LIKE layoffs;

SELECT * FROM layoff_staging;

INSERT layoff_staging
SELECT * FROM layoffs;

# ----- Check for Duplicates
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, `date`, country) AS row_num
FROM layoff_staging;

# building a CTE to filter results from a window func
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE company = 'Cazoo'

# Since we cannot update our table using CTEs, to delete rows, we will have to turn the CTE result into a table

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT layoff_staging2
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoff_staging;

SELECT * FROM layoff_staging2;

DELETE 
FROM layoff_staging2
WHERE row_num > 1;

# -------- Check for Standardization

#### COMPANY COLUMN
SELECT DISTINCT company
FROM layoff_staging2
ORDER BY 1; 

SELECT DISTINCT a.company AS name1, b.company AS name2
FROM (SELECT DISTINCT company FROM layoff_staging2) a
JOIN (SELECT DISTINCT company FROM layoff_staging2) b
  ON a.company < b.company
  AND (b.company LIKE CONCAT(a.company, '%') 
       OR a.company LIKE CONCAT(b.company, '%'));
       
# Impossible Foods and Impossible Foods copy same
# found Ada and Ada Support the same company
# Lido and Lido Learning
# Olive and Olive AI
# Stash and Stash Financial

#To check of the companies are same or diff
SELECT company, industry, country, location
FROM layoff_staging2
WHERE company LIKE 'Olive%'; 
    
UPDATE layoff_staging2
SET company = 'Impossible Foods'
WHERE company = 'Impossible Foods copy';

UPDATE layoff_staging2
SET company = 'Ada Support'
WHERE company = 'Ada';

UPDATE layoff_staging2
SET company = 'Lido Learning'
WHERE company = 'Lido';

UPDATE layoff_staging2
SET company = 'Olive AI'
WHERE company = 'Olive';

UPDATE layoff_staging2
SET company = 'Stash'
WHERE company = 'Stash Financial';

##### Trimming

SELECT DISTINCT company, TRIM(company)
FROM layoff_staging2;

## Trimmed the column of companies
UPDATE layoff_staging2
SET company = TRIM(company);

##### LOCATION COLUMN
SELECT DISTINCT location
FROM layoff_staging2; # location column seems all good


##### INDUSTRY COLUMN
SELECT DISTINCT industry
FROM layoff_staging2; # I see Crypto. CryptoCurrency and Crypto Currency

SELECT * 
FROM layoff_staging2
WHERE industry LIKE 'Crypto%';

# Standardized the Crypto industry with one name
UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

##### COMPANY COLUMN
SELECT DISTINCT country 
FROM layoff_staging2
order by 1; # Found 2 United States

UPDATE layoff_staging2
SET country = 'United States'
WHERE country LIKE 'United States%'; # Standardized the United States with one name

# ---------------- Check for Business Logic

###### Checking if the relationship between location(cities) and country makes sense 
#### A country can have multiple cities but a city can only belong to one country

# Trying to see if there are any cities that belong to more than 1 country in the database
SELECT location, COUNT(DISTINCT country) AS num_countries
FROM layoff_staging2
GROUP BY location
HAVING COUNT(DISTINCT country) > 1; # Found a few

SELECT DISTINCT company, location, country
FROM layoff_staging2
WHERE location IN (
	SELECT location
    FROM layoff_staging2
	GROUP BY location
	HAVING COUNT(DISTINCT country) > 1)
ORDER BY 2; #Found names asw (Countries do not match the location of companies, while some are vice versa example The Org is in US but location is of new delhi)


# ------------ Check for Format
## for time analysis, date column shud be in date format and not text, so we will have to convert

## before converting the data type, we need to write the date in date format
SELECT `date`, 
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoff_staging2;

UPDATE layoff_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

## now change the data type
ALTER TABLE layoff_staging2
MODIFY COLUMN `Date` DATE; # now check the schema and ull find date's datatype as date and not text


# ----------- Chheck for nulls
SELECT *
FROM layoff_staging2
WHERE location IS NULL OR location = ''; ## None

SELECT *
FROM layoff_staging2
WHERE industry IS NULL 
OR industry = ''; ## Found a few

SELECT *
FROM layoff_staging2
WHERE country IS NULL OR country = ''; ## None

## seeing if we can remove industry null
SELECT *
FROM layoff_staging2
WHERE company = 'Carvana';


## First convert all blank spaces into null for ease
UPDATE layoff_staging2
SET industry = NULL
WHERE industry = '';

## Join the table to itself and check if one company that has no industry in a row has an industry mentioned in any other row
SELECT T1.company, T1.industry, T2.industry
FROM layoff_staging2 T1
JOIN layoff_staging2 T2
	ON T1.company = T2.company
    AND T1.location = T2.location
WHERE T1.industry IS NULL
AND T2.industry IS NOT NULL;

# update the table and replace the null values with their corresponding industry
UPDATE layoff_staging2 T1
	JOIN layoff_staging2 T2
	ON T1.company = T2.company
    AND T1.location = T2.location
SET T1.industry = T2.industry
WHERE T1.industry IS NULL
AND T2.industry IS NOT NULL;

SELECT *
FROM layoff_staging2
WHERE industry IS NULL; 

## CHecking for rows where total and percentage laid off both are blank as its useless for our current work 
SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

# ---------------------- Removing unnecessary columns
ALTER TABLE layoff_staging2
DROP COLUMN row_num;

SELECT * FROM layoff_staging2;
