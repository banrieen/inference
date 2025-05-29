from taipy.gui import Markdown
# from api import get_file_list

# file_list = get_file_list()

files_md = Markdown("""
<|layout|columns=1|
<|part|
## 文件管理
<|{file_list}|table|page_size=10|rebuild|columns=文件名,类型,上传时间,大小|>
|>
|>
""")