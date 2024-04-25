use [Automobile Insurance DB];
select * from Automobile_Insurance_data;

select * from Automobile_Insurance_data where Premiums_Written_in_Millions is null;
select Company_Name,Ratio from Automobile_Insurance_data order by Ratio DESC;

--- What is the overall Complaint Ratio for each insurance company? ---
SELECT 
    Company_Name,
    sum(Ratio) as Ratio,
	sum(Upheld_Complaints)as up_held_Complaints,
	SUM(Question_of_Fact_Complaints) as Question_of_Fact,
	SUM(Not_Upheld_Complaints) as Not_Upheld,
	sum(Premiums_Written_in_Millions) as Preminums_Written
FROM 
    Automobile_Insurance_data
GROUP BY 
    Company_Name
order by Ratio DESC;

--- Which insurance companies have the highest and lowest Complaint Ratios? ---
--- Highest Complaint Ratios ---
SELECT TOP(1)
    Company_Name,
    SUM(Ratio) as Total_Ratio,
    SUM(Upheld_Complaints) as Total_Upheld_Complaints,
    SUM(Premiums_Written_in_Millions) as Total_Premiums_Written
FROM 
    Automobile_Insurance_data
GROUP BY 
    Company_Name
ORDER BY 
    Total_Ratio DESC ;

--- Lower Complaint Ratio ---
SELECT TOP(1)
    Company_Name,
    SUM(Ratio) as Total_Ratio,
    SUM(Upheld_Complaints) as Total_Upheld_Complaints,
    SUM(Premiums_Written_in_Millions) as Total_Premiums_Written
FROM 
    Automobile_Insurance_data
GROUP BY 
    Company_Name
ORDER BY 
    Total_Ratio  ;

--- What types of complaints are most common? ---
SELECT 
    SUM(CASE WHEN Upheld_Complaints > 0 THEN 1 ELSE 0 END) AS Total_Upheld_Complaints,
    SUM(CASE WHEN Question_of_Fact_Complaints > 0 THEN 1 ELSE 0 END) AS Total_Question_of_Fact_Complaints,
    SUM(CASE WHEN Not_Upheld_Complaints > 0 THEN 1 ELSE 0 END) AS Total_Not_Upheld_Complaints
FROM 
    Automobile_Insurance_data;

--- Is there a correlation between premiums written and Complaint Ratios? ---
WITH PremiumsAndComplaints AS (
    SELECT 
        Company_Name,
        SUM(Premiums_Written_in_Millions) AS Total_Premiums_Written,
        SUM(Upheld_Complaints) AS Total_Upheld_Complaints,
        SUM(Ratio) AS Complaint_Ratio
    FROM 
        Automobile_Insurance_data
    GROUP BY 
        Company_Name
)
SELECT 
    (COUNT(*) * SUM(Total_Premiums_Written * Complaint_Ratio) - SUM(Total_Premiums_Written) * SUM(Complaint_Ratio)) /
    (SQRT((COUNT(*) * SUM(Total_Premiums_Written * Total_Premiums_Written)) - (SUM(Total_Premiums_Written) * SUM(Total_Premiums_Written))) *
     SQRT((COUNT(*) * SUM(Complaint_Ratio * Complaint_Ratio)) - (SUM(Complaint_Ratio) * SUM(Complaint_Ratio)))) AS Correlation
FROM 
    PremiumsAndComplaints;

--- Duplicate values in NAIC --- According to research it is fine to have duplicate data .

SELECT Company_Name,NAIC, COUNT(*) AS NAIC_Count
FROM Automobile_Insurance_data
GROUP BY Company_Name,NAIC
HAVING COUNT(*) >= 2;

--- What is the total number of unique insurance companies in the dataset? ---

SELECT COUNT(DISTINCT Company_Name) AS Total_Insurance_Companies
FROM Automobile_Insurance_data;

--- How many complaints were filed in total across all insurance companies? ---
SELECT SUM(Total_Complaints) AS Total_Complaints_Filed
FROM Automobile_Insurance_data;

--- What is the average complaint ratio across all insurance companies? ---
SELECT AVG(Ratio) AS Average_Complaint_Ratio
FROM Automobile_Insurance_data;

--- How many complaint cases were upheld in total? ---
SELECT SUM(Upheld_Complaints) AS Total_Upheld_Complaints
FROM Automobile_Insurance_data;

--- What is the average number of upheld complaints per insurance company? ---
SELECT AVG(Upheld_Complaints) AS Average_Upheld_Complaints
FROM Automobile_Insurance_data;

--- Which insurance company had the highest number of upheld complaints? ---
SELECT top(1)Company_Name, MAX(Upheld_Complaints) AS Highest_Upheld_Complaints
FROM Automobile_Insurance_data group by Company_Name order by Highest_Upheld_Complaints desc;

--- How many question of fact complaints were filed in total? ---
SELECT SUM(Question_of_Fact_Complaints) AS Total_Question_of_Fact_Complaints
FROM Automobile_Insurance_data;

--- What is the average number of question of fact complaints per insurance company? ---
SELECT AVG(Question_of_Fact_Complaints) AS Average_Question_of_Fact_Complaints
FROM Automobile_Insurance_data;

--- Which insurance company had the highest number of question of fact complaints? ---
SELECT top(1)Company_Name, MAX(Question_of_Fact_Complaints) AS Highest_Question_of_Fact_Complaints
FROM Automobile_Insurance_data group by Company_Name order by Highest_Question_of_Fact_Complaints desc;

--- How many complaints were not upheld in total? ---
SELECT SUM(Not_Upheld_Complaints) AS Total_Not_Upheld_Complaints
FROM Automobile_Insurance_data;

--- What is the average number of not upheld complaints per insurance company? ---
SELECT AVG(Not_Upheld_Complaints) AS Average_Not_Upheld_Complaints
FROM Automobile_Insurance_data;

--- Which insurance company had the highest number of not upheld complaints? ---
SELECT top(1)Company_Name, MAX(Not_Upheld_Complaints) AS Highest_Not_Upheld_Complaints
FROM Automobile_Insurance_data group by Company_Name order by Highest_Not_Upheld_Complaints desc;

--- What is the total amount of premiums written across all insurance companies? ---
SELECT SUM(Premiums_Written_in_Millions) AS Total_Premiums_Written
FROM Automobile_Insurance_data;

--- What is the average premiums written per insurance company? ---
SELECT AVG(Premiums_Written_in_Millions) AS Average_Premiums_Written
FROM Automobile_Insurance_data;

--- Which insurance company had the highest premiums written? ---

SELECT top(1)Company_Name, MAX(Premiums_Written_in_Millions) AS Highest_Premiums_Written
FROM Automobile_Insurance_data group by Company_Name order by Highest_Premiums_Written desc;

--- How many unique filing years are present in the dataset? ---
SELECT Filing_Year,COUNT(DISTINCT Filing_Year) AS Unique_Filing_Years
FROM Automobile_Insurance_data group by Filing_Year;

--- How many complaints were filed in each filing year? ---
SELECT Filing_Year, SUM(Total_Complaints) AS Total_Complaints
FROM Automobile_Insurance_data
GROUP BY Filing_Year;

--- What is the trend of upheld complaints over the filing years? ---
SELECT Filing_Year, SUM(Upheld_Complaints) AS Total_Upheld_Complaints
FROM Automobile_Insurance_data
GROUP BY Filing_Year;

--- What is the trend of question of fact complaints over the filing years? ---
SELECT Filing_Year, SUM(Question_of_Fact_Complaints) AS Total_Question_of_Fact_Complaints
FROM Automobile_Insurance_data
GROUP BY Filing_Year;

--- What is the trend of not upheld complaints over the filing years? ---
SELECT Filing_Year, SUM(Not_Upheld_Complaints) AS Total_Not_Upheld_Complaints
FROM Automobile_Insurance_data
GROUP BY Filing_Year;

--- How many complaints were filed for each company? ---
SELECT Company_Name, SUM(Total_Complaints) AS Total_Complaints
FROM Automobile_Insurance_data
GROUP BY Company_Name;
 
--- What is the distribution of complaint ratios across all companies? ---
SELECT Company_Name, Ratio
FROM Automobile_Insurance_data
ORDER BY Ratio;

--- How many companies have a complaint ratio higher than 1? ---
SELECT COUNT(Company_Name) AS Companies_With_High_Ratio
FROM Automobile_Insurance_data
WHERE Ratio > 1;

--- How many companies have a complaint ratio less than or equal to 1? ---
SELECT COUNT(Company_Name) AS Companies_With_Low_Ratio
FROM Automobile_Insurance_data
WHERE Ratio <= 1;

--- What is the average complaint ratio per filing year? ---
SELECT Filing_Year, AVG(Ratio) AS Average_Complaint_Ratio
FROM Automobile_Insurance_data
GROUP BY Filing_Year;

--- Which filing year had the highest average complaint ratio? ---
SELECT TOP(1)Filing_Year, AVG(Ratio) AS Average_Complaint_Ratio
FROM Automobile_Insurance_data
GROUP BY Filing_Year
ORDER BY Average_Complaint_Ratio DESC ;

--- Which filing year had the lowest average complaint ratio? ---
SELECT TOP(1)Filing_Year, AVG(Ratio) AS Average_Complaint_Ratio
FROM Automobile_Insurance_data
GROUP BY Filing_Year
ORDER BY Average_Complaint_Ratio ASC;

--- What is the distribution of upheld complaints across all companies? ---
SELECT Company_Name, Upheld_Complaints
FROM Automobile_Insurance_data
ORDER BY Upheld_Complaints DESC;

--- What is the distribution of question of fact complaints across all companies? ---
SELECT Company_Name, Question_of_Fact_Complaints
FROM Automobile_Insurance_data
ORDER BY Question_of_Fact_Complaints DESC;

--- What is the distribution of not upheld complaints across all companies? ---
SELECT Company_Name, Not_Upheld_Complaints
FROM Automobile_Insurance_data
ORDER BY Not_Upheld_Complaints DESC;

--- How many companies have a higher number of upheld complaints than question of fact complaints? ---
SELECT COUNT(Company_Name) AS Companies_With_More_Upheld
FROM Automobile_Insurance_data
WHERE Upheld_Complaints > Question_of_Fact_Complaints;

--- How many companies have a higher number of question of fact complaints than upheld complaints? ---
SELECT COUNT(Company_Name) AS Companies_With_More_Question_of_Fact
FROM Automobile_Insurance_data
WHERE Upheld_Complaints < Question_of_Fact_Complaints;

--- What is the average ratio for companies with more upheld complaints than question of fact complaints? ---
SELECT AVG(Ratio) AS Average_Ratio_For_More_Upheld
FROM Automobile_Insurance_data
WHERE Upheld_Complaints > Question_of_Fact_Complaints;

--- What is the average ratio for companies with more question of fact complaints than upheld complaints? ---
SELECT AVG(Ratio) AS Average_Ratio_For_More_Question_of_Fact
FROM Automobile_Insurance_data
WHERE Upheld_Complaints < Question_of_Fact_Complaints;

--- What is the distribution of premiums written across all companies? ---
SELECT Company_Name, Premiums_Written_in_Millions
FROM Automobile_Insurance_data
ORDER BY Premiums_Written_in_Millions DESC;

--- How many companies have premiums written exceeding $100 million? ---
SELECT COUNT(Company_Name) AS Companies_With_High_Premiums
FROM Automobile_Insurance_data
WHERE Premiums_Written_in_Millions > 100;

--- How many companies have premiums written less than or equal to $100 million? ---
SELECT COUNT(Company_Name) AS Companies_With_Low_Premiums
FROM Automobile_Insurance_data
WHERE Premiums_Written_in_Millions <= 100;







