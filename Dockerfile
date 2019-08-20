FROM alpine:3.10.1
RUN apk add --update --no-cache jq curl
ADD macapi.sh /macapi.sh
USER nobody
ENV MACADDRESS_API_KEY_FILE=/etc/macaddress.key
ENTRYPOINT ["/macapi.sh"]
CMD []
