# Geliştirme Ortamının Oluşturulması

Proje geliştirirken kullanılan kütüphaneler, uygulamalar (PHP, MySQL, phpMyAdmin) gibi bütün geliştirme ortamlarında tutarlılık sağlayabilmek için docker containerlar üzerinde geliştirme yapıyoruz. Geliştirme ortamanın yaratılması için öncelikli olarak yapılması gereken bir kaç işlem ve sonrasında [Projeler](https://github.com/gurmesoft/projeler) reposundan çalışacağınız projenin containerini canlandırmanız gerekecektir. 

Projeler reposu bu reponun bir sub modülü olarak eklidir ayrıyetten projeler reposunu çekmenize gerek yok sadece bu repoyu çekmeniz ve güncel tutmanız yeterlidir.

Hadi başlayalım ve ihtiyacımız olan düzenlemeleri ve kurulumları yaparak başlayalım.


# 1. Docker Kurulumu
Docker sanallaştırma ve geliştirme ortamlarının yaratılması için gerekli olan uygulama https://www.docker.com/get-started/ adresinden edinip kuruyoruz. 

Windows için ek paket kurulumuna ihtiyaç duyabiliyor. Uyarıları takip ederek eklere kurabilirsiniz.

Kurulum sonrasında WSL 2 installtion is incomplete şeklide uyarı alırsanız.

https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi adresinden güncellemeyi yüklemeniz gerekebilir.

# 2. Hazırlık ve Bilinmesi Gerekenler
Yaptığımız projelerin türlerine ve işleyişlerine baktığımızda önümüze geliştirme ortamlarında engel çıkmaması için canlı ortama benzer bir düzen yaratmamız gerekiyor. Bunun için lokal gerçek olmayan bir alanadı ve SSL ile çalışmamız Cross Origin, CSRF gibi geliştirmede önümüze çıkan problemleri bertaraf etmemizi sağlayacak. Geliştirme ortamı ve canlı ortamın yapısını bir birine yaklaştırmış olacağız. Bu ortamı sağlamamız için üç temel şeye ihtiyacımız var.

## 2.1 hosts Dosyasının Düzenlenmesi

Projemizde çalışacak yerel domain hangi ip adresine karşılık geldiğini **C:\Windows\System32\drivers\etc** dizini altında **hosts** dosyasına

`127.0.0.1 iysapp.gurmeapps.local `

satırı şeklinde girmeliyiz. Yaptığımızın teyitini almak için komut satırında **ping iysapp.gurmeapps.local** komutu 127.0.0.1'e istek yapıyor olması gerekir

## 2.2 Yerel SSL Sertifikasyonunun Oluşturulması

Bütün projelerde ortak olarak kullanılan wildcard bir SSL sertifikamız cert dizini içinde mevcut fakat bu sertifikanın tarayıcımız tarafından tanımlanıp doğrulanabilmesi için. [mkcert](https://github.com/FiloSottile/mkcert) uygulamasını kurup `mkcert -install` komutu ile tarayıcımıza kök sertifikayı kurmamız gerekmektedir.

## 2.3 Nginx Proxy Manager

Bu repoyu çekip nginx-proxy-manager dizini altındaki docker containeri çalıştırılmalı. Burada dikkat edilmesi gereken husus bu container 81,80 ve 443 portunu dinleyip gelen istekleri projeler için çalıştıracağımız containerlara yönlendirecek. Bilgisayarınızda başka bu portu dinleyen uygulamalar olmadığından ya da çalışmadığından emin olun. XAMMP, LocalWP gibi. Dizin içindeki dosyalar projelerin yönlendirmelerini otomatik yapıyor olacaktır. Fakat ilgili projeyi **hosts** dosyasına eklediğinizden ve projenin containerin çalışır olduğundan emin olmalısınız.

`docker-compose up -d` 
ile Nginx Proxy Manager containeri çalıştırılabilir. Ayarları ye yapılandırmalara ulaşmak için http://localhost:81 adresini ziyaret edin
`Kullanıcı Adı: admin@gurmesoft.com Şifre: adminadmin `

Yeni projeler eklendikte dizin altındaki ayarlara ekleneceğinden bu repoyu çekip containeri `docker-compose up -d ` ile tekrar canlandırmalısınız

# 2. VSCode
Docker containerlarına VSCode içinden erişebilmek için Vscode'a bazı eklentileri kurmamız gerekiyor.

* Docker
* Docker Remote SSH
* Docker Remote Containers

# 3. Proje Containları

Projelerimizin geliştirme containerlarına https://github.com/gurmesoft/projeler reposunda bulunmakta girişte bahsettiğim gibi bu reponun submodulü olduğu için ayrı olarak çekmenize gerek yok

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

