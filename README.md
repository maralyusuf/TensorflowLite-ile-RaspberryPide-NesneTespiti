# TensorFlow-2-Lite-Ile-Raspberry-Pi-Uzerinde-Nesne-Tespiti
[![TensorFlow 2.2](https://img.shields.io/badge/TensorFlow-2.2-FF6F00?logo=tensorflow)](https://github.com/tensorflow/tensorflow/releases/tag/v2.2.0)
### Raspberry Pi de Nasıl Tensorflow Ile Nasıl Nesne Tespiti Yapacağımızı Öğrenelim.
<p align="center">
  <img src="doc/Screenshot 2020-11-14 144537.png">
</p>

## Giriş
Bu Eğitim belgesinde Nasıl Raspberry Pi de Nesne Tespiti yapacağımızı Öğrenicez. 



## Neden Tensorflow Lite Kullanmalıyız ?
Normal Tensorflow'u Raspberry Pi ve Android Cihazlarda Kullanılmak İçin Uygun değil. İşte Bu noktada Tensorflow Lite Yardımımıza Koşuyor.Kurulumu Daha Kolay Bir hale Geldi. Yalnızca Bu da değil Aynı Zamanda Performans Bakımındanda Çok Daha İyi Sonuçlar Üretiyor. Raspberry Pi Ve Diğer Mobil Cihazlarda Çalışacak Şekilde Optimize Edilmiştir.

<p align="left">
  <img src="doc/tf vs tflite.png">
</p>

**Bir TensorFlow modelini yüklemek 3 dakikadan fazla ve TensorFlow Lite modelini yüklemek bir saniyeden kısa sürdü. TensorFlow Lite kelimenin tam anlamıyla% 5,693,400 daha hızlı yüklendi Bilmem Anlatabildim mi.**

## İçerik
1. [Raspberry Pi İçin Gerekli Ayarla ve Güncellemeler](https://github.com/maralyusuf/TesorflowLite-ile-RaspberryPide-NesneTespiti#step-1-setting-up-the-raspberry-pi-and-getting-updates)
2. [Pyhton Sanal Ortamımızı Oluşturma](https://github.com/maralyusuf/TesorflowLite-ile-RaspberryPide-NesneTespiti#step-2-organizing-our-workspace-and-virtual-environment)
3. [Gerekli Kütüphanelrin Yüklenmesi ](https://github.com/maralyusuf/TesorflowLite-ile-RaspberryPide-NesneTespiti#step-3-installing-the-prerequisites)
4. [Kameradan, Videodan Ve Görüntüden Nesne Tespiti Yapmak](https://github.com/maralyusuf/TesorflowLite-ile-RaspberryPide-NesneTespiti#step-4-running-object-detection-on-image-video-or-pi-camera)


## Adım 1: Raspberry Pi İçin Gerekli Ayarla ve Güncellemeler
Öncelikle Raspberry Pi'a erişiminizn olması gerekir Bunu VNC veya Putty ile yapabilirsiniz veya Windows Komut satırını Açıp  ``` ssh [YourPi-Username]@[Your-raspi-ip] ``` Bu Şekilde Raspberry Pi' nize Bağlanabilirsiniz.<br>
Örnek Kullanım : 
``` 
   ssh pi@10.0.0.248 
```


Raspberry Pi Bağlandıysanız Aşşağıdaki Komutları Kullanrak Sisteminizi Güncelleyin.

```
sudo apt-get update
sudo apt-get dist-upgrade
```

Bu İşlem İnternet Hızın Ve Siteminizi En Son Ne Zaman Güncellediğinize Göre Vakit Alabilir.Güncelleme İşleminiz Bittiyse Şimdi Raspberry Pi konfigrasyon Ayarlarımızda Raspbrerry Pi Kameramızı Etkinleştirelim Aşşağıdaki Adımları Takip Edin. Yada Raspberry İconu > Tercihler > Raspberry Pi Configration > Interfaces > Camera = Enabled <br>
Yada bu Bu adımları Takip Edin.

```
sudo raspi-config
```

Ardından İnterfaces tan >  kameraya girin ve Aktif Olduğundan Emin olun.Eğer isteniyorsa Finish e Bastıktan Sonra Yenden Başlatın.

<p align="left">
  <img src="doc/Camera Interface.png">
</p>

## Adım 2: Çalışma Alanımızı Ve  Python Sanal Ortamımızı Oluşturalım

Şimdi Bu github Repomuzu Klonlamak İçin Aşşağıdaki Komutu Kullanın

```
git clone https://github.com/maralyusuf/TensorflowLite-ile-RaspberryPide-NesneTespiti.git
```

Klasörümüzün İsmi Biraz Uzun O Yüzden Birazcık Kısalatalım ``` MV``` Komutumuz İle.Artık Klasörümüzün İsmi tensorflow

```
mv TensorflowLite-ile-RaspberryPide-NesneTespiti tensorflow
```

Raspberry Pi de Önceden Kurulmuş Paketlerler Sürüm Çakışmasını Önlemek İçin Sanal Ortamımızı
Oluşturalım. Bunu için öncelik virtualenv Paketimizi Kuralım.

```
sudo pip3 install virtualenv
```

Şimdi  ```tensorflow``` Adlı  Sanal Ortamımızı Oluşturabiliriz. 

```
python3 -m venv tensorflow
```

```tensorflow``` Kalsörümüzün İçinde ```bin``` Klasörümüz Oluştu. şimdi  ```tensorflow``` Klasörüne Geçelim.

```
cd tensorflow
```

Sanal Ortamımızı Aşağıdaki Komutu Kullanarak Etkinleştirelim.

```
source bin/activate
```

**Not: Artık Terminalimizi Her Açtığımızda Bunu ortamı ETKİNLEŞTİRMEK için Şu komutu Kullanmalıyız ```source /home/pi/Desktop/tensorflow/bin/activate``` . Eğer bu Zahmetli geliyorsa Şöylede Bir şey Yapabiliriz, Terminelimizi Her açmaya çalıştığımızda root dizinimiz altındaki ~/.bashrc dosyası çalışır yani eğer Bu dosyanın en son satırına "source tensorflow/bin/activate" komutu eklersek Terminal Her Açıldığında Ortamımız Etkinleşir. Bunun İçin Bu Komutu  Çalıştırmanız Yeterlidir ```echo "source tensorflow/bin/activate" >> ~/.bashrc```. Çalışma Dizininizin Yanındaki Alanda Parantez İçinde tensorflow Yazıyorsa Sanal Ortamınız Aktiftir..**

 ```ls``` Komutunu ```tensorflow``` Klasöründeyke  Çalıştırdığınızda Aşşagıdaki Gibi Çıktı Almanız Gerek.
<p align="left">
  <img src="doc/directory.png">
</p>

## Step 3: Installing the Prerequisites
This step should be relatively simple. I have compressed all the commands into one shellscript which you can run with
```
bash install-prerequisites.sh
```
This might take a few minutes, but after everything has been installed you should get this message
```
Prerequisites Installed Successfully
```
Now, it's best to test our installation of the tflite_runtime module. To do this first type
```
python
```
From the Python terminal, enter these lines
```
Python 3.7.3 (default, Jul 25 2020, 13:03:44)
[GCC 8.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import tflite_runtime as tf
>>> print(tf.__version__)
```
If everything went according to plan, you should get 
```
2.5.0
```
**Note: The link for downloading the tflite_runtime module is bound to change based on your Python version and platform/architecture. With time, newer versions will be also be released. I'll try my best to update this guide frequently, but the most recent instructions for the installation are located [here](https://www.tensorflow.org/lite/guide/python)**

## Step 4: Running Object Detection on Image, Video, or Pi Camera
Now we're finally ready to run object detection! In this repository, I've included a sample model that I converted as well as 3 object detection scripts utilizing OpenCV. If you want to convert a custom model or a pre-trained model, you can look at the [TensorFlow Lite Conversion Guide](https://github.com/armaanpriyadarshan/TensorFlow-2-Lite-Object-Detection-on-the-Raspberry-Pi/blob/main/TFLite-Conversion.md) that I wrote. A majority of the code is from [Edje Electronics' tutorial](https://github.com/EdjeElectronics/TensorFlow-Lite-Object-Detection-on-Android-and-Raspberry-Pi) with a few small adjustments. 
- ```TFLite-PiCamera-od.py```: This program uses the Pi Camera to perform object detection. It also counts and displays the number of objects detected in the frame. The usage is
```
usage: TFLite-PiCamera-od.py [-h] [--model MODEL] [--labels LABELS]
                             [--threshold THRESHOLD] [--resolution RESOLUTION]

optional arguments:
  -h, --help            show this help message and exit
  --model MODEL         Provide the path to the TFLite file, default is
                        models/model.tflite
  --labels LABELS       Provide the path to the Labels, default is
                        models/labels.txt
  --threshold THRESHOLD
                        Minimum confidence threshold for displaying detected
                        objects
  --resolution RESOLUTION
                        Desired webcam resolution in WxH. If the webcam does
                        not support the resolution entered, errors may occur.
```
- ```TFLite-Image-od.py```: This program takes a single image as input. I haven't managed to get it to run inference on a directory yet. If you do, feel free to share it as it might help others. This script also counts the number of detections. The usage is
```
usage: TFLite-Image-od.py [-h] [--model MODEL] [--labels LABELS]
                          [--image IMAGE] [--threshold THRESHOLD]
                          [--resolution RESOLUTION]

optional arguments:
  -h, --help            show this help message and exit
  --model MODEL         Provide the path to the TFLite file, default is
                        models/model.tflite
  --labels LABELS       Provide the path to the Labels, default is
                        models/labels.txt
  --image IMAGE         Name of the single image to perform detection on
  --threshold THRESHOLD
                        Minimum confidence threshold for displaying detected
                        objects
  --resolution RESOLUTION
                        Desired webcam resolution in WxH. If the webcam does
                        not support the resolution entered, errors may occur.
 ```
- ```TFLite-Video-od.py```: This program is similar to the last two however it takes a video as input. The usage is
```
usage: TFLite-Video-od.py [-h] [--model MODEL] [--labels LABELS]
                          [--video VIDEO] [--threshold THRESHOLD]
                          [--resolution RESOLUTION]

optional arguments:
  -h, --help            show this help message and exit
  --model MODEL         Provide the path to the TFLite file, default is
                        models/model.tflite
  --labels LABELS       Provide the path to the Labels, default is
                        models/labels.txt
  --video VIDEO         Name of the video to perform detection on
  --threshold THRESHOLD
                        Minimum confidence threshold for displaying detected
                        objects
  --resolution RESOLUTION
                        Desired webcam resolution in WxH. If the webcam does
                        not support the resolution entered, errors may occur.
 ```
 
 Now to finally test it out, run
 ```
 python TFLite-PiCamera-od.py
 ```
 If everything works you should get something like this
 <p align="left">
  <img src="doc/2020-11-15-230504_1920x1080_scrot.png">
</p>

Congratulations! This means we're successfully performing real-time object detection on the Raspberry Pi! Now that you've tried out the Pi Camera, why not one of the other scripts? Over the next weeks I'll continue to add on to this repo and tinker with the programs to make them better than ever! If you find something cool, feel free to share it, as others can also learn! And if you have any errors, just raise an issue and I'll be happy to take a look at it. Great work, and until next time, bye! 
