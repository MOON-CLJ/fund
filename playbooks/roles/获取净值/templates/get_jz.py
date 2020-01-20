import requests

# last_page_num = {{ last_page_num }}

last_page_num = 1
result = {}
for i in range(1, last_page_num+1):
    resp = requests.get(
        f"http://fund.eastmoney.com/f10/F10DataApi.aspx?type=lsjz&code=161725&page={i}&per=50",
    )
    print(resp.text)
    lines = resp.text.split('\n')[1:-1]
    for i in lines:
        print(i)