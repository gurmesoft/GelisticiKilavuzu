# devops
devops ve geliştirme ortamları yaratma işleri

# Docker Kurulumu
Docker sanallaştırma ve geliştirme ortamlarının yaratılması için gerekli olan uygulamamızı https://www.docker.com/get-started/ adresinden edinip kuruyoruz. Windows için ek paket kurulumuna ihtiyaç duyabiliyor. Uyarıları takip ederek eklere kurabilirsiniz.

# NGINX Proxy Manager

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
## Yapılandırma

http://127.0.0.1:81 adresinden 

Öntanımlı kullanıcı ve şifresi

````
Email:    admin@example.com
Password: changeme
````

Yeni domain ekleme ve bunu ilgili dockerlara yönlendirmeyi bu panelden yapacağız.


# mkcert

Kendi bilgisayarımızda ssl sertifikası oluşturmamıza yardımcı olacak uygulama

(https://github.com/FiloSottile/mkcert)

## Yeni SSL Sertifikası Oluşturma

Tek seferlik olarak kök sertifikaları kurulumu yapılır.
````
mkcert -install 
````
Her yeni proje için altaki kod satırı ile yeni sertifika oluşturulur

```
mkcert magento.gurmehub.dev 
```