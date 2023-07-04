This project involves implementing a trading analysis strategy using Exponential Moving Averages (EMAs). The goal is to identify potential buy and sell signals based on the relationship between different EMAs and stock price movements. You can input any ticker in the input below, but for this project, I used Microsoft.

The project follows these main steps:

Calculating EMAs: Iterate through a predefined list of EMA values and calculate the EMAs for a specific dataset column using the ewm function from the pandas library. The calculated EMAs are stored in new columns in the DataFrame.

Signal Generation: Iterate through the DataFrame rows and compare the values of specific EMAs at each row. Based on the comparison results, generate buy or sell signals. If the short-term EMAs (e.g., 3, 5, 8, 10, 12, 15) cross above the long-term EMAs (e.g., 30, 35, 40, 45, 50, 60), it generates a "Red White Blue" signal for buying. Conversely, if the short-term EMAs cross below the long-term EMAs, it generates a "Blue White Red" signal for selling.

Tracking Trades and Calculating Returns: Track the trades and calculate the percentage change in returns for each trade. Record the positive and negative returns for further analysis.

Performance Metrics: Calculate various performance metrics for the trading strategy, including average gain, average loss, gain/loss ratio, batting average, maximum return, maximum loss, and total return over all trades.
