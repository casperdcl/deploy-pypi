FROM python:3.7-alpine
LABEL maintainer.name="Casper da Costa-Luis" \
      maintainer.email="casper.dcl@physics.org" \
      repository.url="https://github.com/casperdcl/deploy-pypi"
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk update && apk --no-cache add gnupg bash
RUN apk update \
  && apk --no-cache add --virtual .build-deps gcc musl-dev libffi-dev openssl-dev \
  && apk del libressl-dev \
  && pip install -U --no-cache-dir twine \
  && apk del .build-deps

WORKDIR /wdir
COPY script.sh .
RUN chmod +x script.sh
ENTRYPOINT ["/wdir/script.sh"]
