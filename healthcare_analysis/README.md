Health Care Call Data Analysis Project

Project Goal

Analyze healthcare call center data to track call volume, sales rep performance, call duration, and activity plan.


About the dataset
- Overview
●	Database: HealthcareDataAnalysis
●	Purpose: This sample dataset includes Customer Information (HCO,HCP), Call Transactions and Activity Plan for performance analysis and reporting.
●	Scope: Includes customer information, activity plan in March and call transactions from January 2024 to September 2024
- Database Structure
Table: dbo.Accounts
Description: Stores customer information including hospitals and doctors.
Primary key: UniqueIntegrationID
Column Name	Data Type	Description
[RecordType]	[nvarchar](50)	Not Null
[UniqueIntegrationID]	[nvarchar](10)	Not Null,Primary Key
[AccountName]	[nvarchar](100)	Not Null
[Specialty]	[nvarchar](50)	Null
[ParentAccount]	[nvarchar](100)	Null
[Classification]	[nchar](1)	Not Null
[Territory]	[nchar](7)	Not Null

Table: dbo.AccountGoal
Description: Stores customers targeted for sales rep.
Primary key: AccountGoalUID
Column Name	Data Type	Description
[AccountGoalUID]	[nvarchar](50)	Not Null,Primary Key
[PlanCycleUID]	[nvarchar](50)	Not Null
[UniqueIntegrationID]	[nvarchar](10)	Not Null
[Territory]	[nchar](7)	Not Null

Table: dbo.ActivityPlan
Description: Stores HQ goals for account goals.
Primary key: UniqueIntegrationID
Column Name	Data Type	Description
[UID]	[nvarchar](50)	Not Null,Primary Key
[HQ_Goal]	[int]	Null
[Actual]	[int]	Null
[ActivityName]	[nvarchar](50)	Not Null
[AccountGoalUID]	[nvarchar](50)	Not Null
 
Table: dbo.PlanCyle
Description: Stores period information for activity plan. 
Primary key: PlanCycleUID
Column Name	Data Type	Description
[PlanCycleUID]	[nvarchar](50)	Not Null, Primary Key
[Active]	[bit]	Not Null
[EndDate]	[date]	Not Null
[StartDate]	[date]	Not Null
[Territory]	[nchar](7)	Not Null

Table: dbo.CallLogging
Description: Stores call transactions from January 2024 to September 2024
Primary key: UniqueIntegrationID
Column Name	Data Type	Description
[CallName]	[nvarchar](50)	Not Null,Primary Key
[UniqueIntegrationID]	[nvarchar](10)	Not Null
[AccountName]	[nvarchar](100)	Not Null
[DateTime]	[datetime2](7)	Not Null
[Territory]	[nchar](7)	Not Null
[Channel]	[nvarchar](50)	Not Null
[CallDuration]	[int]	Not Null
[CallObjective]	[nvarchar](50)	Not Null
[Status]	[nvarchar](50)	Not Null

- Relationships
●	AccountGoal 🡪 Activity Plan: One-to-One: each customer in the Account Goal table can have one record in Activity Plan table.
●	Accounts 🡪 AccountGoal: One-to-Many: each customer in the Accounts table can assigned to multiple territories in Account Goal table.
●	Accounts 🡪 CallLogging: One-to-Many: each customer in Accounts table can have multiple calls associated with.
- Key Features and Constraints
●	Primary & Foreign Keys
●	PK_AccountGoal: AccountGoalID is a Primary Key in AccountGoal table
●	FK_AccountGoal_Accounts: One-to-Many relationship
●	PK_Accounts: UniqueIntegrationID is a Primary Key in Accounts table
●	PK_ActivityPlan: UID is a Primary Key in ActivityPlan table
●	FK_ActivityPlan_AccountGoal: One-to-One relationship
●	PK_CallLogging: CallName is a Primary Key in CallLogging table
●	FK_CallLogging_Accounts: One-to-Many relationship
●	FK_CallLogging_PlanCyle: Many-to-One relationship
- Usage Context
●	Business Use Cases: The database supports tracking and analyzing the rep performance and call quality.
●	Data Flow: Customer information stores in Accounts table, and they will be assigned to territories through AccountGoal table. Each record in AccountGoal is going to be targeted to a HQ goal in ActivityPlan table. CallLogging table will store all call transactions between Rep and customers which are from Accounts.  
 
Executive Summary
This report presents an analysis of healthcare call center data to evaluate call volume, sales rep performance, key messages and plan of action. The key objectives include:
●	Identifying peak call times and issue trends
●	Measuring sales rep performance and resolution efficiency
●	Identifying the most important messages 
●	Providing actionable insights to enhance call quality
* Key Metrics Overview

Metric	Definition	Value
Total Calls Planned	Number of sales calls made	196
Submission Rate	% of sales calls submitted	77.04%
Right Frequency (%)	Number of sales calls per activity plan finished on a particular customer	85.71%
Average Handling Time	Average length of a sales call (minutes)	15.92 mins
Minimum Handling Time	Minimum length of a sales call (minutes)	5 mins
Most Objective Type	Top call objectives for sales calls	5
* Call Volume & Efficiency Analysis
●	Total Calls: 196 calls handled during the period
●	Peak Call Months: The highest call traffic was observed between May and August, the territory VN11204 has the highest calls (22 total, 5 drafts). Other territories have consistent performance (~20 calls each). 
●	Submission Rate: 77.04% of calls successfully submitted. This suggests a good performance, but there are more than 20% of calls dropped. So further analysis is needed to check why they were not submitted.
●	Call Handling Efficiency: The Average Handling Time is 15.92 mins indicating the majority of calls were made successfully with suggested duration. The standard call should last from 10-15 mins to be discussed with doctors. The Minimum Handing Time is 5 mins, it is too short to discuss detailed products, we can check what is the reason. Is the doctor busy? 
●	Right Frequency: 85.71% of calls achieved during the period. A high value suggests good coverage.

🔹 Recommended Action: Need to check why there are lots of calls which were not submitted.
* Objectives Trend Analysis
🔹 The top 5 most common call objectives used by sales rep:
●	Reminding Sample Orders (21.62%)
●	Detailing Product (18.92%)
●	Following Up (16.22%)
●	Presenting CLM (16.22%)
●	Discussing Benefits (13.51%)

🔹 Recommended Action: Most of calls have discussed about reminding sample orders, the doctors are more interesting and consider about the product. 🡪 Support, provide the samples to doctors on time and ensure their quality. Might check with the medical team and respond if there are any inquiries asked.
Detailing Product is the second point that we used during sales calls, this ensures that doctors have been provided detailed product information. Closed-loop marketing materials have been used effectively with 16.22% 🡪 The marketing team and medical can help to optimize and streamline the call scripts or materials. 
The last one is Discussing Product’s Benefits with 13.51% 🡪 Further analysis is needed whether we can compare with competitor’s product.

* Call Types and Call Channels
The majority of interactions are of standard duration with 88 calls, higher short and long calls. Face-to-Face is the most used channel across call duration types. SMS/WhatsApp/Line is mainly used in Short and Long Calls, suggesting that quick check-ins or follow-ups happen via messaging apps. Zoom is present but less frequent, likely used for more extended discussions, suggesting that attend online meetings or conferences.

●	Appointment Booking has the longest call duration, indicating it requires more discussion with doctors to confirm the date time.
●	Reporting Performance, Presenting CLM, and Prescription Inquiry also have significantly high call handling time, suggesting they involve detailed materials. 
●	Follow-ups and Sample Order Reminders are the shortest calls (9–5 minutes), indicating these are quick check-ins and verifications for the sample orders. 

🔹Recommended Actions: For appointment booking, we can streamline by using the best time notes to check whether the doctors are available. Medical and marketing team continue to improve and standardize our documents. Might communicate with the agency to create more interactive and useful presentations.

* Plan of Action (POA)
The list of interacted accounts is equal to target accounts list, indicating sales rep has visited to correct customers and ensure hq goal. If there are any missing visits, I might need to cross-check with sales reps. The list of interacted accounts by territory also might have new customers who are not included in the POA, if yes then admin can check and verify with sales rep to add those new customers to the database. 
* Recommendations for Improvement
1.	Investigate High Draft Counts → Why are some calls not fully submitted? System issues? Missing information?
2.	Boost Submission rate to ensure the efficiency and finalize call results as there are lots of draft calls. 
3.	Optimize Call Handling Time → Some calls made within 5 mins, it’s too short to present. Can break down by call type & find improvement areas.
4.	Compared Submission Rate by Territory → VN11202 and VN11204 are performing better, they achieve more than 80% call submission rate. Verify and apply best practices across all territories.
5.	Ensure short calls via SMS/WhatsApp that meet required engagement terms.
6.	Encourage to explore more new customers from POA.

