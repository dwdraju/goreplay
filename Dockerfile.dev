FROM golang:1.21 as builder
ENV GOOS=linux
RUN apt-get update && apt-get install flex bison -y

RUN wget http://www.tcpdump.org/release/libpcap-1.7.4.tar.gz && \
	tar xzf libpcap-1.7.4.tar.gz
WORKDIR libpcap-1.7.4
RUN ./configure && make install

RUN mkdir $HOME/gocode/
WORKDIR $HOME/gocode/
ADD . goreplay/
WORKDIR goreplay
RUN go get github.com/xdg-go/scram
RUN go build -ldflags "-extldflags \"-static\"" -o /bin/gor ./cmd/gor/
RUN echo $?

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /bin/gor .
ENTRYPOINT ["./gor"]
