
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
