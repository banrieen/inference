# 模型推理组件
特点： 支持反馈自学习和自动部署
版本： v0.1,
状态： 开发中,

* 需求分析-问题定位，
* 数据分析

RAG（文本<语音>，图像<视频 >）-LLM-Tools，（向量数据库，通用数据库）

基于 AutoGen 开发

空间特征分布分析模型
支持 onnx 格式模型

个人智能助手
构建基础的基础MLops对接 AI（视觉，大模型），通过 workflow 构建 Agent team ，支持MCP ,A2A 协议；
维护提示词模板，输出模型推理数据，收集用户反馈导入模型个体化优化


1. 用户交互    // autogen studio， 自定义客户端
2. Agent flow // Server autogen core ，sanic api call cloud LLM
3. 本地或云端MLops      // mlflow , 推理继续尝试 vllm, onnx
4. 数据存储    // postgres + minIO， 向量数据库，知识库
5. 数据处理-后分析 // wave，数据标注 label-studio
6. Open API   // sanic
7. 安装运维    // uv 

## 对接方式 一：
1. 打包为wheel, 然后安装并导入

`from ssa_classfy_onnx import ssa_infer # 须在 ssa_classfy_onnx 包外直接导入`

2. 下载源码后启用在线服务

### 主要文件 
```tree
.
├── conf.toml
├── _infer_results
├── LICENSE
├── README.md
├── requirements.ini
├── server.py
├── ssa_classify_onnx
│   ├── eval.py
│   ├── inference.py
│   ├── __init__.py
│   ├── LICENSE
│   ├── manifest.toml
│   ├── model_zc_v01.onnx
│   ├── read_image.py
│   ├── README.md
│   ├── requirements.ini
│   ├── tests
│   ├── train.py
│   └── __version__.py
├── start_backup.sh
└── __version__.py

```
### 启用方式：

* python 3.11 以上环境

```bash
# unzip -d SSA-classfication-model SSA-classfication-model.zip
cd SSA-classfication-model
pip -U install virtualenv 
cd daoist
python -m virtualenv Venv
source Venv/bin/active
pip install  -r requirements.ini
pip install opencv-python
# 注意 ubuntu 等linux环境遇到依赖包报错可单独安装onnxruntime, libgthread-2.0.so.0 或 libgthread-2_0-0 
deactivate
sudo chmod +x ./start_backup.sh
nohup ./start_backup.sh > local-output.log &
ps aux | grep sanic

``` 
## 预期输出：
``` text
outputs
array([[6.9873772e-06, 9.9771887e-01, 2.2491177e-03, 2.5035746e-05]], 
或 ================================>>> The image /home/XXXXX/workspace/ssa_classfy_onnx-master/tests/E609C2EC-659A-4caf-B583-9CF34A4BDC9F.png class is circle !
```
