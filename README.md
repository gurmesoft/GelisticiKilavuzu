# Geliştirme Ortamının Oluşturulması

Proje geliştirirken kullanılan kütüphaneler, uygulamalar (PHP, MySQL, phpMyAdmin) gibi bütün geliştirme ortamlarında tutarlılık sağlayabilmek için docker containerlar üzerinde geliştirme yapıyoruz. Geliştirme ortamanın yaratılması için öncelikli olarak yapılması gereken bir kaç işlem ve sonrasında [Projeler](https://github.com/gurmesoft/projeler) reposundan çalışacağınız projenin containerini canlandırmanız gerekecektir.

Hadi başlayalım ve ihtiyacımız olan düzenlemeleri ve kurulumları yaparak başlayalım.


# 1. Docker Kurulumu
Docker sanallaştırma ve geliştirme ortamlarının yaratılması için gerekli olan uygulama https://www.docker.com/get-started/ adresinden edinip kuruyoruz. 

Windows için ek paket kurulumuna ihtiyaç duyabiliyor. Uyarıları takip ederek eklere kurabilirsiniz.

Kurulum sonrasında WSL 2 installtion is incomplete şeklide uyarı alırsanız.

https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi adresinden güncellemeyi yüklemeniz gerekebilir.

# 2. VSCode
Docker containerlarına VSCode içinden erişebilmek için Vscode'a bazı eklentileri kurmamız gerekiyor.

* Docker
* Docker Remote SSH
* Docker Remote Containers

# 3. Proje Containları

Projelerimizin geliştirme containerlarına https://github.com/gurmesoft/projeler reposunu kendi bilgisayarına çekmelisin 

## Projeyi Editörden Başlatmak

İlgili projeyi **VS Code da Open Folder in Container**  seçeneği ile açabilirsin. 

.devcontainer dizini altındaki devcontainer.json dosyasında editörümüzün hangi compose dosyasını kullanacağı çalışma dizini vs gibi ayarlar tutulmaktadır.

## Konsoldan Container Oluşturmak
Konsolda containeri çalıştırmak için ilgili projenin dizine gelip `docker-compose up -d` ile proje dizinindeki dosyayı tetikleyerek gerekli containleri oluşturabilirsin

# 2. SSL Sertifikasının Kuruluması

cert dizinindeki localhost.crt çift tıklama yolu ile gelen pencereden **Yerel Makine** sonraki ile devam edip. **Tüm sertifikaları aşağıdaki depolama alana yerleştir** seçeneği seçilip Gözat butonundan çıkan **Güvenilen Kök Sertifika Yetkilileri** seçip kök sertifika bilgisayarımıza yüklenir. Bu işlem https://localhost:port şeklindeki bağlantılarımızda aldığımız SSL hatasını gidermek için gereklidir.
<img width="402" alt="sertifika-secimi" src="https://user-images.githubusercontent.com/38686/169140569-05c12941-b9e3-4072-ba59-a8f45ab6fa21.png">



# 4. XDebug

XDebug PHP ile geliştirme yaparken hata ayıklamamızı kolaylaştıran bir araç oluşturduğumuz imagelerin PHP modüllerinde xdebug seçeneği aktiftir. XDebug kullanarak daha kolay hata ayıklayabilirsiniz.

# Örnek Proje

## VSCode, XDebug, Wordpress

Dizin yapısı
```
-.devcontainer
-- devcontainer.json // VSCode'un 
```

