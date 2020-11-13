# Gem image_optim
## Refers: https://github.com/toy/image_optim
# Linux - RHEL/Fedora/Centos
```bash
  yum install -y advancecomp gifsicle jhead libjpeg optipng pngquant
  yum install -y libjpeg-turbo-utils
```

# jpegoptim
```bash
  cd /tmp
  curl -O https://www.kokkonen.net/tjko/src/jpegoptim-1.4.7.tar.gz
  tar zxf jpegoptim-1.4.7.tar.gz
  cd jpegoptim-1.4.7
  ./configure && make && make install
```

# pngcrush
```bash
  cd /tmp
  curl -O https://iweb.dl.sourceforge.net/project/pmt/pngcrush/1.8.13/pngcrush-1.8.13.tar.gz
  tar zxf pngcrush-1.8.13.tar.gz
  cd pngcrush-1.8.13
  make && cp -f pngcrush /usr/local/bin
```

# GImage processing
install vips lib
```bash
  curl -O https://github.com/libvips/libvips/releases/download/v8.10.2/vips-8.10.2.tar.gz
  cd /tmp
  tar xf vips-8.10.2.tar.gz
  cd vips-7.30.2
  yum install glib2-devel
  ./configure && make && make install
```
