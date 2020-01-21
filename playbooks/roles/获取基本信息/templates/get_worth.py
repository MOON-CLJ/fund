import re
import json

import requests

resp = requests.get(
    "http://fund.eastmoney.com/pingzhongdata/{{ code }}.js",
)
data = resp.text
vars = re.findall(r"var (.+?)=(.+?);+?", data)
results = {}
for i in vars:
    k, v = i
    k = k.strip()
    v = v.strip()
    if k == "swithSameType":
        results[k] = eval(v)
        continue
    results[k] = json.loads(v)
print(json.dumps(results))