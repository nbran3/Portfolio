--- Basic Transaction Analysis ---

--- How many unique invoices -- 541909
SELECT DISTINCT(COUNT(InvoiceNo)) as NumofUniqueInvoices
FROM `hellothere-377017.onlineretail.retail`

--- Total number of invoices by month - Pretty nromal distribution as the year goes on more invoices are submitted
SELECT COUNT(InvoiceNo) as CountofInvoices, EXTRACT(MONTH FROM InvoiceDate) as InvoiceDate
FROM `hellothere-377017.onlineretail.retail`
GROUP by InvoiceDate
ORDER by InvoiceDate

--- Distribution of invoices by country - United Kingdom has the most by far
SELECT COUNT(InvoiceNo) as CountofInvoices, Country
FROM `hellothere-377017.onlineretail.retail`
GROUP by Country
ORDER by CountofInvoices DESC

--- Customer Insights - 4732
--- How many unique customers 
SELECT COUNT(DISTINCT CustomerID)
FROM `hellothere-377017.onlineretail.retail`

--- Average Number of items purchase per customers - 123.95
SELECT COUNT(Quantity) / Count(DISTINCT CustomerID)
FROM `hellothere-377017.onlineretail.retail`


--- Average spending per customers - 571.55
SELECT SUM(UnitPrice) / Count(DISTINCT CustomerID)
FROM `hellothere-377017.onlineretail.retail`

--- Product Popularity
--- Top 10 most frequently purchased products?
SELECT COUNT(StockCode) as ProductCount, StockCode
FROM `hellothere-377017.onlineretail.retail`
GROUP BY StockCode
ORDER By ProductCount DESC
LIMIT 10

--- Top selling products by month
SELECT COUNT(StockCode) as ProductCount, EXTRACT(MONTH FROM InvoiceDate) as InvoiceDate
FROM `hellothere-377017.onlineretail.retail`
GROUP by InvoiceDate
ORDER by InvoiceDate
