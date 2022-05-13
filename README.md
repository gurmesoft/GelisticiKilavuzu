# devops
devops ve geliştirme ortamları yaratma işleri

# 1. Docker Kurulumu
Docker sanallaştırma ve geliştirme ortamlarının yaratılması için gerekli olan uygulamamızı https://www.docker.com/get-started/ adresinden edinip kuruyoruz. Windows için ek paket kurulumuna ihtiyaç duyabiliyor. Uyarıları takip ederek eklere kurabilirsiniz.

Kurulum sonrasında WSL 2 installtion is incomplete şeklide uyarı alırsanız.

https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi adresinden güncellemeyi yüklemeniz gerekebilir.

# 2. NGINX Proxy Manager

## Kullanım Amacı
Nginx bir web server uygulaması bir techstack de bilgisayarımızda çalıştıracağımız projeler için SSL ve yerel bilgisayarımızdak domainleri ilk geleceği durak olacak.

Daha detaylı anlatmak gerekirse https://kargo.gurmehub.dev => Nginx => localhost:8000 (laravel kargo dockeri) şeklinde çalışacak.

## Nasıl Kurulur

Komut satırında ilgili klasöre giriş yapıp docker-compose ile kurulumu yapabilirsiniz. 80 ve 443 nolu portu dinleyen bir uygulama varsa kapatmanız gerekiyor. Kurulum sonrasında bilgisayarınızdaki 80 nolu porta gelen istekleri artık nginx karşılamaya başlayacak. Kendi domainlerimizi eklemek ve ayar yapmak için http://127.0.0.1:81 nolu adresi kullanacağız.

[Nginx Proxy Manager](https://nginxproxymanager.com/)

```
cd nginx-proxy-manager
docker-compose up -d
```

## Bitiş
Container kurulumu bittiksen sonra yeni Arayüzde nginx-proxy-manager yeni containeri görüntülenebilir yada 
````
docker ps
````
 ile çalışan bütün containler listelenip görüntülenebilir.

## Yapılandırma

http://127.0.0.1:81 adresinden 

Öntanımlı kullanıcı ve şifresi

````
Email:    admin@example.com
Password: changeme
````



Yeni domain ekleme ve bunu ilgili dockerlara yönlendirmeyi bu panelden yapacağız.

## Docker Ağ Bağdaştırıcısı Bulmak
Docker kendi içinde oluşturduğu containerlara ulaşmak için ağ bağdaştırıcısında bizim için yeni bir ağ aygıtı oluşturuyor oluşturduğumuz containerlara yönlendirmeyi bu ip adresi ile yapacağız. Denetim Masası-> Ağ ve Paylaşım Merkezi kısmından bulabilirsiniz.



# 3. mkcert

Kendi bilgisayarımızda ssl sertifikası oluşturmamıza yardımcı olacak uygulama.

(https://github.com/FiloSottile/mkcert)

Kendi reposundan farklı platformları için kurabilmek için dökümanları mevcut dökümanları inceleyerek mkcert konsolda kullanılacak seviyeye getirebilirsiniz.

### Ipucu Choco yu Hızlı Kurma Yöntemi

```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

choco ile mkcerti kurarken windows komut satırını yönetici olarak açmanız gerekmektedir.

## Yeni SSL Sertifikası Oluşturma

Tek seferlik olarak kök sertifikaları kurulumu yapılır.
````
mkcert -install 
````
Her yeni proje için altaki kod satırı ile yeni sertifika oluşturulur

```
mkcert kargo.gurmehub.dev 
```

komutu ile bulunduğumuz dizine içine bir ssl sertifikası oluşturacak ornekler dizinide örnekleri bulabilirsiniz.