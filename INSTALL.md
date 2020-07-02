```
apt-get update 
apt-get install -y --no-install-recommends g++ gfortran bzip2 unzip make wget git python3 python3-dev python3-websockets python3-setuptools python3-pip python3-wheel zlib1g-dev patch ca-certificates swig cmake xz-utils mc
git clone -b lookahead --single-branch https://github.com/alphacep/kaldi /opt/kaldi
cd /opt/kaldi/tools
sed -i 's:status=0:exit 0:g' extras/check_dependencies.sh
sed -i 's:openfst_add_CXXFLAGS = -g -O2:openfst_add_CXXFLAGS = -g -O3 -msse2:g' Makefile
sed -i 's:--enable-ngram-fsts:--enable-ngram-fsts --disable-bin:g' Makefile
sed -i 's:python:python3:g' extras/install_openblas.sh
sed -i 's:USE_LOCKING=1:DYNAMIC_ARCH=1 USE_LOCKING=1:g' extras/install_openblas.sh
make -j $(nproc) openfst cub
extras/install_openblas.sh
cd /opt/kaldi/src
./configure --mathlib=OPENBLAS --shared
sed -i 's:-msse -msse2:-msse -msse2:g' kaldi.mk
sed -i 's: -O1 : -O3 :g' kaldi.mk
make -j $(nproc) online2 lm




git clone https://github.com/alphacep/vosk-api /opt/vosk-api 
cd /opt/vosk-api/python
KALDI_ROOT=/opt/kaldi python3 ./setup.py install --user --single-version-externally-managed --root=/
git clone https://github.com/alphacep/vosk-server /opt/vosk-server
pip3 install grpcio-tools
cd /opt/vosk-server/grpc
python3 -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=. stt_service.proto
    	


ENV RUVERSION 0.10
mkdir /opt/vosk-model-ru
cd /opt/vosk-model-ru \
wget -q http://alphacephei.com/kaldi/models/vosk-model-ru-${RUVERSION}.zip \
unzip vosk-model-ru-${RUVERSION}.zip \
mv vosk-model-ru-${RUVERSION} model \
rm -rf model/extra \
rm -rf model/rnnlm \
rm -rf vosk-model-ru-${RUVERSION}.zip
```
