/*1. Na podstawie tabeli movies wyświetl informacje (id, title, release_date) o dziesięciu 
najwcześniej wydanych filmach. 

 
   id   |             title              | release_date 
--------+--------------------------------+-------------- 
  43395 | Two Weeks with Love            | 1950-01-01 
  43387 | Francis                        | 1950-01-01 
  83015 | The Happiest Days of Your Life | 1950-01-01 
 109364 | Guernica                       | 1950-01-01 
  43391 | The Flying Saucer              | 1950-01-04 
  51411 | Ma and Pa Kettle Go to Town    | 1950-01-04 
  65586 | Davy Crockett, Indian Scout    | 1950-01-06 
  20088 | Kon-Tiki                       | 1950-01-12 
 151310 | Ambush                         | 1950-01-13 
  35404 | The File on Thelma Jordon      | 1950-01-18 */

select id, title, release_date 
from movies
order by release_date, id 
limit 10;
  
/*2. Na podstawie tabeli movies wyświetl streszczenie filmu o tytule Niagara. 
                                                                                              
overview                                                                                                                                          
---------------------------------------------------------------------------------- 
Rose Loomis and her older, gloomier husband, George, are vacationing at a cabin in 
Niagara Falls, N.Y. The couple befriend Polly and Ray Cutler, who are honeymooning 
in the area. Polly begins to suspect that something is amiss between Rose and 
George, and her suspicions grow when she sees Rose in the arms of another man. While 
Ray initially thinks Polly is overreacting, things between George and Rose soon take 
a shockingly dark turn. */

select overview
from movies
where title = 'Niagara';

/*3. Na podstawie tabeli movies wyświetl tytuły i daty wydania filmów wydanych 
w sierpniu 1954 roku. Wyniki posortuj według tytułów. 

             title              | release_date 
--------------------------------+-------------- 
 About Mrs. Leslie              | 1954-08-03 
 Fright to the Finish           | 1954-08-27 
 Human Desire                   | 1954-08-05 
 King Richard And The Crusaders | 1954-08-07 
 Magnificent Obsession          | 1954-08-07 
 Pushover                       | 1954-08-06 
 Rear Window                    | 1954-08-01 
 Robinson Crusoe                | 1954-08-05 
 Shield for Murder              | 1954-08-27 
 The Black Knight               | 1954-08-26 
 The Egyptian                   | 1954-08-25 
 The Raid                       | 1954-08-04 
 The Vanishing Prairie          | 1954-08-17 */

select title, release_date
from movies
where release_date between '1954-08-01' and '1954-08-31'
order by title;

/*4. Na podstawie tabeli movies wyświetl informacje (id, title, budget) o pięciu filmach z najwyższym budżetem. 

  id   |     title      |  budget 
-------+----------------+---------- 
 11071 | Them!          | 23000000 
  7983 | Tiefland       |  8500000 
 11620 | Quo Vadis      |  8250000 
  4825 | Guys and Dolls |  5500000 
  3111 | A Star Is Born |  5019770 */

select id, title, budget
from movies
where budget is not null
order by budget desc
limit 5;
 
/*5. Na podstawie tabeli movies wyświetl wszystkie tytuły rozpoczynające się od litery Y. 

         title 
------------------------ 
 Young Man with a Horn 
 Young at Heart 
 Young Bess 
 You're Never Too Young */

 select title
 from movies
 where title ilike 'Y%';

/*6. Na podstawie tabeli movies wyświetl tytuły i streszczenia filmów, których streszczenia zawierają słowo robot. 


             title             |         overview                                                                                                                                                                                                                                                                                                                                                                                               
-------------------------------+----------------------------------------  
 The Day the Earth Stood Still | An alien and a robot land on ... 
 Devil Girl from Mars          | An uptight, leather-clad female...  
 Target Earth                  | Giant robots from Venus... 
 Robot Monster                 | Ro-Man, an alien robot... 
 Tobor the Great               | To avoid the life-threatening...  
 Zombies of the Stratosphere   | Martians come to Earth to... */

 select title, overview
 from movies
 where overview ilike '%robot%';

/*7. Na podstawie tabeli movies wyświetl wszystkie tytuły liczące więcej, niż 45 znaków. 

                      title 
-------------------------------------------------- 
 Abbott and Costello Meet Dr. Jekyll and Mr. Hyde 
 Screen Directors Playhouse:  Meet the Governor */

select title
from movies
where length(title) > 45;

/*8. Na podstawie tabeli movies wyświetl dwa najkrótsze tytuły filmów wydanych w roku 1950. 

title | release_date 
-------+-------------- 
 Kim   | 1950-12-07 
 Caged | 1950-05-19 */

select title, release_date
from movies
where release_date between '1950-01-01' and '1950-12-31' 
order by length(title) asc
limit 2;


/*9. Na podstawie tabeli movies, dla 70-minutowych filmów z lat 1952 i 1953 wyświetl: pierwszych 15 znaków tytułów 
filmów z doklejonymi trzema kropkami, ich lata wydania i czasy trwania. Wyniki posortuj według dat wydania. 

       title        | release_year | runtime 
--------------------+--------------+--------- 
 Jack and the Be... | 1952         |      70 
 Bomba and the J... | 1952         |      70 
 Abbott and Cost... | 1952         |      70 
 Operation Diplo... | 1953         |      70 */

select 
concat(substring(title, 1, 15), '...') as truncated_title,
extract(year from release_date) as release_year,
runtime
from movies
where runtime = 70 and extract(year from release_date) in (1952, 1953)
order by release_date;

/*10. Na podstawie tabeli persons, dla rekordów o id mniejszym od 500, wyświetl: identyfikatory i przekształcone do 
wielkich liter imiona/nazwiska. Wyniki posortuj według imion/nazwisk. 

 id  |       upper 
-----+------------------- 
 113 | CHRISTOPHER LEE 
 190 | CLINT EASTWOOD 
 397 | DARIO MORENO 
  68 | FRITZ LANG 
  78 | FRITZ RASP 
 400 | GERALDINE CHAPLIN 
  40 | ORSON WELLES 
   5 | PETER CUSHING 
 251 | ROBERT BEATTY 
 240 | STANLEY KUBRICK 
 247 | WILLIAM SYLVESTER */
 
select id, upper(name) as upper
from persons
where id < 500
order by upper;

/*11. Na podstawie tabeli movies, dla filmów o budżecie powyżej 5000000 wyświetl: identyfikatory, tytuły i budżety 
wyrażone w milionach dolarów (zaokrąglone do wartości całkowitych, z doklejonym słowem million). Wyniki posortuj 
malejąco według budżetów. 

  id   |     title      | budget_mil 
-------+----------------+------------ 
 11071 | Them!          | 23 million 
  7983 | Tiefland       | 8 million 
 11620 | Quo Vadis      | 8 million 
  3111 | A Star Is Born | 5 million 
  4825 | Guys and Dolls | 5 million */
  
select id, title, concat(round(budget / 1000000), ' million') as budget_mil
from movies
where budget > 5000000
order by budget_mil;

/*12. Na podstawie tabeli movies odczytaj numery lat, z których pochodzą filmy. 

extract 
--------- 
    1951 
    1954 
    1953 
    1950 
    1955 
    1952 */

select distinct extract(year from release_date) as extract
from movies;

/*13. Na podstawie tabel movies i languages wyświetl tytuły wszystkich filmów posługujących się językiem o nazwie 
Polski. 

     title      |  name 
----------------+-------- 
 Pokolenie      | Polski 
 Irena do domu! | Polski */

 

/*14. Na podstawie tabel movies, actors i persons,  wyświetl aktorów, którzy wystąpili w filmie Singin' in the Rain. 

       name 
------------------- 
 Kathleen Freeman 
 Rita Moreno 
 Debbie Reynolds 
 Gene Kelly 
 Donald O'Connor 
 Jean Hagen 
 Millard Mitchell 
 Cyd Charisse 
 Douglas Fowley 
 Mae Clarke 
 Bess Flowers 
 Robert Foulk 
 Joi Lansing 
 Sylvia Lewis 
 'Snub' Pollard 
 William Schallert 
 Elaine Stewart 
 Brick Sullivan 
 John George */

select p.name
from persons p
join actors a on p.id = a.person_id
join movies m on a.movie_id = m.id
where m.title = 'Singin'' in the Rain';
 

/*15. Na podstawie tabel movies, directors i persons wyświetl wszystkie filmy reżyserowane przez Stanleya Kubricka 
i Alfreda Hitchcocka. Wyniki posortuj według tytułów. 


         title          |       name 
------------------------+------------------ 
 Day of the Fight       | Stanley Kubrick 
 Dial M for Murder      | Alfred Hitchcock 
 Fear and Desire        | Stanley Kubrick 
 Flying Padre           | Stanley Kubrick 
 I Confess              | Alfred Hitchcock 
 Killer's Kiss          | Stanley Kubrick 
 Rear Window            | Alfred Hitchcock 
 Stage Fright           | Alfred Hitchcock 
 Strangers on a Train   | Alfred Hitchcock 
 The Seafarers          | Stanley Kubrick 
 The Trouble with Harry | Alfred Hitchcock 
 To Catch a Thief       | Alfred Hitchcock */

select m.title, p.name
from movies m
join directors d on m.id = d.movie_id
join persons p on d.director_id = p.id
where p.name in ('Stanley Kubrick', 'Alfred Hitchcock')
order by m.title;

/*16. Na podstawie tabeli movies, korzystając z operacji połączenia zwrotnego, znajdź spośród filmów wydanych w 
drugim kwartale 1950 roku wszystkie pary filmów, które zostały wydane w tym samym dniu. Wyniki posortuj według 
daty wydania i tytułu filmu. 


 release_date |        title         |       title 
--------------+----------------------+-------------------- 
 1950-04-01   | Double Confession    | One Way Street 
 1950-04-01   | Night and the City   | One Way Street 
 1950-04-01   | Night and the City   | Double Confession 
 1950-05-11   | Champagne For Caesar | Stars in My Crown 
 1950-05-17   | In a Lonely Place    | Annie Get Your Gun 
 1950-05-19   | Shadow on the Wall   | Caged 
 1950-06-01   | The Lawless          | The Good Humor Man */

select 
m1.release_date, 
m1.title as title_1, 
m2.title as title_2
from movies m1
join movies m2 on m1.release_date = m2.release_date
where m1.release_date between '1950-04-01' and '1950-06-30' and m1.id < m2.id
order by m1.release_date, m1.title;

/*17. Na podstawie tabel movies, actors i persons znajdź filmy, w których wspólnie jednocześnie zagrali Marilyn 
Monroe i Cary Grant. 

      title 
----------------- 
 Monkey Business */

select m.title
from movies m
join actors a1 on m.id = a1.movie_id
join persons p1 on a1.person_id = p1.id
join actors a2 on m.id = a2.movie_id
join persons p2 on a2.person_id = p2.id
where p1.name = 'Marilyn Monroe' and p2.name = 'Cary Grant';

/*18. Na podstawie tabel movies, actors, directors i persons znajdź filmy z 1951 roku, w których reżyser był 
jednocześnie aktorem. Wyniki posortuj według tytułów filmów. 


         title          |        name 
------------------------+--------------------- 
 Das Haus in Montevideo | Curt Goetz 
 Das Haus in Montevideo | Valerie von Martens 
 Day of the Fight       | Stanley Kubrick 
 Der Verlorene          | Peter Lorre 
 On Dangerous Ground    | Ida Lupino 
 Othello                | Orson Welles 
 Santa Fe               | Irving Pichel 
 Strangers on a Train   | Alfred Hitchcock */
 
select m.title, p.name
from movies m
join directors d on m.id = d.movie_id
join persons p on d.director_id = p.id
join actors a on m.id = a.movie_id
where extract(year from m.release_date) = 1951 and a.person_id = p.id
order by m.title;

 
/*19. Policz rekordy w tabeli movies. 

 count 
------- 
  1008 */

select count(*) as count
from movies;

/*20. Na podstawie tabeli movies znajdź rok, w którym wydano najmniej filmów.

extract | count 
---------+------- 
    1954 |   156 */

select extract(year from release_date) as extract_year, count(*) as count
from movies
group by extract_year
order by count
limit 1;

/*21. Na podstawie tabeli movies przygotuj zestawienie, pokazujące średni budżet filmu z podziałem na lata wydania. 
Średni budżet wyświetl w zaokrągleniu do pełnych tysięcy. Wyniki posortuj według lat wydania. 

 year |  round 
------+--------- 
 1950 | 2387000 
 1951 | 1919000 
 1952 | 1571000 
 1953 | 1467000 
 1954 | 3970000 
 1955 | 1553000 */

select extract(year from release_date) as year, round(avg(budget), -3) as round
from movies
group by year
order by year;

/*22. Na podstawie tabel movies i languages przygotuj zestawienie przedstawiające liczby filmów wydanych w różnych 
językach. Uwzględnij tylko języki, dla których znaleziono ponad 5 filmów. Wyniki posortuj malejąco według liczby 
filmów. 

  name   | count 
---------+------- 
 English |   942 
 Espanol |    22 
 Deutsch |    16 
 svenska |    10 
 suomi   |     7 */

select l.name, count(*) as count
from languages l
join movies m on m.original_language = l.id
group by l.name
having count(*) > 5
order by count desc;
 
 /*23. Na podstawie tabel movies, actors i persons wyświetl aktorów, którzy zagrali dokładnie w 15 filmach. 

       name 
------------------- 
 Keenan Wynn 
 William Schallert 
 Frank Lovejoy 
 James Stewart 
 Barry Sullivan 
 Philip Carey 
 Humphrey Bogart 
 Harry Morgan */

select p.name
from persons p
join actors a on p.id = a.person_id
join movies m on a.movie_id = m.id
group by p.name
having count(m.id) = 15;
 
/*24. Na podstawie tabel movies i actors przygotuj zestawienie trzech filmów, w których zagrało najwięcej aktorów. 

         title         | count 
-----------------------+------- 
 The War of the Worlds |    95 
 Quo Vadis             |    76 
 East of Eden          |    63 */

select m.title, count(a.person_id) as count
from movies m
join actors a on m.id = a.movie_id
group by m.title
order by count desc
limit 3;

/*25. Na podstawie tabeli movies znajdź filmy, których czas trwania był dłuższy, niż najdłuższy czas trwania spośród 
wszystkich filmów wydanych w roku 1950.  


                   title                   | release_date | runtime 
-------------------------------------------+--------------+--------- 
 Captain Video, Master of the Stratosphere | 1951-12-27   |     287 */
 
select title, release_date, runtime
from movies
where runtime > 
		(select max(runtime) 
		 from movies 
		 where extract(year from release_date) = 1950);

 
/*26. Na podstawie tabeli movies, wykorzystując podzapytanie skorelowane do tabeli actors, umieszczone w klauzuli 
select, przygotuj zestawienie filmów rozpoczynających się od litery U, które dla każdego filmu przedstawia jego 
tytuł i liczbę aktorów. Wyniki posortuj według tytułów. 
        title         | count 
----------------------+------- 
 Ulisse               |    10 
 Un Giorno in pretura |    15 
 Unchained            |     9 
 Under the Gun        |    10 
 Underwater!          |    11 
 Union Station        |    18 */
 
select m.title, 
       (select count(*)
        from actors a
        where a.movie_id = m.id) as count
from movies m
where m.title like 'U%'  -- Filmy rozpoczynające się od litery 'U'
order by m.title;
 
 
/*27. Utwórz tabelę books o następującej strukturze:  
▪ id - liczba całkowita 
▪ title – łańcuch znakowy, maksymalnie 30 znaków (zmienna długość) 
▪ author – łańcuch znakowy, maksymalnie 30 znaków (zmienna długość) 
▪ published_year – liczba całkowita */

create table books (
    id int,
    title varchar(30),
    author varchar(30),
    published_year int);


/*28. Wstaw następujące dwa rekordy do tabeli books. 

         id |    title    |       author       | published_year 
------------+-------------+--------------------+---------------- 
          1 | Pan Tadeusz | Adam Mickiewicz    |           1934 
          2 | Krzyzacy    | Henryk Sienkiewicz |           1900 */


insert into books (id, title, author, published_year)
values 
    (1, 'Pan Tadeusz', 'Adam Mickiewicz', 1934),
    (2, 'Krzyżacy', 'Henryk Sienkiewicz', 1900);

select * from books;

/*29. Rozszerz tabelę books o nową kolumnę numeryczną (liczba rzeczywista) o nazwie price. We wszystkich 
rekordach wypełnij kolumnę price wartością 50. 

         id |    title    |       author       | published_year | price 
------------+-------------+--------------------+----------------+------- 
          1 | Pan Tadeusz | Adam Mickiewicz    |           1934 |    50 
          2 | Krzyzacy    | Henryk Sienkiewicz |           1900 |    50 */


-- 1. Dodanie nowej kolumny 'price' do tabeli 'books'
alter table books
add column price decimal(10, 2);

-- 2. Ustawienie wartości 50 w kolumnie 'price' dla wszystkich rekordów
update books
set price = 50;

select * from books;

/*30. Z tabeli books usuń rekord o id=2. 

         id |    title    |       author       | published_year | price 
------------+-------------+--------------------+----------------+------- 
          1 | Pan Tadeusz | Adam Mickiewicz    |           1934 |    50 */

delete from books
where id = 2;

/*31. Usuń tabelę books. */

drop table books;

/*32. Utwórz tabelę employees o następującej strukturze: 
▪ pesel - łańcuch znakowy 11-znakowy (stała długość) 
▪ first_name - łańcuch znakowy 15-znakowy (zmienna długość) 
▪ last_name - łańcuch znakowy 15-znakowy (zmienna długość) 
▪ birth_date - data 

Ponadto, podczas tworzenia nowej tabeli zdefiniuj następujące ograniczenia integralnościowe: 
▪ pesel musi liczyć dokładnie 11 znaków 
▪ pierwsze dwie cyfry numeru pesel muszą być takie same, jak ostatnie dwie cyfry roku w kolumnie 
birth_date 
▪ kolejne dwie cyfry numeru pesel muszą być takie same, jak numer miesiąca w kolumnie birth_date, gdy 
birth_date < '2000-01-01', lub jak numer miesiąca + 20, gdy birth_date >= '2000-01-01' 
▪ kolejne dwie cyfry numeru pesel muszą być takie same, jak numer dnia w kolumnie birth_date 
▪ kolumna pesel jest kluczem głównym tabeli 
▪ kolumny first_name i last_name muszą być wypełnione (niepuste) */

create table employees_pl (
    pesel char(11) primary key,
    first_name varchar(15) not null,
    last_name varchar(15) not null,
    birth_date date,
    check (length(pesel) = 11),
    check (substring(pesel from 1 for 2) = substring(to_char(birth_date, 'yyyy'), 3, 2)),
    check (substring(pesel from 3 for 2)::int = 
           case 
               when birth_date < '2000-01-01' then to_char(birth_date, 'MM')::int
               else (to_char(birth_date, 'MM')::int + 20)
           end),
    check (substring(pesel from 5 for 2) = to_char(birth_date, 'DD'))
);

select * from employees_pl;

/*33. Do tabeli employees wstaw następujące rekordy. Czy operacje się powiodły? Dlaczego? 
▪ '39090100001','Jan','Kowalski','1939-09-01' 
▪ '750218','Anna','Nowak','1975-02-18' 
▪ '75021800123','Anna','Nowak','1975-02-20' 
▪ '75021800123','Anna','Nowak','1975-02-18' 
▪ '05260100321','Adam','Zielinski','2005-06-01' 
▪ '05260100321','Ewa','Gorna','2005-06-01' */

insert into employees_pl (pesel, first_name, last_name, birth_date)
values
('39090100001', 'Jan', 'Kowalski', '1939-09-01'),
('75021800123', 'Anna', 'Nowak', '1975-02-20'),
('05260100321', 'Adam', 'Zielinski', '2005-06-01');
 

/*34. Usuń tabelę employees. */

drop table employees_pl;
 
/*35. Na podstawie tabeli persons utwórz widok persons_data, prezentujący w oddzielnych kolumnach imię 
(first_name) i nazwisko (last_name) każdego aktora. Przyjmij, że granicą pomiędzy imieniem a nazwiskiem jest 
pierwsza spacja występująca w kolumnie name tabeli persons. Następnie skorzystaj z widoku persons_data, aby 
przygotować zestawienie pokazujące 5 najpopularniejszych imion. 
select * from persons_data; 
 
first_name | last_name 
------------+----------- 
 Walter     | Matthau 
 Barry      | Norton 
 Dewey      | Robinson 
 Dan        | Seymour 
 Lester     | Sharpe 
... 
 
 
 first_name | count 
------------+------- 
 John       |   165 
 Robert     |   109 
 George     |    79 
 Richard    |    79 
 William    |    77 */

create view persons_data as
select 
split_part(name, ' ', 1) as first_name,  -- imię to pierwsza część przed spacją
split_part(name, ' ', 2) as last_name    -- nazwisko to część po pierwszej spacji
from persons;

select first_name, count(*) as count
from persons_data
group by first_name
order by count desc
limit 5;

/*36. Wykonaj poniższe polecenia SQL aby utworzyć testową tabelę customers zawierającą trzy miliony losowych 
rekordów. 

create table customers as 
select gs as id, 
      (select initcap(array_to_string(array( 
 select chr((65 + round(random() * 25)) :: integer) 
             from generate_series(1, 5) where gs=gs 
 ),''))) as first_name, 
      (select initcap(array_to_string(array( 
 select chr((65 + round(random() * 25)) :: integer) 
             from generate_series(1,gs % 10 + 5) 
     ),''))) as last_name, 
      (select initcap(array_to_string(array( 
              select chr((48 + round(random() * 9)) :: integer)  
              from generate_series(1,5) where gs=gs), ''))):: integer as zip_code 
from generate_series(1,2999999) gs; 
 
insert into customers values (3000000, 'Aaaaa', 'Zzzzz', '12345'); 
 
Dokonaj pomiaru czasów wykonania poniższych zapytań do tabeli customers.  
select * from customers where first_name='Aaaaa'; 
select * from customers order by first_name limit 5; 
select count(*) from customers where first_name<'B'; 

W celu poprawy wydajności powyższych zapytań, utwórz odpowiedni indeks B-drzewo. Następnie, dokonaj 
ponownego pomiaru czasu zapytań i upewnij się, czy nastąpiła poprawa wydajności. 
select * from customers where first_name='Aaaaa'; 
... 
Time: 0,614 ms 
 
select * from customers order by first_name limit 5; 
... 
Time: 0,558 ms 
 
select count(*) from customers where first_name<'B'; 
... 
Time: 45,265 ms 
 
Dokonaj pomiaru czasu modyfikacji rekordów tabeli customers przez poniższe polecenie. 
update customers set first_name = upper(first_name) where first_name like 'A%'; 
Time: 8173,108 ms 
 
Usuń utworzony wcześniej indeks i ponownie dokonaj pomiaru czasu modyfikacji tych samych rekordów. 
update customers set first_name = initcap(first_name) where first_name like 'A%'; 
Time: 2296,418 ms */

/* tworzenie tabeli*/
create table customers_pl as 
select gs as id, 
      (select initcap(array_to_string(array( 
 select chr((65 + round(random() * 25)) :: integer) 
             from generate_series(1, 5) where gs=gs 
 ),''))) as first_name, 
      (select initcap(array_to_string(array( 
 select chr((65 + round(random() * 25)) :: integer) 
             from generate_series(1,gs % 10 + 5) 
     ),''))) as last_name, 
      (select initcap(array_to_string(array( 
              select chr((48 + round(random() * 9)) :: integer)  
              from generate_series(1,5) where gs=gs), ''))):: integer as zip_code 
from generate_series(1,2999999) gs;

/* wstawienie rekordu*/
insert into customers_pl values (3000000, 'Aaaaa', 'Zzzzz', '12345');

select * from customers_pl;

/* pomiar czasu zapytan*/

-- Zapytanie 1: Wyszukiwanie rekordów o first_name='Aaaaa'
select * from customers_pl where first_name='Aaaaa';

-- Zapytanie 2: Wyszukiwanie 5 pierwszych rekordów po sortowaniu
select * from customers_pl order by first_name limit 5;

-- Zapytanie 3: Liczba rekordów, gdzie first_name < 'B'
select count(*) from customers_pl where first_name<'B';

/* tworzenie indeksu na kolumnie first_name*/
create index idx_first_name on customers_pl (first_name);

/* ponowny pomiar czasu zapytania po utworzeniu indexu jak wyzej*/

select * from customers_pl where first_name = 'Aaaaa';

select * from customers_pl order by first_name limit 5;

select count(*) from customers_pl where first_name < 'B';

/*aktuaalizacja first name na upper*/
update customers_pl set first_name = upper(first_name) where first_name like 'A%';

/*usuniecie indexu i aktualizacja*/
drop index if exists idx_first_name;

/* aktualizacja first name*/
update customers_pl set first_name = initcap(first_name) where first_name like 'A%';



