FROM alpine:3.14

RUN  export TENGINE_VERSION='2.3.3' \
     && export CONFIG="\
          --prefix=/app/tengine \
          --sbin-path=/usr/sbin/nginx \
          --modules-path=/app/tengine/modules \
          --conf-path=/app/tengine/conf/nginx.conf \
          --error-log-path=/app/tengine/logs/error.log \
          --http-log-path=/app/tengine/logs/access.log \
          --pid-path=/app/tengine/pid/nginx.pid \
          --lock-path=/app/tengine/lock/nginx.lock \
          --http-client-body-temp-path=/app/tengine/temp/client_temp \
          --http-proxy-temp-path=/app/tengine/temp/proxy_temp \
          --http-fastcgi-temp-path=/app/tengine/temp/fastcgi_temp \
          --http-uwsgi-temp-path=/app/tengine/temp/uwsgi_temp \
          --http-scgi-temp-path=/app/tengine/temp/scgi_temp \
          --user=nginx \
          --group=nginx \
          --with-http_ssl_module \
          --with-http_realip_module \
          --with-http_addition_module \
          --with-http_sub_module \
          --with-http_dav_module \
          --with-http_flv_module \
          --with-http_mp4_module \
          --with-http_gunzip_module \
          --with-http_gzip_static_module \
          --with-http_random_index_module \
          --with-http_secure_link_module \
          --with-http_stub_status_module \
          --with-http_auth_request_module \
          --with-http_xslt_module=dynamic \
          --with-http_image_filter_module=dynamic \
          --with-http_geoip_module=dynamic \
          --with-http_perl_module=dynamic \
          --with-threads \
          --with-stream=dynamic \
          --with-stream_sni \
          --with-stream_ssl_module \
          --with-stream_ssl_preread_module \
          --with-stream_realip_module \
          --with-stream_geoip_module=dynamic \
          --with-http_slice_module \
          --with-mail=dynamic \
          --with-mail_ssl_module \
          --with-compat \
          --with-file-aio \
          --with-http_v2_module \
          --with-ipv6 \
          --with-pcre \
          --with-pcre-jit \
          --with-luajit-lib=/usr/local/lib \
          --with-luajit-inc=/usr/local/include/luajit-2.1 \
          --with-lua-lib=/usr/local/lib \
          --with-lua-inc=/usr/local/include \
          --add-module=modules/headers-more-nginx-module-0.33 \
          --add-module=modules/ngx_multi_upstream_module \
          --add-module=modules/ngx_http_upstream_check_module \
          --add-module=modules/ngx_http_upstream_session_sticky_module \
          --add-module=modules/ngx_http_user_agent_module \
          --add-module=modules/ngx_http_upstream_vnswrr_module \
          --add-module=modules/nginx-limit-speed-module \
          --add-module=modules/ngx_devel_kit-0.3.1 \
          --add-module=modules/ngx_brotli \
          --add-dynamic-module=modules/ngx_slab_stat \
          --add-dynamic-module=modules/ngx_debug_pool \
          --add-dynamic-module=modules/nginx-auth-ldap \
          --add-dynamic-module=modules/lua-nginx-module-0.10.14 \
          --add-dynamic-module=modules/nginx-module-vts-0.1.18 \
          " \
          && rm -rf /var/cache/apk/* \
          && rm -rf /tmp/* \
          && addgroup --system --gid 101 nginx \
          && adduser --system --ingroup nginx --no-create-home --home /var/lib/nginx --gecos "Nginx web server" --shell /bin/false --uid 101 nginx \
          && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
          && apk add --no-cache --virtual .build-deps \
                    patch \
                    gcc \
                    g++ \
                    libc-dev \
                    make \
                    openssl \
                    openssl-dev \
                    pcre \
                    pcre-dev \
                    perl \
                    perl-dev \
                    zlib-dev \
                    bzip2 \
                    linux-headers \
                    curl \
                    libxslt \
                    libxslt-dev \
                    gd-dev \
                    readline \
                    readline-dev \
                    nmap \
                    libxml2 \
                    libxml2-dev \
                    geoip \
                    geoip-dev \
                    psmisc \
                    ncurses-dev \
                    libevent-dev \
                    openldap \
                    openldap-dev \
          && curl -L "http://storage.corpintra.plus/tengine/tengine-$TENGINE_VERSION.tar.gz" -o tengine.tar.gz \
          && curl -L "http://storage.corpintra.plus/tengine/modules/lua-5.1.5.tar.gz" -o lua-5.1.5.tar.gz \
          && curl -L "http://storage.corpintra.plus/tengine/modules/luajit2-2.1-20201229.tar.gz" -o luajit2-2.1-20201229.tar.gz \
          && curl -L "http://storage.corpintra.plus/tengine/modules/lua-cjson-2.1.0.7.tar.gz" -o lua-cjson-2.1.0.7.tar.gz \
          && mkdir -p /usr/src \
          && tar -zxC /usr/src -f tengine.tar.gz \
          && tar -zxC /usr/src -f lua-5.1.5.tar.gz \
          && tar -zxC /usr/src -f luajit2-2.1-20201229.tar.gz \
          && tar -zxC /usr/src -f lua-cjson-2.1.0.7.tar.gz \
          && rm tengine.tar.gz \
          && rm lua-5.1.5.tar.gz \
          && rm luajit2-2.1-20201229.tar.gz \
          && rm lua-cjson-2.1.0.7.tar.gz \
     && cd /usr/src/lua-5.1.5 \
          && make linux \
          && make install \
     && cd /usr/src/luajit2-2.1-20201229 \
          && make -j2 \
          && make install \
     && cd /usr/src/lua-cjson-2.1.0.7 \
          && export LUA_INCLUDE_DIR=/usr/local/include/luajit-2.1 \
          && export LUAJIT_LIB=/usr/local/lib \
          && export LUAJIT_INC=/usr/local/include/luajit-2.1 \
          && make -j2 \
          && make install \
     && cd /usr/src/tengine-$TENGINE_VERSION \
          && curl -L "http://storage.corpintra.plus/tengine/modules/lua-nginx-module-0.10.14.tar.gz" -o lua-nginx-module-0.10.14.tar.gz \
          && curl -L "http://storage.corpintra.plus/tengine/modules/headers-more-nginx-module.tar.gz" -o headers-more-nginx-module.tar.gz \
          && curl -L "http://storage.corpintra.plus/tengine/modules/nginx-auth-ldap.tar.gz" -o nginx-auth-ldap.tar.gz \
          && curl -L "http://storage.corpintra.plus/tengine/modules/nginx-module-vts-0.1.18.tar.gz" -o nginx-module-vts-0.1.18.tar.gz \
          && curl -L "http://storage.corpintra.plus/tengine/modules/ngx_devel_kit-0.3.1.tar.gz" -o ngx_devel_kit-0.3.1.tar.gz \
          && curl -L "http://storage.corpintra.plus/tengine/modules/ngx_brotli.tar.gz" -o ngx_brotli.tar.gz \
          && curl -L "http://storage.corpintra.plus/tengine/modules/nginx-limit-speed-module.tar.gz" -o nginx-limit-speed-module.tar.gz \
          && tar -zxC /usr/src/tengine-$TENGINE_VERSION/modules -f lua-nginx-module-0.10.14.tar.gz \
          && tar -zxC /usr/src/tengine-$TENGINE_VERSION/modules -f headers-more-nginx-module.tar.gz \
          && tar -zxC /usr/src/tengine-$TENGINE_VERSION/modules -f nginx-auth-ldap.tar.gz \
          && tar -zxC /usr/src/tengine-$TENGINE_VERSION/modules -f nginx-module-vts-0.1.18.tar.gz \
          && tar -zxC /usr/src/tengine-$TENGINE_VERSION/modules -f ngx_devel_kit-0.3.1.tar.gz \
          && tar -zxC /usr/src/tengine-$TENGINE_VERSION/modules -f ngx_brotli.tar.gz \
          && tar -zxC /usr/src/tengine-$TENGINE_VERSION/modules -f nginx-limit-speed-module.tar.gz \
          && rm  lua-nginx-module-0.10.14.tar.gz \
          && rm  headers-more-nginx-module.tar.gz \
          && rm  nginx-auth-ldap.tar.gz \
          && rm  nginx-module-vts-0.1.18.tar.gz \
          && rm  ngx_devel_kit-0.3.1.tar.gz \
          && rm  ngx_brotli.tar.gz \
          && rm  nginx-limit-speed-module.tar.gz \
     && ls -l /usr/src/tengine-$TENGINE_VERSION/modules \
     && ./configure $CONFIG \
          && make -j$(getconf _NPROCESSORS_ONLN) \
          && make install \
          && strip /usr/sbin/nginx* \
          && strip /app/tengine/modules/*.so \
          && rm -rf /usr/src \
          && mkdir -p /app/tengine/conf.d /app/tengine/temp /app/tengine/pid /app/tengine/lock /app/tengine/logs \
          \
          # forward request and error logs to docker log collector
          && ln -sf /dev/stdout /app/tengine/logs/access.log \
          && ln -sf /dev/stderr /app/tengine/logs/error.log \
          && chown -Rf nginx:nginx /app/tengine/conf /app/tengine/conf.d /app/tengine/html /app/tengine/temp /app/tengine/pid /app/tengine/lock /app/tengine/logs \
          \
          # Bring in gettext so we can get `envsubst`, then throw
          # the rest away. To do this, we need to install `gettext`
          # then move `envsubst` out of the way so `gettext` can
          # be deleted completely, then move `envsubst` back.
          && apk add --no-cache --virtual .gettext gettext \
          && mv /usr/bin/envsubst /tmp/ \
          \
          && runDeps="$( \
                    scanelf --needed --nobanner --format '%n#p' /usr/sbin/nginx /app/tengine/modules/*.so /usr/local/lib/*.so /tmp/envsubst \
                         | tr ',' '\n' \
                         | sort -u \
                         | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
          )" \
          && apk add --no-cache $runDeps \
          && apk del .build-deps \
          && apk del .gettext \
          && mv /tmp/envsubst /usr/local/bin/ \
          \
          # Bring in tzdata so users could set the timezones through the environment
          # variables
          && apk add --no-cache tzdata \
          && rm -rf /var/cache/apk/* \
          && rm -rf /root/.cache \
          && rm -rf /tmp/*

COPY --chown=nginx:nginx nginx.conf /app/tengine/conf/nginx.conf

EXPOSE 8080

STOPSIGNAL SIGTERM

USER nginx

CMD ["nginx", "-g", "daemon off;"]
