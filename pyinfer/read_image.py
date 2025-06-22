import os
import urllib.request
import numpy as np
import cv2
import pdb

class gimp:
    def __init__(self):
        pass

    def get_image(self, image_path):
        # 获取网络图像
        req = urllib.request.urlopen(image_path)
        arr = np.asarray(bytearray(req.read()), dtype=np.uint8)
        img = cv2.imdecode(arr, -1) 
        return img

    def image_preprocess(self, image_path, conf):
        # 图像参数预处理
        try:
            if "http" in image_path:
                rgb_img = self.get_image(image_path)
            elif os.path.isfile(image_path):
                rgb_img = cv2.imread(image_path)
            else:
                raise IOError(F"=======>>> {image_path} is Error File !")
            image = cv2.cvtColor(rgb_img, cv2.COLOR_BGR2RGB).astype("float32")
        except BaseException as err:
            raise IOError(f"{image_path} read fail !")
        target_length = conf["target_length"] 
        value = conf["value"] 
        method = conf["method"] 
        h, w, _ = image.shape
        ih, iw  = target_length, target_length              
        scale = min(iw/w, ih/h)                             
        nw, nh  = int(scale * w), int(scale * h)            
        image_resized = cv2.resize(image, (nw, nh))        
        image_paded = np.full(shape=[ih, iw, 3], fill_value=value)
        dw, dh = (iw - nw) // 2, (ih-nh) // 2
        image_paded[dh:nh+dh, dw:nw+dw, :] = image_resized 
        if method == 0:
            image_paded = image_paded / 255.               
        elif method == 1:
            image_paded = image_paded / 127.5 - 1.0    

        image = np.expand_dims(image_paded, axis=0).astype(np.float32)   
        return image, rgb_img

    def output(self, classes, rgb_img, image_path, conf):
        # 输出图像到本地
        dst_path =conf["model_output"] 
        labels = conf["dataset_labels"]
        try:
            os.makedirs(dst_path, exist_ok=True)
            for cls in labels:
                os.makedirs(os.path.join(self.dst_path, cls), exist_ok=True)
        except IOError as err:
            raise IOError(f"{dst_path} is not exist !")
        cv2.imwrite(os.path.join(dst_path, classes, image_path.split(os.sep)[-1]), rgb_img)

if __name__ == "__main__":
    image_path = "http://dms.ikasinfo.com/jh-adc/map/original/NA005230708E31.png"
    imr = gimp()
    imr.get_image(image_path)
