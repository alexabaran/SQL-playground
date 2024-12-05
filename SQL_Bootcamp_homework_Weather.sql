/*1. Wczytaj pliki Summary of Weather.csv i Weather Station Locations.csv*/

--zapoznanie sie z danymi - sprawdzenie ile mamy wynikow
select * from "Weather_Zadanie".summary_of_weather sow; 
select sow."STA", count("STA") from "Weather_Zadanie".summary_of_weather sow 
group by 1
order by "STA" ;

select * from "Weather_Zadanie".weather_station_locations wsl order by "WBAN" ; 
select count("WBAN") from "Weather_Zadanie".weather_station_locations wsl 

/*3. Wykonaj i wrzuć na githuba zapytania, które odpowiedzą na te pytania:
a) Jaka była i w jakim kraju miała miejsce najwyższa dzienna amplituda temperatury? (25%)*/

select sow."STA" , wsl."STATE/COUNTRY ID", wsl."NAME",  max(sow."MaxTemp" - sow."MinTemp") as Daily_Temp_Diff
from "Weather_Zadanie".summary_of_weather sow 
join "Weather_Zadanie".weather_station_locations wsl on sow."STA" =wsl."WBAN"
group by 1,2,3
order by Daily_Temp_Diff desc
limit(1);

-- NOWA GWINEA - LAE

/*b) Z czym silniej skorelowana jest średnia dzienna temperatura dla stacji – szerokością (lattitude) czy długością (longtitude) geograficzną? (25%)*/

select wsl."Latitude", wsl."Longitude", avg(("MaxTemp" + "MinTemp")/2) as avg_daily
from "Weather_Zadanie"."summary_of_weather" 
join "Weather_Zadanie".weather_station_locations wsl on "STA" ="WBAN"
group by 1,2

with
	avgtemp as (select wsl."Latitude", wsl."Longitude", avg(("MaxTemp" + "MinTemp")/2) as avg_daily
	from "Weather_Zadanie"."summary_of_weather" 
	join "Weather_Zadanie".weather_station_locations wsl on "STA" ="WBAN"
	group by 1,2)
select	corr("avg_daily", "Latitude" ) as corr_latitude,
		corr("avg_daily", "Longitude" ) as corr_longitude
		from avgtemp;
	

-- Z szerokoscia geograficzną - Latitude
	
/*c) Pokaż obserwacje, w których suma opadów atmosferycznych (precipitation) przekroczyła sumę opadów z ostatnich 5 obserwacji na danej stacji. (25%)*/


with
	percip_table as (select sow."STA" , 
							sow."Date", 
							sow."Precip", 
							case when sow."Precip" = 'T' then null else sow."Precip" end as clean_percip  
							from "Weather_Zadanie".summary_of_weather sow ),
	result_table as (select "STA", 
							"Date",
							cast(clean_percip as float)as percip_cf,
							sum(cast(clean_percip as float))over (partition by "STA" order by "Date" rows between 5 preceding and 1 preceding) as "sum_previous5prec"
							from percip_table)
select "STA", "Date", "percip_cf", "sum_previous5prec" 
from result_table
where "percip_cf" > "sum_previous5prec" 


--- sprawdzenie czy mamy te same wyniki na tabelach tymczasowych

create temp table percip_test as 
select sow."STA" , 
sow."Date", 
sow."Precip", 
case when sow."Precip" = 'T' then null else sow."Precip" end as clean_percip  
from "Weather_Zadanie".summary_of_weather sow 

select *
from percip_test


create temp table percip_test2 as
select "STA", "Date",cast(clean_percip as float)as percip_cf,
		sum(cast(clean_percip as float)) over (partition by "STA" order by "Date" rows between 5 preceding and 1 preceding) as "sum_previous5prec" 
from percip_test

select *
from percip_test2
where percip_test2.percip_cf > percip_test2."sum_previous5prec" 
 
	
/*d) Uszereguj stany/państwa według od najniższej temperatury zanotowanej tam w okresie obserwacji używając do tego funkcji okna (25%)*/


select 	distinct wsl."STATE/COUNTRY ID",
		min(sow."MinTemp") over (partition by wsl."STATE/COUNTRY ID")as min_temp_state
from "Weather_Zadanie"."summary_of_weather" sow
join "Weather_Zadanie".weather_station_locations wsl on "STA" ="WBAN"
order by min_temp_state, wsl."STATE/COUNTRY ID"

-- sprawdzenie:
select wsl."STATE/COUNTRY ID" , min("MinTemp") as min_temp_state
from "Weather_Zadanie"."summary_of_weather" sow
join "Weather_Zadanie".weather_station_locations wsl on "STA" ="WBAN"
group by 1
order by min_temp_state, wsl."STATE/COUNTRY ID"


/*e) BONUS: czy gdzieś mogliśmy doświadczyć lipcowych opadów śniegu? (niespodzianka)*/
select sow."STA" , wsl."STATE/COUNTRY ID", wsl."NAME", sow."Date" , sow."Snowfall" 
from "Weather_Zadanie".summary_of_weather sow 
join "Weather_Zadanie".weather_station_locations wsl on sow."STA" =wsl."WBAN"
where date_part('month' , sow."Date" ) = 7 and sow."Snowfall" != '0'
order by sow."Snowfall" desc 

--W Cloncurry byl snieg w lipcu. Mamy tez 3 miejscowosci, w ktorych brakuje danych (mozliwy snieg - islandia,grenladnia )
