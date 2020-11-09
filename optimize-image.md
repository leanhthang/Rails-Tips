## refers: https://guides.wp-bullet.com/batch-optimize-jpg-lossy-linux-command-line-with-jpeg-recompress/
# Optimize JPG Lossy Linux with jpeg-recompress
```bash
  sudo apt-get install build-essential autoconf pkg-config nasm libtool git gettext libjpeg-dev -y
```
# Build mozjpeg, the latest tar.gz can be found here which you can replace below in the wget line.

```bash
  cd /tmp
  wget https://github.com/mozilla/mozjpeg/releases/download/v3.1/mozjpeg-3.1-release-source.tar.gz -O mozjpeg.tar.gz
  tar -xf mozjpeg.tar.gz
  cd mozjpeg
  autoreconf -fiv
  ./configure --with-jpeg8 --prefix=/usr
  make
  sudo make install
```
# Install jpeg-recompress with these commands, make sure you have the bzip2 package.

```bash
  sudo apt-get install bzip2
  cd /tmp
  wget https://github.com/danielgtaylor/jpeg-archive/releases/download/2.1.1/jpeg-archive-2.1.1-linux.tar.bz2 -O jpeg-archive.tar.bz2
  tar -xf jpeg-archive.tar.bz2
  sudo cp jpeg-recompress /usr/bin/jpeg-recompress
  sudo chmod 755 /usr/bin/jpeg-recompress
```

# Use

```bash
  jpeg-recompress --quality medium --method ssim image.jpg output.jpg
  jpeg-recompress --quality high --accurate --method smallfry --min 60 image.jpg image.jpg
```
### --method: smallfry/ ssim /MPE
### If you want to be extra accurate but slower you can add the --accurate flag
### You can also specify the minimum quality allowed with --min and jpeg-compress will do comparisons to ensure the best compression ratio without losing quality.
