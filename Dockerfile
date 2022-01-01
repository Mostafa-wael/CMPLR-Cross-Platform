FROM nginx

COPY ./cmplr/nginx/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./web /usr/share/nginx/html