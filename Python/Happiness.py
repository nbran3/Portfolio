import streamlit as st
import pandas as pd
import plotly.express as px

st.title('In search of Happiness')

option_x = st.selectbox('Select data for x-axis', ('GDP','Happiness','Generosity'))
option_y = st.selectbox('Select data  for y-axis', ('GDP','Happiness','Generosity'))

df = pd.read_csv('happy.csv')

match option_x:
    case 'Happiness':
        x_array = df['happiness']
    case 'GDP':
        x_array = df['gdp']
    case 'Generosity':
        x_array = df['generosity']

match option_y:
    case 'Happiness':
        y_array = df['happiness']
    case 'GDP':
        y_array = df['gdp']
    case 'Generosity':
        y_array = df['generosity']

st.subheader(f"{option_x} and {option_y}")
figure1 = px.scatter(x=x_array,y=y_array,labels={'x':option_x, 'y':option_y},trendline='ols')
st.plotly_chart(figure1)

