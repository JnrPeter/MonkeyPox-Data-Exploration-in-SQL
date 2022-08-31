
 -- What are the number of confirmed,suspected and discarded cases worldwide?
SELECT 
    Status, COUNT(*) AS number_of_cases
FROM
    patient_info
GROUP BY 1


--  What are the number confirmed cases in each country?

SELECT 
    Country, COUNT(*) AS number_confirmed_cases
FROM
    patient_info
WHERE
    Status = 'confirmed'
GROUP BY 1
ORDER BY 2


-- What are the number of suspected cases in each country?

SELECT 
    Country, COUNT(*) AS number_suspected_cases
FROM
    patient_info
WHERE
    Status = 'suspected'
GROUP BY 1
ORDER BY 2


-- What are the number of Discarded cases in each country?

SELECT 
    Country, COUNT(*) AS number_confirmed_cases
FROM
    patient_info
WHERE
    Status = 'discarded'
GROUP BY 1
ORDER BY 2


-- What are the means confirmation of disease for countries with confirmed cases?

SELECT DISTINCT
    Country, Status,Confirmation_method
FROM
    patient_info
WHERE
    status = 'confirmed'
        AND Country <> 'Unknown'
        AND Confirmation_method <> 'Unknown'
Order by 1        


-- Find the number of times a method was used to confirm a diseases in each country.

SELECT 
    Country,
    Confirmation_Method,
    COUNT(confirmation_method) AS Count_of_Confirmation_Method
FROM
    patient_info
GROUP BY 1 , 2
HAVING Confirmation_method <> 'Unknown'
ORDER BY 3 DESC


What age ranges have been mostly confirmed with the disease?

SELECT 
    age, COUNT(*) AS number_of_people
FROM
    patient_info
WHERE
    status = 'suspected'
        AND age <> 'Unknown'
GROUP BY 1
ORDER BY 2 DESC

What age range have been most suspected to have the disease?

SELECT 
    age, COUNT(*) AS number_of_people
FROM
    patient_info
WHERE
    status = 'suspected'
        AND age <> 'Unknown'
GROUP BY 1
ORDER BY 2 DESC

-- What common symptoms did people confirmed with the disease present with in each country?
SELECT 
     country, symptoms,COUNT(symptoms) AS number_of_people
FROM
    patient_info
WHERE
    Symptoms <> 'unknown'
        AND status = 'confirmed'        
GROUP BY 1,2
order BY 3 DESC


-- What is the most common symptom of monkey pox amongst people who have been confirmed with disease worldwide?

SELECT 
	Symptoms, COUNT(*) as symptom_number 
FROM
    patient_info
WHERE
    Symptoms <> 'unknown'
        AND status = 'confirmed'    
 GROUP BY 1      
ORDER BY 2 DESC
LIMIT 1

-- What is the most common symptoms of monkey pox amongst people who have been suspected with disease worldwide?

SELECT 
	Symptoms, COUNT(*) as symptom_number 
FROM
    patient_info
WHERE
    Symptoms <> 'unknown'
        AND status = 'suspected'    
 GROUP BY 1      
ORDER BY 2 DESC
LIMIT 1

-- In what month have most cases been confirmed? 

SELECT 
    MONTHNAME(Date_confirmation) AS month,
    COUNT(*) AS Number_of_confirmed_cases
FROM
    patient_info
WHERE
    Date_confirmation <> 0000-00 -00
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

-- What is the average time delay between onset of monkey pox disease and confirmation of disease?

With time as (  SELECT
          Date_confirmation,
         DATEDIFF(Date_confirmation, Date_onset) AS time_delay
          FROM
        patient_info
        WHERE
        status = 'confirmed'
        AND Date_onset <> DATE(0000-00-00)
        AND Date_confirmation <> DATE(0000-00-00)
             )
             
   SELECT AVG(time_delay) as average_time_delay
   FROM time

-- What are the number of people in each country that have been hospitalized?

SELECT 
    Country, COUNT(Hospitalised) AS people_hospitalized
FROM
    isolation_records
GROUP BY 1
ORDER BY 2 DESC


-- Find the number of people in each country who have been suspected or confirmed with the disease who have been hospitalized

SELECT DISTINCT
    W1.Country, Number_of_people_Hospitalized
FROM
    (SELECT 
        COUNT(Isolated) AS Number_of_people_Hospitalized, country
    FROM
        isolation_records
    WHERE
        Hospitalised = 'Y'
    GROUP BY country) AS T1
        JOIN
    patient_info W1 ON T1.Country = W1.Country
WHERE
    W1.status = 'confirmed' OR 'suspected'
ORDER BY 2


-- Find the number of people who have been suspected or confirmed with the disease who have been isolated in each country.

SELECT DISTINCT
    W1.Country, Number_of_people_Isolated
FROM
    (SELECT 
        COUNT(Isolated) AS Number_of_people_Isolated, country
    FROM
        isolation_records
    WHERE
        Isolated = 'Y'
    GROUP BY country) AS T1
        JOIN
    patient_info W1 ON T1.Country = W1.Country
WHERE
    W1.status = 'confirmed' OR 'suspected'
ORDER BY 2

-- What are the number of confirmed or suspected cases in each country who have a travel history ?

SELECT DISTINCT
    W1.Country, People_With_Travel_History
FROM
    (SELECT 
        COUNT(Travel_history) AS People_With_Travel_History,
            country
    FROM
        isolation_records
    WHERE
        Travel_history = 'Y'
    GROUP BY country) AS T1
        JOIN
    patient_info W1 ON T1.Country = W1.Country
WHERE
    W1.status = 'confirmed' OR 'suspected'
order by 2 DESC

