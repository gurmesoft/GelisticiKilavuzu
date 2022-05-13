# devops
devops ve geliştirme ortamları yaratma işleri

# 1. Docker Kurulumu
Docker sanallaştırma ve geliştirme ortamlarının yaratılması için gerekli olan uygulamamızı https://www.docker.com/get-started/ adresinden edinip kuruyoruz. Windows için ek paket kurulumuna ihtiyaç duyabiliyor. Uyarıları takip ederek eklere kurabilirsiniz.

Kurulum sonrasında WSL 2 installtion is incomplete şeklide uyarı alırsanız.

https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi adresinden güncellemeyi yüklemeniz gerekebilir.

## Containerlar için Network Oluşturuluması

Kullanacağımız containerları yerel makineden izole etmek için bridge bir network yaratıyoruz bu networku containerlarda kullanacağız.

```
docker network create -d bridge gurme-network

```

## İpucu: Docker Ağ Bağdaştırıcısı Bulmak
Docker kendi içinde oluşturduğu containerlara ulaşmak için ağ bağdaştırıcısında bizim için yeni bir ağ aygıtı oluşturuyor oluşturduğumuz containerlara yönlendirmeyi bu ip adresi ile yapacağız. Denetim Masası-> Ağ ve Paylaşım Merkezi kısmından bulabilirsiniz. Ekran görüntüsü eklenecek


# 2. İhtiyaç duyulan Temel Gereksinimler

Geliştirme yaptığımız ortamları kullanabilmek için bazı temel uygulama ve araçlara ihtiyacımız olacak. Nginx Proxy Manager, MariaDB, phpMyAdmin, mkcert gibi araçları kurulumu ile başlayıp ortamızı hazırlayacağız

# 2.1 NGINX Proxy Manager

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

## Bitiş

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

# 2.2 Mariadb Veritabanı Containerin Oluşturulması

Mariadb dizinin içinde compose dosyası ile şifresiz mariadb containirimizi oluşturuyor. Laravel, Wordpress,Presta vs gibi sistemlerde süreki bu containerdaki db yi kullanacağız.

[MariaDB containeri](https://hub.docker.com/_/mariadb)

```
cd mariadb
docker-compose up -d
```
Kurulumdan sonra ``` docker ps ``` komutunda container görüntülenebilmeli

# 2.3 mkcert

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
mkcert phpmyadmin.gurmehub.dev 
```

komutu ile bulunduğumuz dizine içine bir ssl sertifikası oluşturacak ornekler dizinide örnekleri bulabilirsiniz.

## Oluşturulan sertifikanın Reverse Proxy Tanıtılması

### Sertifikanın Yüklenmesi
http://127.0.0.1:81/nginx/certificates adresinden oluşturduğumuz serfitikayı custom olarak yüklüyoruz. 

Add SSL Certificate->Custom

Name: kullanılacak domain örnek phpmyadmin.gurmehub.dev
Key: mkcertin oluşturduğu -key li dosya
Cert: mkcertin oluşturduğu sertifika

### Yönlendirmenin Eklenmesi

http://127.0.0.1:81/nginx/proxy adresinden Add Proxy 

Name: phpmyadmin.gurmehub.dev

Çalıştırdığımız docker container portuna bakıp 127.0.0.1 ve port ile yönlendirme yapılmasını sağlamalıyız. 

Örnek:

Scheme:http
Hostname: 127.0.0.1
Port: 9080

SSL sekmesinden bir önceki aşamada eklediğimiz ssl sertifikasını seçiyor ve reverse proxy seçeneklerini bitiriyoruz

# 2.4 phpMyAdmin Kurulumu ve Kullanımı
Veritabanına bağlanıp işlemlerimizi yapmak için geliştirme ortamına phpymadmin.gurmehub.dev adresine uygulamayı yapılandırıyoruz

## Kurulum
```
cd phpmyadmin
docker-compose up -d
```

## hosts dosyası

c:\windows\system32\etc\drivers\hosts altındaki dosyayı açıp için

phpmyadmin.gurmehub.dev 127.0.0.1 satırını ekliyoruz