FROM  lsiobase/alpine.armhf:3.9

RUN   apk add --no-cache curl nano git python2 py-psutil \
      && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
      && python get-pip.py \
      && apk add --no-cache --virtual=build-dependencies g++ gcc make python2-dev libffi-dev build-base \
      && pip install --no-binary gevent gevent \
      && apk del --purge build-dependencies

ADD   acestream_3.1.33_py2.7.15_webUI_ARMv7.tar.gz /

RUN   find /acestrem.engine/androidfs/system -type d -exec chmod 755 {} \; \
      && find /acestrem.engine/androidfs/system -type f -exec chmod 644 {} \; \
      && chmod 755 /acestrem.engine/androidfs/system/bin/* \
      /acestrem.engine/androidfs/acestream.engine/python/bin/python

COPY  ./HTTPAceProxy /HTTPAceProxy

EXPOSE  6878 62062 8621 8000

COPY  root/ /

RUN chmod +x /acestrem.engine/start.sh
