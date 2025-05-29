import taipy as tp
from taipy.components import Sidebar, Menu, MenuItem

# 创建公共菜单组件
def create_menu():
    menu = Menu(
        items=[
            MenuItem("主页", icon="home", href="/home"),
            MenuItem("数据分析", icon="chart-line", href="/analysis"),
            MenuItem("设置", icon="gear", href="/settings"),
            MenuItem("帮助", icon="question-circle", href="/help")
        ],
        style="dark",  # 可选样式：light/dark
        brand="我的应用"  # 顶部品牌标识
    )
    return Sidebar(menu, width=240)  # 菜单宽度

# 创建应用实例
app = tp.App(title="统一菜单演示")

# 注册公共菜单组件
app.register_component("menu", create_menu)

# 创建各个模块（所有模块共享相同菜单）
@app.page(path="/home")
def home_page(menu: Sidebar):
    return tp.Page(
        title="主页",
        sidebar=menu,
        content=tp.Html("欢迎来到主页")
    )

@app.page(path="/analysis")
def analysis_page(menu: Sidebar):
    return tp.Page(
        title="数据分析",
        sidebar=menu,
        content=tp.Html("这是数据分析模块")
    )

@app.page(path="/settings")
def settings_page(menu: Sidebar):
    return tp.Page(
        title="设置",
        sidebar=menu,
        content=tp.Html("系统设置界面")
    )

@app.page(path="/help")
def help_page(menu: Sidebar):
    return tp.Page(
        title="帮助",
        sidebar=menu,
        content=tp.Html("需要帮助吗？")
    )

if __name__ == "__main__":
     app.run(port=8090, debug=True)