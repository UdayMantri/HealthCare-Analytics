Create Database HealthCare_Analysis;
use healthcare_analysis;
select *From Dialysis1;
Select * From dialysis2;

Select * from Dialysis_1 join Dialysis_2 on Dialysis_1.Provider_Number =Dialysis_2.CCN_Number;

#---------------------------KPI-1---------------------
#--------------Number of Patients across various summaries-------------------

SELECT 
    CONCAT(FORMAT(SUM(Num_Patients_Transfusion_Summary)/1000, '0.##'), 'k') as Num_Patients_Transfusion_Summary_K,
    CONCAT(FORMAT(SUM(Num_Patients_Hypercalcemia_Summary)/1000, '0.##'), 'k') as Num_Patients_Hypercalcemia_Summary_K,
    CONCAT(FORMAT(SUM(Num_Patients_SerumPhosphorus_Summary)/1000, '0.##'), 'k') as Num_Patients_SerumPhosphorus_Summary_K,
    CONCAT(FORMAT(SUM(Num_Patient_Hospitalizations_Summary)/1000, '0.##'), 'k') as Num_Patient_Hospitalizations_Summary_K,
    CONCAT(FORMAT(SUM(Num_Patients_Hospitalizations_Readmit_Summary)/1000, '0.##'), 'k') as Num_Patients_Hospitalizations_Readmit_Summary_K,
    CONCAT(FORMAT(SUM(Num_Patients_Survival_Summary)/1000, '0.##'), 'k') as Num_Patients_Survival_Summary_K,
    CONCAT(FORMAT(SUM(Num_Patients_Fistula_Summary)/1000, '0.##'), 'k') as Num_Patients_Fistula_Summary_K,
    CONCAT(FORMAT(SUM(Num_Patients_Catheter_Summary)/1000, '0.##'), 'k') as Num_Patients_Catheter_Summary_K,
    CONCAT(FORMAT(SUM(Num_Patients_nPCR_Summary)/1000, '0.##'), 'k') as Num_Patients_nPCR_Summary_K
FROM 
    Dialysis1;

#-----------------------KPI-2------------------------------
#--------------Profit Vs Non-Profit Stats---------------

Select ProfitNonProfit,count(Facility_Name) from dialysis1
group by ProfitNonProfit;

#--------------------------------------------KPI-3--------------------------------------------------------
#----------------Chain Organizations w.r.t. Total Performance Score as No Score----------------

Select Chain_Organization,count(Total_Performance_Score) as TPS_As_No_Score from dialysis1 as d1 join dialysis2 as d2 on d1.Provider_Number=d2.CCN_Number 
where d2.total_Performance_score = "No Score"
group by Chain_Organization;
Alter table `dialysis2` rename column `TotalPerformanceScore` to Total_Performance_Score;

#------------------------KPI-4------------------------------
#------------Dialysis Stations Stats----------------
          
SELECT State, COUNT(Dialysis_Stations_Stats) AS Dialysis_Stations_Count
from dialysis1
group by state
Order by Dialysis_Stations_Count DESC
LIMIT 10;

#---------------------------------KPI-5---------------------------------
# -----------------# of Category Text  - As Expected-----------------

SELECT
    CONCAT(FORMAT(ROUND(SUM(CASE WHEN Patient_Transfusion_category_text = 'As Expected' THEN Num_Patients_Transfusion_Summary END) / 1000), 0), 'k') AS transfusion_summary,
    CONCAT(FORMAT(ROUND(SUM(CASE WHEN Patient_Hospitalization_category_text = 'As Expected' THEN Num_Patient_Hospitalizations_Summary END) / 1000), 0), 'k') AS hospitalization_summary,
    CONCAT(FORMAT(ROUND(SUM(CASE WHEN Patient_Survival_category_text = 'As Expected' THEN Num_Patients_Survival_Summary END) / 1000), 0), 'k') AS survival_summary,
    CONCAT(FORMAT(ROUND(SUM(CASE WHEN Patient_Infection_category_text = 'As Expected' THEN Standard_Infection_Ratio END) / 1000), 0), 'k') AS _standard_infection_summary,
    CONCAT(FORMAT(ROUND(SUM(CASE WHEN Fistula_Category_Text = 'As Expected' THEN Num_Patients_Fistula_Summary END) / 1000), 0), 'k') AS fistula_summary,
    CONCAT(FORMAT(ROUND(SUM(CASE WHEN SWR_Category_Text = 'As Expected' THEN Num_Patients_SWR END) / 1000), 0), 'k') AS swr_summary,
    CONCAT(FORMAT(ROUND(SUM(CASE WHEN PPPW_Category_Text = 'As Expected' THEN Num_Patients_PPPW END) / 1000), 0), 'k') AS pppw_summary
FROM
    dialysis1;
    
#--------------------------------------KPI-6---------------------------------------
#-------------------Average Payment Reduction Rate---------------------
    
SELECT CONCAT(ROUND(AVG(Payment_Reduction_Percentage), 4)*100, '%') AS Average_Percentage
FROM dialysis2;




    
    
    
    
    





    

    
    
    
    
    

