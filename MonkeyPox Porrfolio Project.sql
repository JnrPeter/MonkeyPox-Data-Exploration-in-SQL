-- Finding the countries with confirmed cases and the means of confirmation
 
SELECT DISTINCT
    Country, Status,Confirmation_method
FROM
    pox_symptoms
WHERE
    status = 'confirmed'
        AND Country <> 'Unknown'
Order by 1        


-- Popularity of Confirmation methods across all countries

SELECT Count(confirmation_method) AS Count_of_Confirmation_Method, Confirmation_method
from pox_symptoms
Group by Confirmation_method
Order by 1 DESC


-- Finding the countries with suspected cases 

SELECT 
    Country, Status
FROM
    pox_symptoms
WHERE
    status = 'suspected'
        AND Country <> 'Unknown'
Order by 1


-- Finding number of confirmed cases in each country

SELECT 
    Country, COUNT(Status) AS Total_Number_Confirmed_Cases
FROM
    pox_symptoms
WHERE
    status = 'confirmed'
        AND Country <> ' Unknown'
GROUP BY Country
ORDER BY 2 DESC


-- Finding the number of suspected cases in each country
SELECT DISTINCT
    Country, COUNT(Status) AS Total_Suspected_Cases
FROM
    pox_symptoms
WHERE
    status = 'suspected'
        AND Country <> ' Unknown'
GROUP BY status , Country
ORDER BY 2 DESC


-- Age-ranges of the people who have the disease and their gender across all countries

SELECT DISTINCT
    age, Gender
FROM
    pox_symptoms
WHERE
    Age <> 'Unknown'
        AND status = 'Confirmed'




 -- Finding the most common age-range of suspected and confirmed cases in each country,as well as the gender of those age ranges

SELECT 
    country, gender, status, MAX(age) AS most_common_age_range
FROM
    pox_symptoms
WHERE
    status = 'confirmed'
        AND age <> 'Unknown'
GROUP BY GENDER , country 
UNION SELECT 
    country, gender, status, MAX(age) AS most_common_age_range
FROM
    pox_symptoms
WHERE
    status = 'suspected'
        AND age <> 'Unknown'
GROUP BY GENDER , country



-- Dates on which the cases were confirmed in each country and the time delay between onset of disease and confirmation

SELECT 
    country,
    date_confirmation,
    (Date_confirmation - Date_onset) AS time_delay_between_onset_and_confirmation_of_disease
FROM
    pox_symptoms
WHERE
    status = 'confirmed'
        AND age <> 'Unknown'
        AND Date_onset <> 0000 - 00 - 00


-- Most common symptoms of Monkey Pox in each country for suspected Or confirmed cases

SELECT 
    MAX(symptoms) AS most_common_Symptom, country
FROM
    pox_symptoms
WHERE
    Symptoms <> 'unknown'
        AND status = 'confirmed'
        OR 'suspected'
GROUP BY country


-- Total Number of people in each country who have been confirmed or suspected with the disease that have been isolated

SELECT DISTINCT
    W1.Country, Number_of_people_Isolated
FROM
    (SELECT 
        COUNT(Isolated) AS Number_of_people_Isolated, country
    FROM
        hospital_records
    WHERE
        isolated = 'Yes'
    GROUP BY country) AS T1
        JOIN
    pox_symptoms W1 ON T1.Country = W1.Country
WHERE
    W1.status = 'confirmed' OR 'suspected'
ORDER BY 2


-- Total number of confirmed or suspected cases in each country who have have a travel history

SELECT DISTINCT
    W1.Country, Number_of_People_With_Travel_History
FROM
    (SELECT 
        COUNT(Travel_history) AS Number_of_People_With_Travel_History,
            country
    FROM
        hospital_records
    WHERE
        Travel_history = 'Yes'
    GROUP BY country) AS T1
        JOIN
    pox_symptoms W1 ON T1.Country = W1.Country
WHERE
    W1.status = 'confirmed' OR 'suspected'
order by 2 DESC





