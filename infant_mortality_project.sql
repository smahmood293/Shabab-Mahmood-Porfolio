SELECT * FROM infant_mortality.infant_mortality;

ALTER TABLE infant_mortality.infant_mortality
RENAME COLUMN `Maternal Race or Ethnicity` TO `Maternal Race`;

SELECT COUNT(*) AS missing_count
FROM infant_mortality.infant_mortality
WHERE Year IS NULL
Union All 
SELECT COUNT(*) AS missing_count
FROM infant_mortality.infant_mortality
WHERE `Maternal Race` IS NULL
UNION ALL
SELECT COUNT(*) AS missing_count
FROM infant_mortality.infant_mortality
WHERE `Infant Mortality Rate` IS NULL
UNION ALL
SELECT COUNT(*) AS missing_count
FROM infant_mortality.infant_mortality
WHERE `Neonatal Mortality Rate` IS NULL
UNION ALL
SELECT COUNT(*) AS missing_count
FROM infant_mortality.infant_mortality
WHERE `Postneonatal Mortality Rate` IS NULL
UNION ALL
SELECT COUNT(*) AS missing_count
FROM infant_mortality.infant_mortality
WHERE `Infant Deaths` IS NULL
UNION ALL
SELECT COUNT(*) AS missing_count
FROM infant_mortality.infant_mortality
WHERE `Neonatal Infant Deaths` IS NULL
UNION ALL
SELECT COUNT(*) AS missing_count
FROM infant_mortality.infant_mortality
WHERE `Postneonatal Infant Deaths` IS NULL
UNION ALL
SELECT COUNT(*) AS missing_count
FROM infant_mortality.infant_mortality
WHERE `Number of Live Births` IS NULL;

SELECT DISTINCT `Maternal Race` from infant_mortality.infant_mortality;

UPDATE infant_mortality.infant_mortality
SET `Maternal Race` = 'Black'
WHERE `Maternal Race` LIKE '%Black%';

UPDATE infant_mortality.infant_mortality
SET `Maternal Race` = 'White'
WHERE `Maternal Race` like '%White%';

UPDATE infant_mortality.infant_mortality
SET `Maternal Race` = 'API'
WHERE `Maternal Race` like 'Asian and Pacific Islander';

UPDATE infant_mortality.infant_mortality
SET `Maternal Race` = 'Hispanic'
WHERE `Maternal Race` like 'Other Hispanic' OR `Maternal Race` like 'Puerto Rican';

select distinct `Maternal Race` from infant_mortality.infant_mortality;

Create Table infant_mortality.avg_infant_mortality_race AS
SELECT Year,
    AVG(CASE WHEN `Maternal Race` = 'API' THEN `Infant Mortality Rate` END) AS api_avg_infant_mortality,
    AVG(CASE WHEN `Maternal Race` = 'Black' THEN `Infant Mortality Rate` END) AS black_avg_infant_mortality,
    AVG(CASE WHEN `Maternal Race` = 'White' THEN `Infant Mortality Rate` END) AS white_avg_infant_mortality,
    AVG(CASE WHEN `Maternal Race` = 'Hispanic' THEN `Infant Mortality Rate` END) AS hispanic_avg_infant_mortality,
    AVG(CASE WHEN `Maternal Race` = 'Other/Two or More' THEN `Infant Mortality Rate` END) AS other_avg_infant_mortality
FROM infant_mortality.infant_mortality
GROUP BY Year
ORDER BY Year;

update infant_mortality.avg_infant_mortality_race
set other_avg_infant_mortality = 0
where other_avg_infant_mortality is NULL;

select * from infant_mortality.avg_infant_mortality_race;

Create Table infant_mortality.avg_neonatal_mortality_race AS
SELECT Year,
    AVG(CASE WHEN `Maternal Race` = 'API' THEN `Neonatal Mortality Rate` END) AS api_avg_neonatal_mortality,
    AVG(CASE WHEN `Maternal Race` = 'Black' THEN `Neonatal Mortality Rate` END) AS black_avg_neonatal_mortality,
    AVG(CASE WHEN `Maternal Race` = 'White' THEN `Neonatal Mortality Rate` END) AS white_avg_neonatal_mortality,
    AVG(CASE WHEN `Maternal Race` = 'Hispanic' THEN `Neonatal Mortality Rate` END) AS hispanic_avg_neonatal_mortality,
    AVG(CASE WHEN `Maternal Race` = 'Other/Two or More' THEN `Neonatal Mortality Rate` END) AS other_avg_neonatal_mortality
FROM infant_mortality.infant_mortality
GROUP BY Year
ORDER BY Year;

update infant_mortality.avg_neonatal_mortality_race
set other_avg_neonatal_mortality = 0
where other_avg_neonatal_mortality is NULL;

select * from infant_mortality.avg_neonatal_mortality_race;

Create Table infant_mortality.avg_post_neonatal_mortality_race AS
SELECT Year,
    AVG(CASE WHEN `Maternal Race` = 'API' THEN `Postneonatal Mortality Rate` END) AS api_avg_post_neonatal_mortality,
    AVG(CASE WHEN `Maternal Race` = 'Black' THEN `Postneonatal Mortality Rate` END) AS black_avg_post_neonatal_mortality,
    AVG(CASE WHEN `Maternal Race` = 'White' THEN `Postneonatal Mortality Rate` END) AS white_avg_post_neonatal_mortality,
    AVG(CASE WHEN `Maternal Race` = 'Hispanic' THEN `Postneonatal Mortality Rate` END) AS hispanic_avg_post_neonatal_mortality,
    AVG(CASE WHEN `Maternal Race` = 'Other/Two or More' THEN `Postneonatal Mortality Rate` END) AS other_avg_post_neonatal_mortality
FROM infant_mortality.infant_mortality
GROUP BY Year
ORDER BY Year;

update infant_mortality.avg_post_neonatal_mortality_race
set other_avg_post_neonatal_mortality = 0
where other_avg_post_neonatal_mortality is NULL;

select * from infant_mortality.avg_post_neonatal_mortality_race;

SELECT
    Year,
    SUM(CASE WHEN `Maternal Race` = 'API' THEN `Infant Deaths` ELSE 0 END) AS API,
    SUM(CASE WHEN `Maternal Race` = 'Black' THEN `Infant Deaths` ELSE 0 END) AS Black,
    SUM(CASE WHEN `Maternal Race` = 'White' THEN `Infant Deaths` ELSE 0 END) AS White,
    SUM(CASE WHEN `Maternal Race` = 'Hispanic' THEN `Infant Deaths` ELSE 0 END) AS Hispanic,
    SUM(CASE WHEN `Maternal Race` = 'Other' THEN `Infant Deaths` ELSE 0 END) AS Other
FROM
    infant_mortality.infant_mortality
GROUP BY
    Year
ORDER BY
    Year;

create table infant_mortality.ratio    
SELECT
    Year,
    SUM(CASE WHEN `Maternal Race` = 'API' THEN `Infant Deaths` ELSE 0 END) AS api_Infant_Deaths,
    SUM(CASE WHEN `Maternal Race` = 'API' THEN `Number of Live Births` ELSE 0 END) AS api_Live_Births,
    SUM(CASE WHEN `Maternal Race` = 'Black' THEN `Infant Deaths` ELSE 0 END) AS black_Infant_Deaths,
    SUM(CASE WHEN `Maternal Race` = 'Black' THEN `Number of Live Births` ELSE 0 END) AS black_Live_Births,
    SUM(CASE WHEN `Maternal Race` = 'White' THEN `Infant Deaths` ELSE 0 END) AS white_Infant_Deaths,
    SUM(CASE WHEN `Maternal Race` = 'White' THEN `Number of Live Births` ELSE 0 END) AS white_Live_Births,
	SUM(CASE WHEN `Maternal Race` = 'Hispanic' THEN `Infant Deaths` ELSE 0 END) AS hispanic_Infant_Deaths,
    SUM(CASE WHEN `Maternal Race` = 'Hispanic' THEN `Number of Live Births` ELSE 0 END) AS hispanic_Live_Births,
	SUM(CASE WHEN `Maternal Race` = 'Other' THEN `Infant Deaths` ELSE 0 END) AS other_Infant_Deaths,
    SUM(CASE WHEN `Maternal Race` = 'Other' THEN `Number of Live Births` ELSE 0 END) AS other_Live_Births
FROM
    infant_mortality.infant_mortality
GROUP BY
    Year
ORDER BY
    Year;

select * from infant_mortality.ratio;
select * from infant_mortality.avg_infant_mortality_race;
select * from infant_mortality.avg_neonatal_mortality_race;
select * from infant_mortality.avg_post_neonatal_mortality_race;