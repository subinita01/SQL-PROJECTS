-- MARKETING CAMPAIGN ANALYSIS --

Select *
From Customer;

Select *
From Item;

Select *
From CustomerTransactionData;

Select *
From CouponMapping;

Select *
From Campaign;

Select *
From CityData;

-- Different color segments (categories) provided by the company (Ans: 5)

Select Count (*), Item_Category
From Item
Group By Item_Category;

-- Different Coupon Types that are offered (Ans: 2)

Select Count (*), couponType
From CouponMapping
Group By couponType;

-- States where the company is currently delivering its products and services (Ans: 21)

Select Count (distinct State)
From CityData;

-- Different Order Types (Ans: 3)

Select Count (Distinct OrderType)
From CustomerTransactionData;

-- Total number of sales (transactions) happened by Yealy Basis (Ans: Max transactions for 2020 = 102 and Min transactions for 2023 = 6)

Select Extract (Year from PurchaseDate) as Purchase_Year, Count (*) as Transaction
From CustomerTransactionData
Group By Purchase_Year;

-- Total number of sales (transactions) happened by Quarterly Basis (Ans: Max transactions for quarter 4: 130, Min transactions for quarter 2: 31)

Select Extract (Quarter from PurchaseDate) as Purchase_Quarter, Count (*) as Transaction
From CustomerTransactionData
Group By Purchase_Quarter
Order By Transaction;

-- Total number of sales (transactions) happened by Year and Month Basis (Ans: Max transactions happen in last month of 2020: 48)

Select Date_Format (PurchaseDate, '%m-%Y') as Month_Year, Count (*) as Transaction
From CustomerTransactionData
Group By Month_Year
Order By Transaction;

-- Total purchase order by Product category (Ans: Max sales is for Oil paint and Min sales is for Synthetic paint)

(Select TotalSales_Item, Item_Category
From
        (Select Sum (c.PurchasingAmt) as TotalSales_Item, i.Item_Category
        From CustomerTransactionData as c
        Inner Join Item as i
        On c.item_id = i.item_id
        Group By (i.Item_Category)) as t1
Where TotalSales_Item = (Select Max (TotalSales_Item)
                         From (Select Sum (c.PurchasingAmt) as TotalSales_Item, i.Item_Category
                                From CustomerTransactionData as c
                                Inner Join Item as i
                                On c.item_id = i.item_id
                                Group By (i.Item_Category)) as t2))
union
(Select TotalSales_Item, Item_Category
From
        (Select Sum (c.PurchasingAmt) as TotalSales_Item, i.Item_Category
        From CustomerTransactionData as c
        Inner Join Item as i
        On c.item_id = i.item_id
        Group By (i.Item_Category)) as t1
Where TotalSales_Item = (Select Min (TotalSales_Item)
                         From (Select Sum (c.PurchasingAmt) as TotalSales_Item, i.Item_Category
                                From CustomerTransactionData as c
                                Inner Join Item as i
                                On c.item_id = i.item_id
                                Group By (i.Item_Category)) as t2));

-- Total purchase order by Yearly and Quarterly basis (Ans: Max sales is for last quarter of 2020)

(Select Extract (Year from PurchaseDate) as Yearly_Purchase, Extract (Quarter From PurchaseDate) as Quarterly_Purchase, Item_Category, Sum (PurchasingAmt) as Transaction
From CustomerTransactionData as c
Join Item as i
On c.item_id = i.item_id
Group By Item_Category, Yearly_Purchase, Quarterly_Purchase
Order By Transaction Desc
Limit 1);

-- Total purchase order by Order Type (Ans: Max sales is for Household order type)

Select OrderType, Sum (PurchasingAmt) as Transaction
From CustomerTransactionData
Group By OrderType
Order By Transaction Desc;

-- Total purchase order by City Tier (Ans: Max sales is for City tier 2)

Select CityTier, Sum (PurchasingAmt) as Transaction
From CustomerTransactionData as ctd
Join Customer as c
On ctd.Cust_Id = c.Customer_Id
Join CityData as cd
On c.City_Id = cd.City_Id
Group By CityTier
Order By Transaction desc;

-- UNDERSTANDING LEAD CONVERSION --

-- Total number of transactions with campaign coupon vs total number of transactions without campaign coupon (Ans: Number of transactions with coupons is 186 while without coupons is 114)

Select Count (*) as Number, Coupon_Or_NotCoupon
From
(Select Case When campaign_id is not null then 1
    Else 0 End as Coupon_Or_NotCoupon
From CustomerTransactionData) as t1
Group By Coupon_Or_NotCoupon;


SELECT 'Without Coupons' AS CampaignCoupons,
COUNT(*) AS TotalTransactions FROM CustomerTransactionData
WHERE campaign_id IS NULL
UNION ALL
SELECT 'With Coupons' AS CampaignCoupons,
COUNT(*) AS TotalTransactions FROM CustomerTransactionData
WHERE campaign_id IS NOT NULL;

-- Number of customers with first purchase done with or without campaign coupons (Ans: Number of customers having their first purchase with a coupon surpasses their counterpart)

Select Count (*), Coupon_Or_NotCoupon
From
(Select Case When coupon_id is not null then 1 else 0 end as Coupon_Or_NotCoupon
From
(Select Cust_Id, coupon_id
From
(Select Cust_Id, coupon_id, PurchaseDate, First_Value (PurchaseDate) Over (Partition By Cust_Id Order By PurchaseDate) as First_Purchase
From CustomerTransactionData) as T1
Where PurchaseDate = First_Purchase) as t2) as t3
Group By Coupon_Or_NotCoupon;

--  Impact of campaigns on users --

-- Total number of unique users making purchases with or without campaign coupons (Ans: Number of unique customers with a coupon surpasses their counterpart)

Select Count (Coupon_Or_NotCoupon) as Number, Coupon_Or_NotCoupon
FROM
(
        SELECT 
            CASE 
                WHEN coupon_id IS NOT NULL THEN 1 
                ELSE 0 
            END AS Coupon_Or_NotCoupon
        FROM
            (SELECT Cust_Id, coupon_id
            FROM CustomerTransactionData
            WHERE Cust_Id IN (
                SELECT Cust_Id
                FROM 
                    (SELECT Count(*) AS Number, Cust_Id
                    FROM CustomerTransactionData
                    GROUP BY Cust_Id
                    HAVING Count(*) = 1 ) AS t1) 
            ) AS t2
) as t3
Group By Coupon_Or_NotCoupon;

-- Purchase amount with campaign coupons vs normal coupons vs no coupons. Identify the order based on the amount (Ans: Campaign Coupons > No Coupons > Normal Coupons)

SELECT 'Normal Coupons' AS CampaignCoupons,
SUM(PurchasingAmt) AS TotalPurchase 
FROM CustomerTransactionData
WHERE campaign_id IS NULL AND coupon_id IS NOT NULL
UNION ALL
SELECT 'Campaign Coupons' AS CampaignCoupons,
SUM(PurchasingAmt) AS TotalPurchase 
FROM CustomerTransactionData
WHERE campaign_id IS NOT NULL
UNION ALL
SELECT 'No Coupons' AS CampaignCoupons,
SUM(PurchasingAmt) AS TotalPurchase 
FROM CustomerTransactionData
WHERE coupon_id IS NULL

-- Understanding company growth and decline --

-- Marketing team is interested in understanding the growth and decline pattern of the company in terms of new leads or sales amount by the customers

-- Total growth on an year by year basis based on Quantity of paint that's sold (Ans: Company made a steady growth in the past 2 years and saw a declining pattern in the current year)

Select Extract (Year from PurchaseDate) as Purchase_Year, Sum (quantity) as total_quantity
From CustomerTransactionData
Group by Purchase_Year
Order By Purchase_Year;

-- Total growth on an year by year basis based on Amount of paint that's sold (Ans: Company saw growth in the first 2 years and then a declining pattern since then)

Select Extract (Year from PurchaseDate) as Purchase_Year, Sum (PurchasingAmt) as total_amount
From CustomerTransactionData
Group by Purchase_Year
Order By Purchase_Year;

-- Customers that's acquired [New + Repeated] based on the count of customers (Ans: Customers in 2022 = 55, 2021 = 47, 2020 - 71, 2019 - 51)

Select Extract (Year from PurchaseDate) as Purchase_Year, OrderType, Count (Distinct Cust_Id) as total_Customer
From CustomerTransactionData
Group by Purchase_Year, OrderType
Order By Purchase_Year;

-- Identify the total decline, if any, within the total sales amount on an year by year basis. Comment on whether we need to launch a campaign for the consumers based on the recent pattern. What campaign type will be more appropriate for this scenario out of all the predefined distinct campaign types?
-- (Ans: Brand Awareness campaign can be launched and Seasonal campaign can be launched)

Select *, Transaction_Amt - Lag (Transaction_Amt) Over (Partition by campaignType order by Year_Wise) as profit_loss
from
(
    Select Extract (Year from PurchaseDate) as Year_Wise, campaignType, Sum (PurchasingAmt) as Transaction_Amt
    From CustomerTransactionData as ctd
    Left Join Campaign as c
    On ctd.campaign_id = c.campaign_id
    Where campaignType is not null
    Group by Year_Wise, campaignType
    Order by Year_Wise
) as t1;

-- MARKET BASKET ANALYSIS --

-- A market basket analysis is defined as a customer’s overall buying pattern of different sets of products. Essentially, the marketing team wants to understand customer purchasing patterns. Their proposal is if they promote the products in their next campaign, which are bought a couple of times together, then this will increase the revenue for the company

-- The dates when the same customer has purchased some product from the company outlets

SELECT C1.Cust_Id, C1.PurchaseDate AS PurchaseDate1, C2.PurchaseDate AS PurchaseDate 
FROM CustomerTransactionData AS C1 
INNER JOIN CustomerTransactionData AS C2 
ON C1.Cust_Id = C2.Cust_Id 
WHERE C1.Trans_Id != C2.Trans_Id AND C1.OrderType = C2.OrderType AND C1.item_id != C2.item_id
Order By C1.Cust_Id;

-- Out of the first query where you have captured a repeated set of customers, the same combination of products coming at least thrice sorted in descending order of their appearance

SELECT CONCAT_WS(",", C1.item_id, C2.item_id) AS Item_Combination,
COUNT(*) AS TotalTransaction
FROM CustomerTransactionData AS C1
INNER JOIN CustomerTransactionData AS C2
ON C1.Cust_Id = C2.Cust_Id
WHERE C1.Trans_Id != C2.Trans_Id 
AND C1.OrderType = C2.OrderType
AND C1.item_id != C2.item_id
GROUP BY CONCAT_WS(",", C1.item_id, C2.item_id)
HAVING COUNT(*) >= 3
ORDER BY COUNT(*) DESC;
