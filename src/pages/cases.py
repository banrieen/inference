cases_md = Markdown("""
<|layout|columns=1|
<|part|
## 最佳实践案例库
<|{case_data}|table|page_size=5|group_by[category]=分类|columns=案例名称,分类,评分,操作步骤|>
|>
|>
""")