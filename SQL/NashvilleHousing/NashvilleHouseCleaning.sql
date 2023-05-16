-- Standardizing date format
Select SaleDateConverted, CONVERT(Date,SaleDate) 
FROM Projects..Nashville$

UPDATE Projects..Nashville$
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE Projects..Nashville$
Add SaleDateConverted Date;
 
UPDATE Projects..Nashville$
SET SaleDateConverted = CONVERT(Date, SaleDate)

--- Populate Property Address data
Select *
FROM Projects..Nashville$
ORDER by ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Projects..Nashville$ a
JOIN Projects..Nashville$ b
on a.ParcelID = b.ParcelID 
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Projects..Nashville$ a
JOIN Projects..Nashville$ b
on a.ParcelID = b.ParcelID 
AND a.[UniqueID ] <> b.[UniqueID ]

--- Seperating Address into individual columns (Street Address, City, State)
 SELECT PropertyAddress
 FROM Projects..Nashville$

SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address 
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) as Address
FROM Projects..Nashville$

ALTER TABLE Projects..Nashville$ 
ADD PropertySplitAddress nvarchar(255)

UPDATE Projects..Nashville$
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 

ALTER TABLE Projects..Nashville$ 
ADD PropertySplitCity nvarchar(255)

UPDATE Projects..Nashville$
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))

SELECT *
FROM Projects..Nashville$


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From Projects..Nashville$

ALTER TABLE Projects..Nashville$ 
ADD OwnerSplitAddress nvarchar(255)

UPDATE Projects..Nashville$
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE Projects..Nashville$ 
ADD OwnerSplitCity nvarchar(255)

UPDATE Projects..Nashville$
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE Projects..Nashville$ 
ADD OwnerSplitState nvarchar(255)

UPDATE Projects..Nashville$
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

--- Changing Y and N to Yes and No in "Sold in Vacant" field
SELECT Distinct(SoldAsVacant), Count(SoldAsVacant)
FROM Projects..Nashville$
GROUP BY SoldAsVacant
Order BY 2

SELECT SoldAsVacant,
CASE When SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END as UpdatedSoldAsVacant
FROM Projects..Nashville$

UPDATE Projects..Nashville$
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END

--- Removing Duplicates
WITH RowNumCTE AS(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
ORDER by UniqueID  
) row_num
FROM Projects..Nashville$
)
DELETE 
FROM RowNumCTE
WHERE row_num > 1

--- Removing unused columns
SELECT *
FROM Projects..Nashville$

ALTER TABLE Projects..Nashville$
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE Projects..Nashville$
DROP COLUMN SaleDate
