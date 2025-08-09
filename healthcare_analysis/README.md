# 🏥 Health Care Call Data Analysis Project

## 📌 Project Goal
Analyze healthcare call center data to track:
- Call volume
- Sales rep performance
- Call duration
- Activity plan execution

---

## 🛠 Tools & Technologies Used
- **SQL Server** — Data extraction & relationship mapping. Data cleaning & preliminary analysis
- **Power BI** — Dashboard creation & visualization
- **GitHub** — Version control & project sharing

---

## 📂 Project Files
- `dataset/` — Contains anonymized sample healthcare call center data
- `scripts/` — SQL and Python scripts used for analysis
- `dashboards/` — Power BI dashboards and screenshots
- `README.md` — Project documentation (this file)
- `documents` — Convert to PDF file
---

## 📂 About the Dataset

### **Overview**
- **Database:** HealthcareDataAnalysis  
- **Purpose:** This sample dataset includes Customer Information (HCO, HCP), Call Transactions, and Activity Plans for performance analysis and reporting.  
- **Scope:** Includes customer information, activity plan in March, and call transactions from **January 2024 to September 2024**.  

---

### **Database Structure**

#### **Table: dbo.Accounts**
Stores customer information including hospitals and doctors.  
**Primary key:** `UniqueIntegrationID`

| Column Name          | Data Type          | Description |
|----------------------|--------------------|-------------|
| RecordType           | nvarchar(50)       | Not Null    |
| UniqueIntegrationID  | nvarchar(10)       | Not Null, Primary Key |
| AccountName          | nvarchar(100)      | Not Null    |
| Specialty            | nvarchar(50)       | Null        |
| ParentAccount        | nvarchar(100)      | Null        |
| Classification       | nchar(1)           | Not Null    |
| Territory            | nchar(7)           | Not Null    |

---

#### **Table: dbo.AccountGoal**
Stores customers targeted for sales reps.  
**Primary key:** `AccountGoalUID`

| Column Name          | Data Type     | Description |
|----------------------|--------------|-------------|
| AccountGoalUID       | nvarchar(50) | Not Null, Primary Key |
| PlanCycleUID         | nvarchar(50) | Not Null    |
| UniqueIntegrationID  | nvarchar(10) | Not Null    |
| Territory            | nchar(7)     | Not Null    |

---

#### **Table: dbo.ActivityPlan**
Stores HQ goals for account goals.  
**Primary key:** `UID`

| Column Name    | Data Type     | Description |
|----------------|--------------|-------------|
| UID            | nvarchar(50) | Not Null, Primary Key |
| HQ_Goal        | int          | Null        |
| Actual         | int          | Null        |
| ActivityName   | nvarchar(50) | Not Null    |
| AccountGoalUID | nvarchar(50) | Not Null    |

---

#### **Table: dbo.PlanCycle**
Stores period information for the activity plan.  
**Primary key:** `PlanCycleUID`

| Column Name   | Data Type     | Description |
|---------------|--------------|-------------|
| PlanCycleUID  | nvarchar(50) | Not Null, Primary Key |
| Active        | bit          | Not Null    |
| EndDate       | date         | Not Null    |
| StartDate     | date         | Not Null    |
| Territory     | nchar(7)     | Not Null    |

---

#### **Table: dbo.CallLogging**
Stores call transactions from January 2024 to September 2024.  
**Primary key:** `CallName`

| Column Name       | Data Type       | Description |
|-------------------|----------------|-------------|
| CallName          | nvarchar(50)   | Not Null, Primary Key |
| UniqueIntegrationID | nvarchar(10) | Not Null    |
| AccountName       | nvarchar(100)  | Not Null    |
| DateTime          | datetime2(7)   | Not Null    |
| Territory         | nchar(7)       | Not Null    |
| Channel           | nvarchar(50)   | Not Null    |
| CallDuration      | int            | Not Null    |
| CallObjective     | nvarchar(50)   | Not Null    |
| Status            | nvarchar(50)   | Not Null    |

---

### **Relationships**
- **AccountGoal → ActivityPlan:** One-to-One  
- **Accounts → AccountGoal:** One-to-Many  
- **Accounts → CallLogging:** One-to-Many  

---

## 📊 Executive Summary

### **Key Objectives**
- Identify peak call times and trends.
- Measure sales rep performance and resolution efficiency.
- Identify top call objectives.
- Provide actionable recommendations.

---

## 📈 Key Metrics Overview

| Metric                  | Definition | Value       |
|-------------------------|------------|-------------|
| Total Calls Planned     | Sales calls made | 196 |
| Submission Rate         | % of calls submitted | 77.04% |
| Right Frequency (%)     | Calls per activity plan finished | 85.71% |
| Avg. Handling Time      | Average call length (minutes) | 15.92 mins |
| Min. Handling Time      | Shortest call length (minutes) | 5 mins |
| Most Objective Type     | Top call objectives | 5 |

---

## 📊 Analysis Highlights

### **Call Volume & Efficiency**
- **Peak Months:** May–August  
- **Top Territory:** VN11204 (22 total calls, 5 drafts)  
- **Submission Rate:** 77.04% → needs improvement.  
- **Avg Handling Time:** 15.92 mins (within suggested range of 10–15 mins).  
- **Short Calls:** Minimum time of 5 mins → too short for detailed product discussion.

**Recommendation:** Investigate reasons for unsubmitted calls and short durations.

---

### **Objectives Trend Analysis**
**Top 5 Call Objectives:**
1. Reminding Sample Orders (21.62%)  
2. Detailing Product (18.92%)  
3. Following Up (16.22%)  
4. Presenting CLM (16.22%)  
5. Discussing Benefits (13.51%)  

**Recommendation:**  
- Ensure timely sample delivery.  
- Optimize call scripts and CLM materials.  
- Compare benefits discussed with competitors.

---

### **Call Types & Channels**
- **Face-to-Face:** Most used channel.  
- **Messaging Apps:** Used for short follow-ups.  
- **Zoom:** Less frequent, used for longer discussions.  
- **Appointment Booking:** Longest duration calls.

**Recommendation:**  
- Streamline appointment booking with availability notes.  
- Improve interactive presentation materials.

---

## 🛠 Plan of Action (POA)
- All target accounts were visited.
- Verify missing visits.
- Check for new accounts outside POA.

---

## 🚀 Recommendations for Improvement
- Investigate high draft counts & system issues.
- Boost submission rates across all territories.
- Optimize handling times for efficiency.
- Share best practices from top-performing territories.
- Expand customer base from POA.

---
