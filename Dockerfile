FROM ubuntu:18.04 as dl
ARG VERSION
ARG CHECKSUM=06db32d03dca6ac8a8245928d1cb92b37d3aec97084d05665d3bae2c86a65761
ARG FILENAME="${VERSION}.tar.gz"
WORKDIR /tmp
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    wget=1.19.4-1ubuntu2.2 && \
  echo "**** download app ****" && \
  mkdir /app && \
  wget --no-check-certificate "https://github.com/babybuddy/babybuddy/archive/${FILENAME}" && \
  echo "${CHECKSUM}  ${FILENAME}" | sha256sum -c && \
  tar -xvf "${FILENAME}" --strip-components 1 -C /app
WORKDIR /app

FROM python:3.7.10-slim-buster
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nicholaswilde"
ENV PYTHONUNBUFFERED 1
ENV PACKAGES=""
WORKDIR /app
COPY --from=dl [ \
  "/app/Pipfile", \
  "/app/manage.py", \
  "/app/etc/gunicorn.py", \
  "./" \
]
COPY --from=dl ["/app/api/", "./api"]
COPY --from=dl ["/app/babybuddy/", "./babybuddy"]
COPY --from=dl ["/app/core/", "./core"]
COPY --from=dl ["/app/dashboard/", "./dashboard"]
COPY --from=dl ["/app/reports/", "./reports"]
COPY --from=dl ["/app/static/", "./static"]
COPY ["./entrypoint.sh", "/app"]
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
  echo "**** create abc user and make our folders ****" && \
  useradd -u 911 -U -d /config -s /bin/false abc && \
  usermod -G users abc && \
  mkdir -p \
    ./data \
    ./media \
    /config \
    /defaults && \
  chown -R abc:abc \
    /config \
    /defaults \
    /app && \
  chmod +x ./entrypoint.sh && \
  echo "**** install app ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libjpeg-dev=1:1.5.2-2+deb10u1 \
    libpq-dev=11.10-0+deb10u1 \
    build-essential=12.6 \
    zlib1g-dev=1:1.2.11.dfsg-1 && \
  pip install --no-cache-dir --upgrade \
    pipenv==2020.11.15 \
    gunicorn==20.0.4 \
    setuptools==53.0.0 \
    whitenoise==5.2.0 && \
  pipenv lock && \
  pipenv install --deploy --system && \
  echo "**** cleanup ****" && \
  apt-get autoremove -y \
    libjpeg-dev \
    libpq-dev \
    build-essential \
    zlib1g-dev && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/ \
    /var/tmp/*
VOLUME \
  /app/data \
  /app \
  /app/media
EXPOSE 8000
USER abc
ENTRYPOINT ["/app/entrypoint.sh"]
