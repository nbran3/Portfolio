import streamlit as st
import send_email as se

st.header("Contact Me")

with st.form(key='email_form'):
    user_email = st.text_input('Your email address: ')
    user_message = st.text_input('Your Message: ')
    message = f"""\n
Subject: New email from {user_email}
    
From: {user_email}
{user_message}
"""
    submit_button = st.form_submit_button('Submit')
    print(submit_button)
    if submit_button:
        se.email(message)
        st.info("Your email was sent successfully.")
