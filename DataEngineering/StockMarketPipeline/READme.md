There are multiple files in this project. 

PythontoSQL.ipynb is a local environment example with a Microsoft SQL Server using SQLAlchemy. 

DataUpload is an example where the data is uploaded into Google BigQuery through the pandas_GoogleBigQuery library (pandas_gbq). I authenticated through the Google Cloud SDK for reference, but you can also authenticate through a window sign-in on a browser signed in with a Google account if you try to run the script without authenticating (error message within IDE)

The data from yfinance is a bit weird, it basically creates a table within a table, so I had to create individual dataframes for each metric such as "Close" and then ingest them into their respective tables, so that is why there seems to be a lot of repeat code, also allows you to practice joins within the data.

The total data points within the data is approximately 956,000 for the Google Cloud example.
