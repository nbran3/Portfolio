import streamlit as st
import pandas

st.set_page_config(layout="wide")

col1, col2 = st.columns(2)

with col1:
    st.image("images/img.png")

with col2:
    st.title("Noah Brannon")
    content = """
    Hi, My name is Noah Brannon. I graduated from the University of Michigan - Dearborn with a degree in 
    Economics in 2022. I am currently aspiring to be a Data Analyst using SQL and Python. This is my personal 
    portfolio website where you can see my personal Python projects while I learn.
    """
    st.info(content)

content2 = """
Below you can find some of the projects I have completed in Python. Feel free to contact me!
"""
st.write(content2)

col3, col0, co4 = st.columns([1.5,0.5,1.5])

df = pandas.read_csv('data.csv', sep=";")

with col3:
    for index, row in df[:10].iterrows():
        st.header(row['title'])
        st.write(row['description'])
        st.image('images/'+ row["image"])
        st.write(f"[Source Code]({row['url']})")

with co4:
    for index, row in df[10:].iterrows():
        st.header(row['title'])
        st.write(row['description'])
        st.image('images/' + row["image"])
        st.write(f"[Source Code]({row['url']})")
