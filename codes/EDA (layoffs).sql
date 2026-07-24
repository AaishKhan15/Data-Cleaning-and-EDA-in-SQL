# DIMENSION: company, location, industry, Date, stage, country
# MEASURE: total_laid_off, funds_raised_millions, percentage_laid_off

# Exploring Dimensions
SELECT DISTINCT company
FROM layoff_staging2;

SELECT DISTINCT location
FROM layoff_staging2;

SELECT DISTINCT industry
FROM layoff_staging2;

SELECT DISTINCT country
FROM layoff_staging2;

## hierarchy to better understand Data Structure
SELECT DISTINCT country, location
FROM layoff_staging2
ORDER BY 1;

SELECT DISTINCT country, location, company
FROM layoff_staging2
ORDER BY 1;

# Analyze Date span
SELECT MIN(`Date`), MAX(`Date`)
FROM layoff_staging2;   # 3 years data from 2020 to 2023 starting from the 3rd month and ending at the 3rd month

# Measuress
SELECT SUM(total_laid_off)
FROM layoff_staging2; # 383,659

SELECT AVG(total_laid_off)
FROM layoff_staging2;

SELECT SUM(funds_raised_millions)
FROM layoff_staging2; # 1,601,450 million

SELECT ROUND(AVG(percentage_laid_off),2)
FROM layoff_staging2;

SELECT DISTINCT COUNT(company) AS number_of_companies_w_layoffs
FROM layoff_staging2;

# Magnitude & Ranking Analysis

## Top 5 companies with highest layoffs in 3 years
SELECT company, SUM(total_laid_off) AS total_layoffs,
 DENSE_RANK() OVER (ORDER BY SUM(total_laid_off) DESC) AS `rank`
 FROM layoff_staging2
 GROUP BY 1
 LIMIT 5;

## Top 5 companies with lowest layoffs in 3 years
SELECT company, SUM(total_laid_off) AS total_layoffs,
 DENSE_RANK() OVER (ORDER BY SUM(total_laid_off)) AS `rank`
 FROM layoff_staging2
 WHERE total_laid_off IS NOT NULL
 GROUP BY 1
 LIMIT 5;
 
# Top 3 companies in terms of highest layoffs in each industry
WITH d_rank AS (
SELECT industry, company, SUM(total_laid_off),
 DENSE_RANK() OVER (PARTITION BY industry ORDER BY SUM(total_laid_off) DESC) AS `rank`
 FROM layoff_staging2
 WHERE total_laid_off IS NOT NULL
 GROUP BY 1, 2
 )
 SELECT * 
 FROM d_rank 
 WHERE `rank` <=3;


#Industries and their % lay_off average
SELECT industry, ROUND(AVG(percentage_laid_off),3) AS avg_layoff_pct
FROM layoff_staging2
GROUP BY 1
ORDER BY 2 DESC;

#Industries w highest layoffs
SELECT industry, SUM(total) AS avg_layoff_pct
FROM layoff_staging2
GROUP BY 1
ORDER BY 2 DESC;

# number of companies w layoffs in each industry
SELECT COUNT(company) AS number_of_companies_w_layoffs, industry
FROM layoff_staging2
GROUP BY 2
ORDER BY 1 DESC;


SELECT company, industry, SUM(total_laid_off) 
FROM layoff_staging2
GROUP BY company, industry
ORDER BY 3 DESC;

SELECT industry, SUM(total_laid_off) AS total_layoffs
FROM layoff_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT company, SUM(funds_raised_millions) 
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, SUM(funds_raised_millions), SUM(total_laid_off) 
FROM layoff_staging
GROUP BY company
ORDER BY 2 DESC;

SELECT industry, AVG(funds_raised_millions)
FROM layoff_staging2
GROUP BY industry
ORDER BY 2 DESC;

# layoffs based on company stage
SELECT stage, SUM(total_laid_off) AS total_layoffs, COUNT(company) AS companies_affected
FROM layoff_staging2
GROUP BY 1
ORDER BY 2 DESC;

#countries most affected by layoffs
SELECT country, SUM(total_laid_off) AS total_layoffs
FROM layoff_staging2
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

SELECT country, SUM(total_laid_off) AS total_layoffs, COUNT(company) #checking company concentration
FROM layoff_staging2
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

SELECT country, industry, SUM(total_laid_off) AS total_layoffs, COUNT(company) #checking which industries dominate interms of highest total layoffs in countries affected mst by layoffs
FROM layoff_staging2
WHERE country IN ('United States', 'India', 'Netherlands', 'Sweden', 'Brazil')
GROUP BY 1,2
ORDER BY 1 DESC;


# companies that laid off 100% of their staff
SELECT company, percentage_laid_off
FROM layoff_staging2
WHERE percentage_laid_off = 1;

SELECT COUNT(percentage_laid_off), stage #their reLationship to company stage
FROM layoff_staging2
WHERE percentage_laid_off = 1
GROUP BY 2;

# date of biggest single layoff events
SELECT company, industry, country, total_laid_off, `Date`
FROM layoff_staging2
ORDER BY 4 DESC
LIMIT 5;

# companies with multiple layoff rounds in their respective countries
SELECT company, country, COUNT(*) AS layoff_rounds
FROM layoff_staging2
GROUP BY 1,2
HAVING COUNT(*)>1
ORDER BY 3 DESC;

## total_Laid_off per year
SELECT `Date`
FROM layoff_staging2;

SELECT YEAR(`Date`), SUM(total_laid_off) AS total_layoffs_annual
FROM layoff_staging2
GROUP BY 1
ORDER BY 1;


## total_Laid_off per month of each year
SELECT YEAR(`Date`), MONTH(`Date`), SUM(total_laid_off) AS total_layoffs
FROM layoff_staging2
GROUP BY 1,2
ORDER BY 1,2;

SELECT YEAR(`Date`), MONTH(`Date`), SUM(total_laid_off) AS total_layoffs
FROM layoff_staging2
GROUP BY 1,2
ORDER BY 3 DESC;

## Running total/cumulative total_Laid_off across per month of each year
SELECT YEAR(`Date`) AS `year`, MONTH(`Date`) AS `month`,
SUM(SUM(total_laid_off)) OVER (ORDER BY YEAR(`Date`), MONTH(`Date`)) AS running_total, SUM(total_laid_off) AS monthly_layoff
FROM layoff_staging2
GROUP BY YEAR(`Date`), MONTH(`Date`)
ORDER BY YEAR(`Date`), MONTH(`Date`);

#using month name
SELECT YEAR(`Date`) AS `year`, MONTHNAME(`Date`) AS `month`,
SUM(SUM(total_laid_off)) OVER (ORDER BY YEAR(`Date`), MONTH(`Date`)) AS running_total, SUM(total_laid_off) AS monthly_layoff
FROM layoff_staging2
WHERE `Date` IS NOT NULL
GROUP BY YEAR(`Date`), MONTH(`Date`), MONTHNAME(`Date`) 
ORDER BY YEAR(`Date`), MONTH(`Date`);

## Top 5 companies each year interms of highest number of layoffs
WITH rank_limit AS (
SELECT company, YEAR(`Date`) AS `year`, SUM(total_laid_off) AS total_layoffs,
ROW_NUMBER() OVER (PARTITION BY YEAR(`Date`) ORDER BY SUM(total_laid_off) DESC) AS `rank`
FROM layoff_staging2
WHERE `Date` IS NOT NULL
GROUP BY 2,1
ORDER BY 2,3 DESC
)
SELECT *
FROM rank_limit
WHERE `rank` <= 5;
