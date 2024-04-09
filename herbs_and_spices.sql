--DATA EXPLORATION - NUTRTIONAL CONTENT OF FOOD


--dataset we'll be working with
Select*
From nutrition
--SPECIFICALLY ANALYZING NUTRITIONAL CONTENTS OF HERBS AND SPICES
--removed 2048, since vinegar is not an herb or spice
Select *
From nutrition
where NDB_No between 2001 and 2049 AND NDB_No <> 2048
--removed 2044 and 2045 to keep GmWt_Desc1 measurements(1 tsp) consistent
--2044 and 2045 removes ('BASIL,FRESH' and 'DILL WEED,FRSH' respectively)
Select *
From nutrition
where NDB_No between 2001 and 2049 AND NDB_No <> 2048 AND NDB_No <> 2044 AND NDB_No <> 2045

--creating a new table to focus on herbs and spices with only minerals and main macronutrients within the nutrtition table
Select
	Shrt_Desc AS Spice_Name,
	Energ_Kcal AS Calories,
	"Protein_(g)" AS Protein,
	"Carbohydrt_(g)" AS Carbs,
	"Calcium_(mg)" as Calcium,
	"Phosphorus_(mg)" as Phosphorus,
	"Zinc_(mg)" as Zinc,
	"Copper_mg)" as Copper,
	"Manganese_(mg)"  as Manganese,
	"Selenium_()" as Selenium,
	"Iron_(mg)" as Iron,
	"Magnesium_(mg)" as Magnesium,
	"Potassium_(mg)" as Potassium,
	"Sodium_(mg)" as Sodium,
	GmWt_1 as Gram_Weight,
	"GmWt_Desc1" as Gram_Weight_Desc
INTO dbo.herbs_spices
FROM dbo.nutrition
WHERE NDB_No between 2001 and 2049 AND NDB_No <> 2048 AND NDB_No <> 2044 AND NDB_No <> 2045


--new created table with specific info for analysis
Select *
From herbs_spices


--which spices are the most calorie dense
Select Spice_Name, Calories
From herbs_spices
order by 2 desc
--which spices contain the most protein
Select Spice_Name, Protein
From herbs_spices
order by 2 desc
--which spices contain the most carbs
Select Spice_Name, Carbs
From herbs_spices
order by 2 desc


--salt metrics are insignficant in almost every category except sodium
--spices with most sodium
Select Spice_Name, Sodium
From herbs_spices
order by 2 desc

--selenium contains null values in some spices
--updating Selenium column to show null values as int (0)
UPDATE dbo.herbs_spices
Set Selenium=0
Where Selenium is null
--spices that contain the mineral Selenium
Select Spice_Name, Selenium
From herbs_spices
order by 2 desc


--overview of minerals in each spice, excluding 'SALT,TABLE'
Select Spice_Name, Iron, Zinc, Copper, Manganese, Phosphorus, Magnesium, Potassium, Calcium, Sodium, Selenium
From herbs_spices
