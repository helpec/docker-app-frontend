FROM nginx:stable

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG WEBAPP_VERSION

ENV BUILD_DATE ${OPAC_BUILD_DATE}

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Helpec WebApp Frontend - development build" \
      org.label-schema.description="Helpec WebApp frontend" \
      org.label-schema.url="https://github.com/helpec/app-frontend/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/helpec/app-frontend/" \
      org.label-schema.vendor="Helpec" \
      org.label-schema.version=$WEBAPP_VERSION \
      org.label-schema.schema-version="1.0"

RUN apt update &&\
    apt install curl git-core -y &&\
    curl -sL https://deb.nodesource.com/setup_10.x | bash - &&\
    apt install nodejs -y

RUN echo $(node --version) &&\
    echo $(npm --version)


# Create app directory
WORKDIR /opt/app

RUN git clone --depth=1 https://github.com/helpec/app-frontend.git ./
RUN npm install && npm run build

COPY nginx.conf /etc/nginx/nginx.conf

USER nobody
EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"]
