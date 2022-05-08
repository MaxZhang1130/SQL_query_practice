# Project 1 [Fintelics-2021/7/8]
-- Customers can choose different ways to pay their credit card bills, such as paper, online, mobile 
-- phones. Some types of payment are very costly for us, for example, paper and third-party 
-- payment. We recently launched mobile payment which is the most efficient and cost-saving 
-- payment for us. From customer behavior perspective, the first thing you want to do is to find out 
-- how much each payment method has grown from 2014-07 to 2015-07, and then provide any 
-- insight you have to help us make better decisions.

-- 1. Table pmt_dt_detail has payment details of each payment made by each customer every 
-- day

-- • payment_id: each payment transaction has a payment ID associated with
-- • customer_id: customer who made the payment; each customer can make multiple 
-- payments any time they want
-- • pmt_type_code: we use code to represent different methods of payments
-- • country_code: where do the customers come from? 1 means Canada – in this case, we 
-- only care about Canada Market
-- • pmt_date – the date when the payment happened
-- • pmt_amt: the dollar amount paid by the customers

-- 2. pmt_type_code mapping table:
-- pmt_type_code payment_type
-- 1,2,5,12,13 AutoPay
-- 18,20,28,25 Branch
-- 30,49,50 EOS
-- 200,222,205 IVR
-- 300,301,401 Paper
-- 726,756,765 Third Party
-- 980,990,991,999 Mobile phone pay
-- For example, if pmt_type_code = 1 or 2 or 5 or 12 or 13, then the payment type is Autopay

-- Write down your code:
-- Look at customer payment data from 2014 to 2015 in Canada, tell the stories based on 
-- what you have seen from the data, and provide suggestions to your manager 
-- 1. We only compare 2015 vs. 2014; 
-- 2. What is the key metric to evaluate the growth for each payment type? Do we care about 
-- the payment dollar amount

select * from pmt_dt_detail;

select count(distinct cusomer_id) as amount_order, sum(pmt_amt) as amount_total,
case when pmt_type_code in (1,2,5,12,13) then "AutoPay"
when pmt_type_code in (18,20,28,25) then "Branch"
when pmt_type_code in (30,49,50) then "EOS"
when pmt_type_code in (200,222,205) then "IVR"
when pmt_type_code in (300,301,401) then "Paper"
when pmt_type_code in (726,756,765) then "Third Party"
when pmt_type_code in (980,990,991,999) then "Mobile phone pay"
else "undifined payment" end as payment_type, substring(pmt_date, 1, 4) as Year
from pmt_dt_detail
group by payment_type
having Year in ("2015", "2014")
order by amount_order DESC;

#Recommendation
-- We observed that mobile phone transaction volume showed much stronger growth than other payment types. 
-- Considering the mobile payment’s cost is also lower, 
-- the bank should keep promoting the use of mobile payment. 
-- For example, the bank can provide $10 dollars credit if customers set up mobile auto pay.

#[The original data has some troubles, some of the data sets are missing]

