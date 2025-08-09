
USE [HealthCare DataAnalysis]

SELECT CallName, Status, DateTime
FROM CallLogging;

--Handling missing values in Status
UPDATE CallLogging
SET Status = COALESCE(Status,'Draft');

--Removing duplicate callname
DELETE FROM CallLogging
WHERE CallName NOT IN (SELECT MIN(CallName) FROM CallLogging GROUP BY CallName);

--Formatting the date field
UPDATE CallLogging 
SET DateTime = CAST(DateTime AS date);

--Total calls per month
WITH C1 AS(SELECT MONTH(DateTime) AS Month, CallName FROM CallLogging)
SELECT C1.Month, COUNT(C1.CallName) AS Total_Calls_per_month 
FROM C1
GROUP BY Month
ORDER BY Total_Calls_per_month ;

--Calls Submitted vs Draft
SELECT 
    Status, 
    COUNT(CallName) AS Total_Calls
FROM CallLogging
GROUP BY Status;
--Percentage
SELECT 
    Status, 
    COUNT(CallName) AS TotalCalls, 
    CAST((COUNT(CallName) * 100.0 / (SELECT COUNT(*) FROM CallLogging)) AS decimal(16,2)) AS Percentage
FROM CallLogging
GROUP BY Status;


--Average Call Duration by Call Objective
SELECT 
    CallObjective, 
    AVG(CallDuration) AS Avg_Call_Duration 
FROM CallLogging
GROUP BY CallObjective;
--Call Duration 
SELECT 
    MIN(CallDuration) AS MinDuration, 
    AVG(CallDuration) AS AvgDuration, 
    MAX(CallDuration) AS MaxDuration
FROM CallLogging;

--Call Performance By Channel
SELECT 
    Channel, 
    COUNT(CallName) AS TotalCalls, 
    CAST((COUNT(CallName) * 100.0 / (SELECT COUNT(*) FROM CallLogging)) AS decimal(16,2)) AS Percentage
FROM CallLogging
GROUP BY Channel;


--Top 5 Most Frequent Call Objective
SELECT 
    TOP 5 CallObjective, 
    COUNT(*) AS Objective_Count 
FROM CallLogging
GROUP BY CallObjective
ORDER BY Objective_Count DESC;

-- Call Handled & Submission Rate
SELECT 
    A.AccountName, 
    COUNT(C.CallName) AS Calls_Handled, 
    SUM(CASE WHEN C.Status = 'Submitted' THEN 1 ELSE 0 END) * 100 / COUNT(C.CallName) AS Submission_Rate
FROM CallLogging C
JOIN Accounts A ON C.UniqueIntegrationID = A.UniqueIntegrationID
GROUP BY A.AccountName
ORDER BY Submission_Rate DESC;


--Check and Update Activity Plan (POA & Actual)
WITH CallTemp AS(
SELECT CONCAT('2025-03-',Territory,'-',UniqueIntegrationID) as Comb, Territory, UniqueIntegrationID , COUNT (CallName) AS SubmittedCalls FROM CallLogging
WHERE Status = 'Submitted'
GROUP BY  CONCAT('2025-03-',Territory,UniqueIntegrationID), Territory, UniqueIntegrationID
)
,
POA AS(SELECT AG.AccountGoalUID as AccGoalUID, AG. Territory, C.SubmittedCalls As Actual, AP.HQ_Goal
FROM CallTemp C
JOIN AccountGoal AG ON C.Comb  = AG.AccountGoalUID
JOIN ActivityPlan AP ON AG.AccountGoalUID = AP.AccountGoalUID
GROUP BY AG.AccountGoalUID, AG. Territory,C.SubmittedCalls,AP.HQ_Goal )

UPDATE ActivityPlan
SET ActivityPlan.Actual = POA.Actual 
FROM ActivityPlan
INNER JOIN POA 
ON ActivityPlan.AccountGoalUID = POA.AccGoalUID;

--% Achievement
SELECT ActivityPlan.AccountGoalUID,ActivityPlan.ActivityName, ActivityPlan.HQ_Goal, ActivityPlan.Actual,(Actual *100/ HQ_Goal) AS Achievement,
(CASE 
    WHEN (Actual *100 / HQ_Goal) >= 90 THEN 'Green'
	WHEN (Actual *100 / HQ_Goal) < 90 THEN 'Red'
    ELSE 'No activites'
END) AS Type
FROM ActivityPlan;

USE [HealthCare DataAnalysis]
GO


