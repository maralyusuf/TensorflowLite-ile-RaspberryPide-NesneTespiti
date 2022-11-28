# TensorFlow-2-Lite-Ile-Raspberry-Pi-Uzerinde-Nesne-Tespiti
[![TensorFlow 2.2](https://img.shields.io/badge/TensorFlow-2.2-FF6F00?logo=tensorflow)](https://github.com/tensorflow/tensorflow/releases/tag/v2.2.0)
### Raspberry Pi de Nasıl Tensorflow Ile Nasıl Nesne Tespiti Yapacağımızı Öğrenelim.
<p align="center">
  <img src="doc/Screenshot 2020-11-14 144537.png">
</p>

## Giriş
Bu Eğitimimizde Raspberry Pi de Nasıl Nesne Tespiti Yapacağımızı Öğrenicez. 



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

**Not: Artık Terminalimizi Her Açtığımızda Bunu ortamı Etkinleştirmek için Şu komutu Kullanmalıyız ```source /home/pi/Desktop/tensorflow/bin/activate``` . Eğer bu Zahmetli geliyorsa Şöylede Bir şey Yapabiliriz, Terminelimizi Her açmaya çalıştığımızda root dizinimiz altındaki ~/.bashrc dosyası çalışır yani eğer Bu dosyanın en son satırına "source tensorflow/bin/activate" komutu eklersek Terminal Her Açıldığında Ortamımız Etkinleşir. Bunun İçin Bu Komutu  Çalıştırmanız Yeterlidir ```echo "source tensorflow/bin/activate" >> ~/.bashrc```. Çalışma Dizininizin Yanındaki Alanda Parantez İçinde tensorflow Yazıyorsa Sanal Ortamınız Aktiftir..**

 ```ls``` Komutunu ```tensorflow``` Klasöründeyke  Çalıştırdığınızda Aşşagıdaki Gibi Çıktı Almanız Gerek.
<p align="left">
  <img src="doc/directory.png">
</p>

## Addım 3: Gerekli Paket ve Kütüphanelerin Kurulması.
Bu adım Fazlasıyla Kolay Çünkü Kurulum Komutlarını bir Bash Betiği Halide Yazdım Sadece Aşşağıdaki Komutu Çalıştırarak Bütün gerekli Paket ve Kütüphanelrei Kurmuş Olucaksınız.
```
bash install-prerequisites.sh
```
Bir Kaç Dakika Sonra Aşşğıdaki Uyarıyı Görüceksiniz.
```
Prerequisites Installed Successfully
```
Şimdi tflite_runtime Kurulmuşmu Test Edelim. Önelikle Pyhton yazarak Pyhton3' müzü çalıştıralım.
```
python
```
Ardından Terminale Şu satırları Yazarak Test Edin
```
Python 3.7.3 (default, Jul 25 2020, 13:03:44)
[GCC 8.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import tflite_runtime as tf
>>> print(tf.__version__)
```
Eğer Doğru bir Kurulum Yaptıysanız Bu Yazıyı Görüceksiniz. 
```
2.5.0
```
**Note: tflite_runtime platform yapıları ve farklılıkları itibari ile hata Alabilrisiniz Bu Durumda Aşşaağıdaki Bağlantıyı Kullanrak Platformunuza Uygun olanı Kurabilirsiniz [buraya tıklayın](https://www.tensorflow.org/lite/guide/python)**

## Adım 4: Kameradan,videodan veya Resimde Nesne Tepiti Yapmak
Artık Raspberry Pi mizde Nesne Tespiti Yapmaya Hazırız! Bu Repoda , Bir TensorflowLite Modelinin Yanı sıra Videoda,kamerada ve Resimden Nesne Tespiti için 3 faarklı Pyhton dosyası Bulunmaktadır. 

- ```TFLite-PiCamera-od.py```: Bu program Nesne Tespiti Yapmak İçin Kameranızı Kullanır Opencv ye Hakimseniz Hangi Kamerdana Yapması Gerektiğini Koddan Seçebilirisiniz. Bu dosya Nesneleri Çerçeve İçine Alır Ayrıca Kaç Nesne OLduğunuda Size Söyler.
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
- ```TFLite-Image-od.py```: Bu Program ise Bir resim Üzerinde Nesne Tepiti ve Nesne Sayısını Gösterir.
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
- ```TFLite-Video-od.py```: Bu programda Diğereleri Gibi Çalışır Fakat Girdi Olarak Bir video Alır.
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
 
 Bu Komutu Kullanrak Kameranız Üzerinde Nesne Tespitnin Yapablirsiniz.
 ```
 python TFLite-PiCamera-od.py
 ```
 Eğer Kurulumları Doğru yapabildiyseniz Aşşğıdaki Gibi Nesneleriniz Tespit edilir.
 <p align="left">
  <img src="https://lh3.googleusercontent.com/_FxUvwC5Fri2vvtz187V-O6HSnyh7aUejHFDgNdiW-Ohzcd33S7fF2aAF9tdov52byluIEiL9LJYBdOTTYIk=w1548-h887-rw">
</p>

makele ingilizceden çevirilmiştir.
References : @armaanpriyadarshan
