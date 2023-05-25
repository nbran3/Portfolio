import requests
from semail import send_email

api_key = "notrealthisanexample"
url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=notrealthisanexample&" \
      "language=en"

request = requests.get(url)
content = request.json()
body = ""
for article in content["articles"][:30]:
    if article['description'] is not None:
        body = "Subject : Today's news" \
               + '\n' + body + article['title'] + '\n' \
               + article['description'] \
               + '\n' + article['url'] + 2 * "\n"

body = body.encode('utf-8')
send_email(message=body)
