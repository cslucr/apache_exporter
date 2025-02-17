FROM golang \
  as build

COPY . /go/src/apache_exporter

RUN cd /go/src/apache_exporter \
  && make \
  && sha256sum apache_exporter

FROM quay.io/prometheus/busybox:latest

COPY --from=build /go/src/apache_exporter/apache_exporter /bin/apache_exporter

ENTRYPOINT ["/bin/apache_exporter"]
EXPOSE     9117
