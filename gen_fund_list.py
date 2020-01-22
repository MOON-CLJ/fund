import json

import requests

resp = requests.get(
    "http://fund.eastmoney.com/js/fundcode_search.js",
)
data = resp.text
data = data[len("var r = "): -1]
data = json.loads(data)
with open("inventories/短线", "w") as f:
    print("[基金]", file=f)
    for i in data:
        print(f'{i[0]} name="{i[2]}"', file=f)
