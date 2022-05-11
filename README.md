# devops
devops ve geliştirme ortamları yaratma işleri

# Docker Kurulumu
Docker sanallaştırma ve geliştirme ortamlarının yaratılması için gerekli olan uygulamamızı https://www.docker.com/get-started/ adresinden edinip kuruyoruz. Windows için ek paket kurulumuna ihtiyaç duyabiliyor. Uyarıları takip ederek eklere kurabilirsiniz.

# NGINX Proxy Manager

## Kullanım Amacı
Nginx bir web server uygulaması bir techstack de bilgisayarımızda çalıştıracağımız projeler için SSL ve yerel bilgisayarımızdak domainleri ilk geleceği durak olacak.

Daha detaylı anlatmak gerekirse https://kargo.gurmehub.dev => Nginx => localhost:8000 (laravel kargo dockeri) şeklinde çalışacak.

## Nasıl Kurulur

Komut satırında ilgili klasöre giriş yapıp docker-compose ile kurulumu yapabilirsiniz. 80 ve 443 nolu portu dinleyen bir uygulama varsa kapatmanız gerekiyor. Kurulum sonrasında bilgisayarınızdaki 80 nolu porta gelen istekleri artık nginx karşılamaya başlayacak. Kendi domainlerimizi eklemek ve ayar yapmak için http://localhost:81 nolu adresi kullanacağız.

(https://nginxproxymanager.com/)

```
cd nginx-proxy-manager
docker-compose up -d
```
## Yapılandırma