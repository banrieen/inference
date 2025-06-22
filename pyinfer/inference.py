import onnxruntime as rt
import tomllib
import os
import numpy as np

## local libs
from ssa_classify_onnx.read_image import gimp

class ssa_infer:
    def __init__(self, manifest_file=""):
        # 初始化配置
        manifest_file = manifest_file if len(manifest_file) and "默认留空" not in manifest_file else r"ssa_classify_onnx/manifest.toml"
        self.conf = {}
        try:  
            manifest_file = os.path.abspath(manifest_file)
            with open(manifest_file, "rb") as f:
                self.conf = tomllib.load(f)
        except IOError as err:
            raise (f"{manifest_file} parser error !")
        self.conf = self.conf["model"]
        self.dst_path = self.conf["info"]["model_output"]
        self.labels = self.conf["info"]["dataset_labels"]



    def ssa_class_infer(self, image_path, output=False):
        # 加载图像
        prm = gimp()
        image, rgb_img = prm.image_preprocess(image_path, self.conf["infer"]) 
        # 加载模型
        gpuType = self.conf["info"]["gpu_type"]                 
        provider = 'GPUExecutionProvider' if 'GPU' in gpuType else 'CPUExecutionProvider'
        onnx_model_path = os.path.abspath(self.conf["info"]["model_name"]) 
        session = rt.InferenceSession(onnx_model_path, providers= [provider])
        input_name = session.get_inputs()[0].name
        outputs = session.run(None, {input_name: image})[0]
        output_name = self.labels[np.argmax(outputs, axis=1)[0]]
        # 输出到本地
        if output:
            prm.output(self.labels, rgb_img, image_path, self.conf["info"])
        return output_name, rgb_img

        

if __name__ == "__main__":
    manifest = os.path.abspath(r"ssa_classify_onnx/manifest.toml")
    # image_path = os.path.abspath(r"ssa_classify_onnx/tests/E609C2EC-659A-4caf-B583-9CF34A4BDC9F.png")
    image_path = "http://dms.ikasinfo.com/jh-adc/map/original/NA005230708E31.png" 
    new_classfy = ssa_infer()
    outputs = new_classfy.ssa_class_infer(image_path)
    print(f"================================>>> The image {image_path} class is {outputs[0]} !")