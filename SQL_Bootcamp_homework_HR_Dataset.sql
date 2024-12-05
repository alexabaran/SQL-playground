/*
1. Przejrzyj plik z danymi HR_Dataset.csv
2. Stwórz w dbeaver tabelę odpowiadającą danym i zaimportuj dane z pliku
3. Wykonaj zapytania odpowiadające na pytania:
a. Ilu pracowników znajduje się w bazie danych tej firmy?
b. Ilu aktywnych pracowników (Termd = 0) nie jest obywatelami USA?
c. Czy ID pracowników (EmpID) jest unikalne?
d. Jakie są widełki zarobków (minimum i maksimum)? Jakie one są dla poszczególnych pozycji?
e. Ile osób jest zatrudnionych na stanowisku Production Technician (niezależnie od rangi)?
f. Dlaczego Carol Anderson zrezygnowała z pracy?
g. Podopieczni której/go managerki/a są najbardziej zadowoleni z pracy (EmpSatisfaction)?
h. BONUS: ile jest departamentów, w których więcej niż 5 aktywnych pracowników przekracza oczekiwania odnośnie performance’u?*/


/*2. Stwórz w dbeaver tabelę odpowiadającą danym i zaimportuj dane z pliku*/

create table "HR_Dataset_Zadanie"."HR_Dataset"(
	"Employee_Name" VARCHAR(100),
	"EmpID" VARCHAR UNIQUE,
	"MarriedID" INT, 
	"MaritalStatusID" INT,
	"GenderID" INT,
	"EmpStatusID" INT,
	"DeptID" INT,
	"PerfScoreID" INT,
	"FromDiversityJobFairID" INT,
	"Salary" INT,
	"Termd" INT,
	"PositionID" INT,
	"Position" VARCHAR(50),
	"State" VARCHAR(2),
	"Zip" VARCHAR(5),
	"DOB" DATE,
	"Sex" VARCHAR,
	"MaritalDesc" VARCHAR(10),
	"CitizenDesc" VARCHAR(50),
	"HispanicLatino" VARCHAR(3),
	"RaceDesc" VARCHAR(50),
	"DateofHire" DATE,
	"DateofTermination" DATE,
	"TermReason" VARCHAR(50),
	"EmploymentStatus" VARCHAR(50),
	"Department" VARCHAR(50),
	"ManagerName" VARCHAR(50),
	"ManagerID" INT,
	"RecruitmentSource" VARCHAR(50),
	"PerformanceScore" VARCHAR(50),
	"EngagementSurvey" FLOAT,
	"EmpSatisfaction" INT,
	"SpecialProjectsCount" INT,
	"LastPerformanceReview_Date" DATE,
	"DaysLateLast30" INT,
	"Absences" INT
	);
	
select * from "HR_Dataset_Zadanie"."HR_Dataset" hd ;

/*3. Wykonaj zapytania odpowiadające na pytania:
a. Ilu pracowników znajduje się w bazie danych tej firmy?*/
select count(*) from "HR_Dataset_Zadanie"."HR_Dataset" hd ;
--or
select count("EmpID") from "HR_Dataset_Zadanie"."HR_Dataset" hd ; 
--311 osob jest w bazie danych tej firmy

/*b. Ilu aktywnych pracowników (Termd = 0) nie jest obywatelami USA?*/
select count("EmpID") 
from "HR_Dataset_Zadanie"."HR_Dataset" hd
where "Termd" = 0 and "CitizenDesc" not like 'US Citizen';
-- 8 osob jest aktywnych i nie jest obywatelami USA

/*c. Czy ID pracowników (EmpID) jest unikalne?*/
select distinct "EmpID", Count("EmpID") 
from "HR_Dataset_Zadanie"."HR_Dataset" hd
group by "EmpID"
order  by 2,1;

-- Są - i powinny być ponieważ przy tworzeniu tabeli zadano -- "EmpID" VARCHAR UNIQUE,

/*d. Jakie są widełki zarobków (minimum i maksimum)? Jakie one są dla poszczególnych pozycji?*/
select max("Salary") as "max_salary", min("Salary") as "min_salary"
from "HR_Dataset_Zadanie"."HR_Dataset" hd;
-- max wyplata 250 000 minimalna 45 046

select distinct "Position",  max("Salary") as "max_salary", min("Salary") as "min_salary"
from "HR_Dataset_Zadanie"."HR_Dataset" hd
group by 1
order by 1;

/*e. Ile osób jest zatrudnionych na stanowisku Production Technician (niezależnie od rangi)?*/
select count("Position") 
from "HR_Dataset_Zadanie"."HR_Dataset" hd 
where "Position" ilike 'Production Technician%';

--194

/*f. Dlaczego Carol Anderson zrezygnowała z pracy?*/
select "Employee_Name", "TermReason"  
from "HR_Dataset_Zadanie"."HR_Dataset" hd 
where "Employee_Name" ilike  'Anderson%Carol%' ;

-- return to school

/*g. Podopieczni której/go managerki/a są najbardziej zadowoleni z pracy (EmpSatisfaction)?*/
select "ManagerName" , avg("EmpSatisfaction") as "avg_emp_sat"
from "HR_Dataset_Zadanie"."HR_Dataset" hd 
group by 1
order by 2 desc
limit(1);

-- Debra Houlihan


/*h. BONUS: ile jest departamentów, w których więcej niż 5 aktywnych pracowników przekracza oczekiwania odnośnie performance’u?*/
	
select "Department", "DeptID", "PerformanceScore", count("PerformanceScore" = 'Exceeds') as "count_exceeds"
from "HR_Dataset_Zadanie"."HR_Dataset" hd
where "PerformanceScore" = 'Exceeds' 
group by 1,2,3
having count("PerformanceScore" = 'Exceeds') > 5;
