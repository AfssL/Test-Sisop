PRAK3


#
#
#               2
#
#


#Renoir

mkdir /etc/bind/jarkom
nano /etc/bind/named.conf.local

zone "lune33.com" {
    type master;
    file "/etc/bind/jarkom/db.lune33.com";
    allow-transfer { 10.59.3.20; }; 
    notify yes;
};

zone "sciel33.com" {
    type master;
    file "/etc/bind/jarkom/db.sciel33.com";
    allow-transfer { 10.59.3.20; }; 
    notify yes;
};

zone "gustave33.com" {
    type master;
    file "/etc/bind/jarkom/db.gustave33.com";
    allow-transfer { 10.59.3.20; }; 
    notify yes;
};




nano /etc/bind/jarkom/db.lune33.com

$TTL 604800
@   IN  SOA lune33.com. root.lune33.com. (
            2025102901  ; Serial
            604800      ; Refresh
            86400       ; Retry
            2419200     ; Expire
            604800 )    ; Negative Cache TTL
;
@   IN  NS  ns1.lune33.com.
@   IN  NS  ns2.lune33.com.

ns1 IN  A   10.59.3.10  ; IP Renoir
ns2 IN  A   10.59.3.20  ; IP Verso
@   IN  A   10.59.2.10  ; IP Lune



nano /etc/bind/jarkom/db.sciel33.com

$TTL 604800
@   IN  SOA sciel33.com. root.sciel33.com. (
            2025102901  ; Serial
            604800      ; Refresh
            86400       ; Retry
            2419200     ; Expire
            604800 )    ; Negative Cache TTL
;
@   IN  NS  ns1.sciel33.com.
@   IN  NS  ns2.sciel33.com.

ns1 IN  A   10.59.3.10  ; IP Renoir
ns2 IN  A   10.59.3.20  ; IP Verso
@   IN  A   10.59.2.20  ; IP Sciel



nano /etc/bind/jarkom/db.gustave33.com

$TTL 604800
@   IN  SOA gustave33.com. root.gustave33.com. (
            2025102901  ; Serial
            604800      ; Refresh
            86400       ; Retry
            2419200     ; Expire
            604800 )    ; Negative Cache TTL
;
@   IN  NS  ns1.gustave33.com.
@   IN  NS  ns2.gustave33.com.

ns1 IN  A   10.59.3.10  ; IP Renoir
ns2 IN  A   10.59.3.20  ; IP Verso
@   IN  A   10.59.2.30  ; IP Gustave

named-checkconf
named-checkzone lune33.com /etc/bind/jarkom/db.lune33.com
named-checkzone sciel33.com /etc/bind/jarkom/db.sciel33.com
named-checkzone gustave33.com /etc/bind/jarkom/db.gustave33.com
/etc/init.d/named status
/etc/init.d/named restart


#VERSO

chown bind:bind /etc/bind/jarkom
nano /etc/bind/named.conf.local

// Konfigurasi BIND untuk Verso (Slave)

zone "lune33.com" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.lune33.com";
};

zone "sciel33.com" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.sciel33.com";
};

zone "gustave33.com" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.gustave33.com";
};

named-checkconf

/etc/init.d/named status
/etc/init.d/named restart


# di semua client

nano /etc/resolv.conf

nameserver 10.59.3.10  # IP Renoir (Master DNS)
nameserver 10.59.3.20  # IP Verso (Slave DNS)

ping lune33.com
ping sciel33.com
ping gustave33.com



#
#
#               3
#
#

#Renoir

nano /etc/bind/jarkom/db.lune33.com
$TTL 604800
@   IN  SOA lune33.com. root.lune33.com. (
            2025102902  ;
            604800      
            86400       
            2419200     
            604800 )    
;
@   IN  NS  ns1.lune33.com.
@   IN  NS  ns2.lune33.com.

ns1 IN  A   10.59.3.10  
ns2 IN  A   10.59.3.20  
@   IN  A   10.59.2.10  

;
exp IN  CNAME   lune33.com.



nano /etc/bind/jarkom/db.sciel33.com

$TTL 604800
@   IN  SOA sciel33.com. root.sciel33.com. (
            2025102902  ;
            604800      
            86400       
            2419200     
            604800 )    
;
@   IN  NS  ns1.sciel33.com.
@   IN  NS  ns2.sciel33.com.

ns1 IN  A   10.59.3.10  
ns2 IN  A   10.59.3.20  
@   IN  A   10.59.2.20  

;
exp IN  CNAME   sciel33.com.


nano /etc/bind/named.conf.local

zone "lune33.com" {
    type master;
    file "/etc/bind/jarkom/db.lune33.com";
    allow-transfer { 10.59.3.20; }; 
    notify yes;
};

zone "sciel33.com" {
    type master;
    file "/etc/bind/jarkom/db.sciel33.com";
    allow-transfer { 10.59.3.20; }; 
    notify yes;
};

zone "gustave33.com" {
    type master;
    file "/etc/bind/jarkom/db.gustave33.com";
    allow-transfer { 10.59.3.20; }; 
    notify yes;
};

zone "2.194.192.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/db.2.194.192";
    allow-transfer { 10.59.3.20; };
    notify yes;
};


nano /etc/bind/jarkom/db.2.194.192

$TTL 604800
@   IN  SOA ns1.lune33.com. root.lune33.com. (
            2025102901  ; Serial
            604800      ; Refresh
            86400       ; Retry
            2419200     ; Expire
            604800 )    ; Negative Cache TTL
;
@   IN  NS  ns1.lune33.com.
@   IN  NS  ns2.lune33.com.

ns1 IN  A   10.59.3.10
ns2 IN  A   10.59.3.20

;
; IP 10.59.2.30 -> gustave33.com.
30  IN  PTR gustave33.com.

chown bind:bind /etc/bind/jarkom

named-checkconf
named-checkzone lune33.com /etc/bind/jarkom/db.lune33.com
named-checkzone sciel33.com /etc/bind/jarkom/db.sciel33.com
named-checkzone 2.194.192.in-addr.arpa /etc/bind/jarkom/db.2.194.192
/etc/init.d/named restart


#Verso


nano /etc/bind/named.conf.local

zone "lune33.com" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.lune33.com";
};

zone "sciel33.com" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.sciel33.com";
};

zone "gustave33.com" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.gustave33.com";
};

zone "2.194.192.in-addr.arpa" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.2.194.192";
};


named-checkconf
chown bind:bind /etc/bind/jarkom
/etc/init.d/named restart

#ke semua client
apt-get update
apt-get install dnsutils -y
ping exp.lune33.com
ping exp.sciel33.com
nslookup 10.59.2.30 10.59.3.10
nslookup 10.59.2.30 10.59.3.20



#
#
#               4
#
#


#Renoir

nano /etc/bind/named.conf.options

options {
    directory "/var/cache/bind";

    // dnssec-validation auto;
    allow-query { any; };

    listen-on-v6 { any; };
};

nano /etc/bind/jarkom/db.gustave33.com

$TTL 604800
@   IN  SOA gustave33.com. root.gustave33.com. (
            2025102902  ;
            604800      
            86400       
            2419200     
            604800 )    
;
@   IN  NS  ns1.gustave33.com.
@   IN  NS  ns2.gustave33.com.

ns1 IN  A   10.59.3.10  ; IP Renoir
ns2 IN  A   10.59.3.20  ; IP Verso
@   IN  A   10.59.2.30  ; IP Gustave

;
expedition  IN  NS  ns2.gustave33.com.

named-checkconf
named-checkzone gustave33.com /etc/bind/jarkom/db.gustave33.com
/etc/init.d/named restart


#Verso

nano /etc/bind/named.conf.options

options {
    directory "/var/cache/bind";

    // dnssec-validation auto;
    allow-query { any; };
};

nano /etc/bind/named.conf.local

zone "lune33.com" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.lune33.com";
};

zone "sciel33.com" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.sciel33.com";
};

zone "gustave33.com" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.gustave33.com";
};

zone "2.194.192.in-addr.arpa" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.2.194.192";
};

zone "expedition.gustave33.com" {
    type master;
    file "/etc/bind/jarkom/db.expedition.gustave33.com";
};

mkdir -p /etc/bind/jarkom
nano /etc/bind/jarkom/db.expedition.gustave33.com

$TTL 604800
@   IN  SOA ns2.gustave33.com. root.gustave33.com. (
            2025102901  ; Serial
            604800
            86400
            2419200
            604800 )
;
;
@   IN  NS  ns2.gustave33.com.

;
;
@   IN  A   10.59.2.30

named-checkconf
named-checkzone expedition.gustave33.com /etc/bind/jarkom/db.expedition.gustave33.com
/etc/init.d/named restart

#ke semua client
ping expedition.gustave33.com

#Renoir
/etc/init.d/named stop

#ke semua client lagi
ping lune33.com
# Harusnya TETAP BISA (dijawab Verso, 10.59.2.10)

ping exp.sciel33.com
# Harusnya TETAP BISA (dijawab Verso, 10.59.2.20)

ping gustave33.com
# Harusnya TETAP BISA (dijawab Verso, 10.59.2.30)

ping expedition.gustave33.com
# Harusnya TETAP BISA (dijawab Verso, 10.59.2.30)

#kalau udah
/etc/init.d/named start



#
#
#               5
#
#

#Lune

apt-get update
apt-get install nginx -y

mkdir -p /var/www/lune_profile


nano /var/www/lune_profile/profile_lune.html

<html>
<body>
<h1>Ini Profil LUNE</h1>
<p>Navigator dan spesialis komunikasi.</p>
</body>
</html>

nano /etc/nginx/sites-available/lune33

server {
    listen 80;

    root /var/www/lune_profile;

    index profile_lune.html;

    server_name lune33.com;

    location / {
        try_files $uri $uri/ =404;
    }

    error_log /tmp/error.log;
    access_log /tmp/access.log;
}

# Hapus symlink default
rm /etc/nginx/sites-enabled/default

# Buat symlink baru ke file config kita
ln -s /etc/nginx/sites-available/lune33 /etc/nginx/sites-enabled/

service nginx restart




#Sciel

apt-get update
apt-get install nginx -y

mkdir -p /var/www/sciel_profile
nano /var/www/sciel_profile/profile_sciel.html

<html>
<body>
<h1>Ini Profil SCIEL</h1>
<p>Ilmuwan dan peneliti utama.</p>
</body>
</html>

nano /etc/nginx/sites-available/sciel33

server {
    listen 80;
    root /var/www/sciel_profile;
    index profile_sciel.html;
    server_name sciel33.com;

    location / {
        try_files $uri $uri/ =404;
    }

    error_log /tmp/error.log;
    access_log /tmp/access.log;
}

rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/sciel33 /etc/nginx/sites-enabled/

service nginx restart

#Gustave

apt-get update
apt-get install nginx -y

mkdir -p /var/www/gustave_profile
nano /var/www/gustave_profile/profile_gustave.html

<html>
<body>
<h1>Ini Profil GUSTAVE</h1>
<p>Insinyur dan spesialis logistik.</p>
</body>
</html>

nano /etc/nginx/sites-available/gustave33

server {
    listen 80;
    root /var/www/gustave_profile;
    index profile_gustave.html;
    server_name gustave33.com;

    location / {
        try_files $uri $uri/ =404;
    }

    error_log /tmp/error.log;
    access_log /tmp/access.log;
}

rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/gustave33 /etc/nginx/sites-enabled/

service nginx restart

#Ke semua client

apt-get update
apt-get install lynx -y

lynx http://lune33.com
# Harusnya muncul "Ini Profil LUNE"

lynx http://sciel33.com
# Harusnya muncul "Ini Profil SCIEL"

lynx http://gustave33.com
# Harusnya muncul "Ini Profil GUSTAVE"

#server
cat /tmp/access.log




#
#
#               6
#
#

#Lune

nano /etc/nginx/conf.d/00-custom-log.conf
log_format jarkom_log '[$time_local] Jarkom Node Lune Access from $remote_addr using method "$request" returned status $status with $body_bytes_sent bytes sent in $request_time seconds';

nano /etc/nginx/sites-available/lune33
nano /etc/nginx/sites-available/sciel33
nano /etc/nginx/sites-available/gustave33

# ...
    # access_log /tmp/access.log;  <-- GANTI INI
    access_log /tmp/access.log jarkom_log; # <-- JADI INI
    # ...

    
service nginx restart


#Sciel

nano /etc/nginx/conf.d/00-custom-log.conf
log_format jarkom_log '[$time_local] Jarkom Node Sciel Access from $remote_addr using method "$request" returned status $status with $body_bytes_sent bytes sent in $request_time seconds';

nano /etc/nginx/sites-available/sciel33

access_log /tmp/access.log jarkom_log;

service nginx restart


#Gustave

nano /etc/nginx/conf.d/00-custom-log.conf
log_format jarkom_log '[$time_local] Jarkom Node Gustave Access from $remote_addr using method "$request" returned status $status with $body_bytes_sent bytes sent in $request_time seconds';

nano /etc/nginx/sites-available/gustave33

access_log /tmp/access.log jarkom_log;

service nginx restart


#semua client

lynx http://lune33.com
# (Pencet 'q' buat keluar)
lynx http://sciel33.com
# (Pencet 'q' buat keluar)
lynx http://gustave33.com
# (Pencet 'q' buat keluar)

#server
cat /tmp/access.log




#
#
#               7
#
#

#Gustave

nano /etc/nginx/sites-available/gustave33

#Ubah baris itu. Hapus listen 80; dan ganti jadi dua baris ini (sesuai soal):

server {
    listen 8080;
    listen 8888;
    root /var/www/gustave_profile;
    # ... (sisanya) ...



service nginx restart

lynx http://gustave33.com:8080
lynx http://gustave33.com:8888




#
#
#               8
#
#

#Di LUNE, SCIEL, dan GUSTAVE

mkdir -p /var/www/info
nano /var/www/info/info.html

<html>
<body>
<h1>Halaman Informasi Ekspedisi</h1>
<p>Ini adalah halaman informasi umum.</p>
</body>
</html>



#lune

nano /etc/nginx/sites-available/lune33

#Scroll ke paling bawah, di bawah } penutup dari server block yang pertama.
#Tambahin blok server BARU ini di bawahnya:

# --- Soal 8: Server Block Halaman Info ---
server {
    listen 8000;

    root /var/www/info;
    index info.html;

    location / {
        try_files $uri $uri/ =404;
    }
}

service nginx restart

#sciel

nano /etc/nginx/sites-available/sciel33

server {
    listen 8100;

    root /var/www/info;
    index info.html;

    location / {
        try_files $uri $uri/ =404;
    }
}

service nginx restart


#gustave

nano /etc/nginx/sites-available/gustave33

server {
    listen 8200;

    root /var/www/info;
    index info.html;

    location / {
        try_files $uri $uri/ =404;
    }
}

service nginx restart


#Klien

lynx http://lune33.com
# Harusnya nampil "Profil LUNE"

lynx http://lune33.com:8000
# Harusnya nampil "Halaman Informasi Ekspedisi"

lynx http://sciel33.com:8100
# Harusnya nampil "Halaman Informasi Ekspedisi"

lynx http://gustave33.com:8200
# Harusnya nampil "Halaman Informasi Ekspedisi"



#
#
#               9 dan 10
#
#


#Renoir

nano /etc/bind/named.conf.local

#Tambahin blok ini di paling bawah:

zone "expeditioners.com" {
    type master;
    file "/etc/bind/jarkom/db.expeditioners.com";
    allow-transfer { 10.59.3.20; };
    notify yes;
};



nano /etc/bind/jarkom/db.expeditioners.com

$TTL 604800
@   IN  SOA ns1.expeditioners.com. root.expeditioners.com. (
            2025103001  ; Serial
            604800      ; Refresh
            86400       ; Retry
            2419200     ; Expire
            604800 )    ; Negative Cache TTL
;
@   IN  NS  ns1.expeditioners.com.
@   IN  NS  ns2.expeditioners.com. 

;
ns1 IN  A   10.59.3.10  ; IP Renoir
ns2 IN  A   10.59.3.20  ; IP Verso
@   IN  A   10.59.4.10  ; IP ALICIA


named-checkconf
named-checkzone expeditioners.com /etc/bind/jarkom/db.expeditioners.com
/etc/init.d/named restart


#Verso

nano /etc/bind/named.conf.local

zone "expeditioners.com" {
    type slave;
    masters { 10.59.3.10; };
    file "/etc/bind/jarkom/db.expeditioners.com";
};

/etc/init.d/named restart


#Alicia


apt-get update
apt-get install nginx -y


nano /etc/nginx/conf.d/00-upstream-info.conf

# Soal 10: Grup server untuk load balancing Halaman Info
upstream info_servers {
    server 10.59.2.10:8000; # Lune Info
    server 10.59.2.20:8100; # Sciel Info
    server 10.59.2.30:8200; # Gustave Info
}


nano /etc/nginx/sites-available/expeditioners


server {
    listen 80;
    server_name expeditioners.com;
    
    location /profil_lune {
        proxy_pass http://10.59.2.10:80/;
        proxy_set_header Host $host;
    }

    location /profil_sciel {
        proxy_pass http://10.59.2.20:80/;
        proxy_set_header Host $host;
    }

    location /profil_gustave {
        proxy_pass http://10.59.2.30:8080/;
        proxy_set_header Host $host;
    }

    location / {
        proxy_pass http://info_servers/;
        proxy_set_header Host $host;
    }
}


# Hapus default (jika ada)
rm -f /etc/nginx/sites-enabled/default

# Aktifkan config baru
ln -s /etc/nginx/sites-available/expeditioners /etc/nginx/sites-enabled/


service nginx restart


#Lune

nano /etc/nginx/sites-available/lune33


server {
    listen 80;
    root /var/www/lune_profile;
    index profile_lune.html;
    server_name lune33.com;

    location / {
        try_files $uri $uri/ =404;
    }
    
    error_log /tmp/error.log; 
}

server {
    listen 8000;
    root /var/www/info;
    index info.html;

    location / {
        try_files $uri $uri/ /info.html =404;
    }
}



nano /etc/nginx/nginx.conf

user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 768;
    # multi_accept on;
}

http {

    ##
    # Basic Settings
    ##

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    # server_tokens off;

    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    ##
    # Logging Settings
    ##

    # --- SOAL 6 FIX: CUSTOM LOG FORMAT di http block ---
    # GANTI "Lune" dengan "Sciel" atau "Gustave" di server masing-masing
    log_format jarkom_log '[$time_local] Jarkom Node Lune Access from $remote_addr using method "$request" returned status $status with $body_bytes_sent bytes sent in $request_time seconds';
    
    # --- PERBAIKAN LOG BUFFER (Agar Round-Robin tercatat) ---
    # Log utama di level http, disimpan di /tmp/access.log (dipakai oleh semua server block)
    access_log /tmp/access.log jarkom_log buffer=1k flush=1s;
    error_log /var/log/nginx/error.log;

    ##
    # Gzip Settings
    ##

    gzip on;

    # gzip_vary on;
    # gzip_proxied any;
    # gzip_comp_level 6;
    # gzip_buffers 16 8k;
    # gzip_http_version 1.1;
    # gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    ##
    # Virtual Host Configs
    ##

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}


#Sciel

user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 768;
    # multi_accept on;
}

http {

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    # --- SOAL 6 FIX: CUSTOM LOG FORMAT untuk SCIEL ---
    log_format jarkom_log '[$time_local] Jarkom Node Sciel Access from $remote_addr using method "$request" returned status $status with $body_bytes_sent bytes sent in $request_time seconds';
    
    # --- SOAL 10 FIX: PERBAIKAN LOG BUFFER (Agar Round-Robin tercatat) ---
    access_log /tmp/access.log jarkom_log buffer=1k flush=1s;
    error_log /var/log/nginx/error.log;

    gzip on;

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}

nano /etc/nginx/sites-available/sciel33

# Server block 1: Profil (Port 80)
server {
    listen 80;
    root /var/www/sciel_profile;
    index profile_sciel.html;
    server_name sciel33.com;

    location / {
        try_files $uri $uri/ =404;
    }
    
    error_log /tmp/error.log; 
    # access_log dihilangkan
}

# Server block 2: Info (Port 8100)
server {
    listen 8100;
    root /var/www/info;
    index info.html;

    location / {
        # Fallback ke file info.html (Koreksi untuk 404 pada /apaaja)
        try_files $uri $uri/ /info.html =404;
    }
    # TIDAK ADA LOG DI SINI
}

rm /etc/nginx/conf.d/00-custom-log.conf


#Gustave

nano /etc/nginx/sites-available/gustave33

# Server block 1: Profil (Port 8080/8888 - Soal 7)
server {
    listen 8080;
    listen 8888;
    root /var/www/gustave_profile;
    index profile_gustave.html;
    server_name gustave33.com;

    location / {
        try_files $uri $uri/ =404;
    }
    
    error_log /tmp/error.log; 
    # access_log dihilangkan
}

# Server block 2: Info (Port 8200)
server {
    listen 8200;
    root /var/www/info;
    index info.html;

    location / {
        # Fallback ke file info.html (Koreksi untuk 404 pada /apaaja)
        try_files $uri $uri/ /info.html =404;
    }
    # TIDAK ADA LOG DI SINI
}




user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 768;
    # multi_accept on;
}

http {

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    # --- SOAL 6 FIX: CUSTOM LOG FORMAT untuk GUSTAVE ---
    log_format jarkom_log '[$time_local] Jarkom Node Gustave Access from $remote_addr using method "$request" returned status $status with $body_bytes_sent bytes sent in $request_time seconds';
    
    # --- SOAL 10 FIX: PERBAIKAN LOG BUFFER (Agar Round-Robin tercatat) ---
    access_log /tmp/access.log jarkom_log buffer=1k flush=1s;
    error_log /var/log/nginx/error.log;

    gzip on;

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}

rm /etc/nginx/conf.d/00-custom-log.conf



#semua client

ping expeditioners.com


lynx http://expeditioners.com/profil_lune
lynx http://expeditioners.com/profil_sciel
lynx http://expeditioners.com/profil_gustave

lynx http://expeditioners.com
lynx http://expeditioners.com/apaaja





Langkah 1: Bersihkan Log Server
Di LUNE, SCIEL, dan GUSTAVE, bersihkan log lama agar mudah menghitung request baru:

Bash

# Di terminal LUNE, SCIEL, dan GUSTAVE
echo "" > /tmp/access.log


Langkah 2: Akses Berulang dari Klien
Di terminal KLIEN (misalnya Esquie), akses root domain TIGA KALI (atau kelipatannya, misal 6 kali) untuk memaksa Round-robin bekerja:

# Di terminal KLIEN
lynx http://expeditioners.com; lynx http://expeditioners.com; lynx http://expeditioners.com


Langkah 3: Verifikasi Distribusi Traffic (Di Server)

Sekarang, cek access log di ketiga server. Setiap server harus punya minimal 1 baris log baru.

LUNE	"cat /tmp/access.log"	Harus ada 1 baris log baru dari IP Alicia (10.59.4.10).
SCIEL	"cat /tmp/access.log"	Harus ada 1 baris log baru dari IP Alicia (10.59.4.10).
GUSTAVE	"cat /tmp/access.log"	Harus ada 1 baris log baru dari IP Alicia (10.59.4.10).