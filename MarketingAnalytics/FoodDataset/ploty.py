import dash
from dash import dcc, html
import plotly.express as px
import pandas as pd


app = dash.Dash(__name__)

df = pd.read_csv(r'C:\Users\nbwan\Python\Data Science\updatedfood.csv') 

total_sums = {
    'MntWines': df['MntWines'].sum(),
    'MntFruits': df['MntFruits'].sum(),
    'MntMeatProducts': df['MntMeatProducts'].sum(),
    'MntFishProducts': df['MntFishProducts'].sum(),
    'MntSweetProducts': df['MntSweetProducts'].sum(),
    'MntGoldProds': df['MntGoldProds'].sum()
}

df_totals = pd.DataFrame(list(total_sums.items()), columns=['Category', 'Total_Sum'])

shopping_treemap = px.treemap(df_totals, path=['Category'], values='Total_Sum',
                              title="Shopping Habits (Sum of Product Categories)",
                              color='Total_Sum',
                              color_continuous_scale='Reds')


age_hist = px.histogram(df, x='Year_Birth', title='Age Distribution', color_discrete_sequence=['#FF6666'])
income_bar = px.histogram(df, x="Income_Bin", title="Income Distribution",nbins=4, color_discrete_sequence=['#FF4D4D'])
marital_bar = px.bar(df, x="Marital_Status", title="Marital Status Count",color_discrete_sequence=['#FF4D4D'])
education_pie = px.pie(df, names="Education", title="Education Distribution",color_discrete_sequence=px.colors.sequential.Reds)

app.layout = html.Div([
    html.Div([
        dcc.Graph(figure=age_hist), 
        dcc.Graph(figure=income_bar)
    ], style={'display': 'flex'}),
    html.Div([
        dcc.Graph(figure=marital_bar), 
        dcc.Graph(figure=education_pie) 
    ], style={'display': 'flex'}),
        dcc.Graph(figure=shopping_treemap)
])

if __name__ == '__main__':
    app.run_server(debug=True)
