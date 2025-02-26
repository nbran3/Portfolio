import streamlit as st
import yfinance as yf
import pandas as pd
from sklearn.neighbors import KNeighborsRegressor
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import datetime as dt
from sklearn.metrics import mean_squared_error, r2_score

# Set the title of the Streamlit app
st.title('Stock Price Prediction using KNN')

# Set date range
start = dt.datetime(2014, 1, 1)
end = dt.datetime.now().date()


# Input for the stock ticker
stock_symbol = st.text_input('Enter the Stock Ticker (e.g., AAPL, TSLA):')

if stock_symbol:
    try:
        # Try fetching data using pandas_datareader
        stock =  yf.download(stock_symbol, start, end)
        
        if stock.empty:
            raise ValueError("No data retrieved")
        
    except Exception as e:
        st.warning(f"Error with pandas_datareader: {str(e)}. Trying yfinance directly...")
        
        try:
            # If pandas_datareader fails, try using yfinance directly
            ticker = yf.Ticker(stock_symbol)
            stock = ticker.history(start=start, end=end)
            
            if stock.empty:
                raise ValueError("No data retrieved")
            
        except Exception as e:
            st.error(f"Failed to retrieve data: {str(e)}. Please check the ticker symbol and try again.")
            st.stop()

    if not stock.empty:
        # Display stock closing price plot
        st.subheader(f"{stock_symbol} Stock Price")
        st.line_chart(stock['Close'])

        # Calculate moving averages and RSI
        stock['50_CloseMA'] = stock['Close'].rolling(window=50).mean()
        stock['200_CloseMA'] = stock['Close'].rolling(window=200).mean()
        stock['50_VolMA'] = stock['Volume'].rolling(window=50).mean()
        stock['200_VolMA'] = stock['Volume'].rolling(window=200).mean()

        # RSI calculation function
        def calculate_rsi(data, period=14):
            delta = data.diff()
            gain = (delta.where(delta > 0, 0)).rolling(window=period).mean()
            loss = (-delta.where(delta < 0, 0)).rolling(window=period).mean()
            rs = gain / loss
            return 100 - (100 / (1 + rs))
        
        # Add RSI to stock data
        stock['RSI'] = calculate_rsi(stock['Close'])

        # Clean and filter final data
        stock = stock.dropna()

        # Set up features (X) and target (y) for KNN
        features = ['Open', 'High', 'Low', 'Volume', '50_CloseMA', '200_CloseMA', '50_VolMA', '200_VolMA', 'RSI']
        X = stock[features].values
        y = stock['Close'].values
        
        # Split into training and testing sets
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

        # Scale the data (KNN works better with scaled data)
        scaler = StandardScaler()
        X_train_scaled = scaler.fit_transform(X_train)
        X_test_scaled = scaler.transform(X_test)
        
        # KNN model - number of neighbors as a parameter
        n_neighbors = st.slider('Select number of neighbors for KNN', 1, 20, value=5)
        knn = KNeighborsRegressor(n_neighbors=n_neighbors)
        
        # Train the KNN model
        knn.fit(X_train_scaled, y_train)
        
        # Make predictions
        predictions = knn.predict(X_test_scaled)
        
        # Display results
        st.subheader("KNN Model Predictions on Test Data:")
        results = pd.DataFrame({
            'Actual': y_test,
            'Predicted': predictions
        })
        st.dataframe(results.head())

        # Calculate and display metrics
        mse = mean_squared_error(y_test, predictions)
        r2 = r2_score(y_test, predictions)
        st.write(f"Mean Squared Error: {mse:.2f}")
        st.write(f"R-squared: {r2:.2f}")

        # Feature importance (based on correlation with target)
        st.subheader("Feature Importance:")
        corr = stock[features + ['Close']].corr()['Close'].abs().sort_values(ascending=False)
        st.bar_chart(corr[1:])  # Exclude 'Close' itself

        # Prediction for tomorrow
        last_data = stock[features].iloc[-1].values.reshape(1, -1)
        last_data_scaled = scaler.transform(last_data)
        tomorrow_pred = knn.predict(last_data_scaled)[0]
        st.subheader("Prediction for Tomorrow:")
        st.write(f"The predicted closing price for tomorrow is: ${tomorrow_pred:.2f}")

    else:
        st.error(f"No data found for the ticker {stock_symbol}. Please check the ticker symbol and try again.")
