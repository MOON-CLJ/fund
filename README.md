# fund

## 输入

天天基金获取的数据

- 近一年收益率
- 近6月收益率
- 近三月收益率
- 近一月收益率
- 最新单位净值
- 最新同类排名
    
## 日常巡检

日常巡检主要股市比较平稳的情况下，把一些长期表现不好的股票卖出

```
ansible-playbook -i inventories/基金公司  playbooks/日常巡检即长期看跌-卖出.yml
```

### 有一些基金就是想抛掉

```
ansible-playbook -i inventories/伺机卖出但希望收益覆盖手续费  playbooks/完全不看好伺机-卖出.yml
ansible-playbook -i inventories/买入成本高等待回本  playbooks/完全不看好伺机-卖出.yml
```

## 其他策略

### 预期未来一段时间内大盘大跌

```
ansible-playbook -i inventories/基金公司  playbooks/预期大盘大跌-卖出.yml
```

### 在股市低谷的时候，买入一些之前积累的长期看涨的 

```
ansible-playbook -i inventories/长期看涨  playbooks/长期看涨-买入.yml
```

### 在股市昂扬向上的时候，短线操作买入和卖出

```
python gen_fund_list.py
ansible-playbook -i inventories/短线  playbooks/短期看涨-买入.yml
ansible-playbook -i inventories/短线持有  playbooks/短线收割-卖出.yml
日志较多，查看/tmp/ansible_run.log
```

### 评估目前持有的基金中，涨势喜人的部分，考虑加入长期看涨的列表以及持续评估

```
ansible-playbook -i inventories/基金公司  playbooks/涨势喜人-加入名单.yml
ansible-playbook -i inventories/长期看涨  playbooks/涨势喜人-评估.yml
```
