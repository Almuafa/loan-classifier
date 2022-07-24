-- ## Accounts
SELECT * FROM financial.account;

/* number and kind of frequency 
"POPLATEK MESICNE" stands for monthly issuance
"POPLATEK TYDNE" stands for weekly issuance
"POPLATEK PO OBRATU" stands for issuance after transaction
*/

select distinct frequency from account;

-- "POPLATEK MESICNE" stands for monthly issuance the most camone account 4167
select frequency , count(frequency) num_account_frequency 
from account
group by frequency
order by 2 desc;

-- ## Cards

SELECT * FROM financial.card;

select distinct type from card;

-- what is the type of cards we have and how many eche type 
select  type , count(type) num_card_type 
from card
group by type
order by 2 desc;
/*
classic	659
junior	145
gold	88
*/
-- what is the most district issue cars and what is the lowest district issue cars and what is the district_id and district_name
select c.card_id  , 
d.district_id , 
d.A2 district_name ,
count(c.card_id) over (partition by d.district_id order by d.district_id) as num_of_card_everydistrict
from card c
join disp on c.disp_id = disp.disp_id
join account a on a.account_id = disp.account_id
join district d on a.district_id = d.district_id
order by 4 desc ;
-- the most district esue cards is 'Hl.m. Praha' by 132 cards and the lest district esue cards is 'Klatovy' by 2 cards

-- what is the top 10  district issue cars  what is the district_id and district_name 
select 
d.district_id , 
d.A2 district_name ,
count(c.card_id)  num_of_card_everydistrict
from card c
join disp on c.disp_id = disp.disp_id
join account a on a.account_id = disp.account_id
join district d on a.district_id = d.district_id
group by d.district_id , d.A2 
order by num_of_card_everydistrict desc 
limit 10;

-- what is the lest 10  district issue cars  what is the district_id and district_name 
select 
d.district_id , 
d.A2 district_name ,
count(c.card_id)  num_of_card_everydistrict
from card c
join disp on c.disp_id = disp.disp_id
join account a on a.account_id = disp.account_id
join district d on a.district_id = d.district_id
group by d.district_id , d.A2 
order by num_of_card_everydistrict  
limit 10;

-- ## Clients
SELECT * FROM financial.client;

select  gender ,  count(*) num_clint_gender 
from client
group by gender;
-- we have Male clinets more then Female clinets but is not big dif

-- what is client district
select c.client_id , d.district_id 
from client c 
join district d on c.district_id = d.district_id
join account a on a.district_id = d.district_id
group by c.client_id , d.district_id
order by c.client_id;

-- ## disposition
SELECT * FROM financial.disp;

select type , count(client_id) as num_types_client
from disp 
group by type;

-- 	only owner can issue permanent orders and ask for a loan

-- ## Districts 

SELECT * FROM financial.district;

-- how many regions
select distinct A3 as region from district;
 -- 8 regions

-- give the district_id with district_name
select district_id , A2 as Districg_name 
from district;
-- we have 77 districts

-- how many inhabitants in every districts
select district_id ,A2 as Districg_name , A4 as inhabitants
from district
order by inhabitants desc;

-- how many municipalities  in every districts
select district_id ,A2 as Districg_name , A4 as inhabitants ,
A5+A6+A7+A8 as num_of_municipalities
from district
order by num_of_municipalities desc;

-- how many cities  in every districts
select district_id ,A2 as Districg_name , A9 as cities 
from district
order by 3 desc;

-- what is the ratio of urban inhabitants in every districts
select district_id ,A2 as Districg_name , A10 as  'ratio of urban'
from district
order by 3 desc;

-- what is the  average salary inhabitants in every districts
select district_id ,A2 as Districg_name , A11 as  'average salary'
from district
order by 3 desc;

-- ## Loans 

SELECT * FROM financial.loan;

-- what art the difrent type of lone status 
select distinct status
from loan;
/*
status of paying off the loan
'A' stands for contract finished, no problems,
'B' stands for contract finished, loan not payed,
'C' stands for running contract, OK so far,
'D' stands for running contract, client in debt
*/

-- how many loans for every dif status
select status  , count(*) as num_of_loan
from loan
group by status;

-- what is the lona_id , amount and status group by status
select loan_id , amount , status
from loan
group by status , amount ,loan_id;

-- what is the longest  and the shortest duration for the loans 
select max(duration) as max_duration,min(duration) as min_duration	
from loan ;
-- the longestduration is 60 months  and the shortest duration is 12 months

-- give me all lonas contract finished, loan not payed I need the loan_id , account_id , and where he or she live
select l.loan_id , a.account_id , d.district_id , d.A2 as district_name 
from loan l 
join account a using(account_id)
join district d using (district_id)
where l.status = 'b';

-- give me every account have not get loan 
select a.*
from  loan l 
right join account a on l.account_id = a.account_id
where l.account_id is null;

-- give me all lonas contract not finshed, client in debt I need the loan_id , account_id , and where he or she live
select l.loan_id , a.account_id , d.district_id , d.A2 as district_name 
from loan l 
join account a using(account_id)
join district d using (district_id)
where l.status = 'd';

## Orders 

SELECT * FROM financial.order;

/*
characterization of the payment	
"POJISTNE" stands for insurrance payment
"SIPO" stands for household payment
"LEASING" stands for leasing
"UVER" stands for loan payment
*/
select k_symbol , count(*) as num_of_order_symbol
from financial.order
group by k_symbol
order by 2 desc;

-- give me all rows is not known K_symbol
select account_id
from financial.order
where k_symbol = '';

-- give me all banks we have orders to 
select distinct bank_to
from financial.order;


-- give all info for the max and min order amount 
with max_and_min_amount as 
(select max(amount) max_amount , min(amount) min_amount
from financial.order)
select o.*
from financial.order o , max_and_min_amount m
where amount in (max_amount,min_amount);

-- to see what is the missing value in k_symbol
select distinct  t.account_id , t.k_symbol , o.k_symbol ,o.amount
from trans t
right join financial.order o on t.account_id =o.account_id
where o.k_symbol = '' and o.amount = t.amount;

-- ## Transaction

SELECT * FROM financial.trans
limit 5;

-- see all where K_symbol or Bank or account is null
select *
from trans
where k_symbol is null or bank is null or account is null;

-- give me all type of trans and how many trans
select type , count(*) num_of_trans
from trans
group by type
order by 2 desc;
/*
"PRIJEM" stands for credit
"VYDAJ" stands for withdrawal
"VYBER" withdrawal in cash
*/

-- give me all type of operation of trans and how many trans
select operation , count(*) num_of_trans
from trans
group by operation
order by 2 desc;
/*
mode of transaction
"VYBER KARTOU" credit card withdrawal
"VKLAD" credit in cash
"PREVOD Z UCTU" collection from another bank
"VYBER" withdrawal in cash
"PREVOD NA UCET" remittance to another bank
*/

-- give me all characterization of the transaction of trans and how many trans
select k_symbol , count(*) num_of_trans
from trans
group by k_symbol
order by 2 desc;
/*
characterization of the transaction
"POJISTNE" stands for insurrance payment
"SLUZBY" stands for payment for statement
"UROK" stands for interest credited
"SANKC. UROK" sanction interest if negative balance
"SIPO" stands for household
"DUCHOD" stands for old-age pension
"UVER" stands for loan payment
*/

select account_id , count(trans_id) as no_of_tranz ,
	   min(balance) as min_balance , 
       case 
		   when min(balance) >= 0 then 'good' 
		   else 'bad'
       end as good_or_bad_account
from trans
where k_symbol = "UVER"
group by account_id
order by 3;


-- ##  All Info About Accounts And Loans 

select t4.*, l.loan_id , l.amount as lone_amount , l.duration as loan_duration , l.status as loan_status
from loan l 
right join (select t2.* , t3.NO_of_trans
			from    (select t1.* , dis.a4 as no_of_inhabitants , 
							 dis.a5 + dis.a6 + dis.a7 +dis.a8 as no_of_municipalities , 
							 dis.a9 as ratio_of_urban_inhabitants , dis.a10 as average_salary,
							 dis.a13 as unemploymant_rate , dis.a14 as no_of_enterpreneurs_per_1000_inhabitants,
							 dis.a16 as no_of_commited_crimes
					 from district as dis
					 join(select   a.account_id , a.date as account_data , a.district_id ,
								   a.frequency as acount_frequency , c.client_id ,
								   c.gender as clint_gender , c.birth_date as clint_DOB,
								   ca.type  as card_type, ca.issued as card_issued
						  from account a
						  join disp d using(account_id)
						  join client c using(client_id)
						  left join card ca using(disp_id)
						  where d.type = 'owner') as t1 
					 on t1.district_id = dis.district_id) as  t2
			left join  (select account_id ,count(trans_id) as NO_of_trans
						from trans
						group by account_id) t3
			on t2.account_id = t3.account_id) t4
on l.account_id = t4.account_id;