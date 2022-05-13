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

## Docker Ağ Bağdaştırıcısı Bulmak
Docker kendi içinde oluşturduğu containerlara ulaşmak için ağ bağdaştırıcısında bizim için yeni bir ağ aygıtı oluşturuyor oluşturduğumuz containerlara yönlendirmeyi bu ip adresi ile yapacağız. Denetim Masası-> Ağ ve Paylaşım Merkezi kısmından bulabilirsiniz.



# mkcert

Kendi bilgisayarımızda ssl sertifikası oluşturmamıza yardımcı olacak uygulama.

(https://github.com/FiloSottile/mkcert)

Kendi reposundan farklı platformları için kurabilmek için dökümanları mevcut dökümanları inceleyerek mkcert konsolda kullanılacak seviyeye getirebilirsiniz.

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