cat /root/ta-lib-0.4.0-src.tar.gz | tar -xzv -C /tmp/
cd /tmp/ta-lib
./configure --prefix=/usr
make
make install
pip install --pre zillionare-omicron
