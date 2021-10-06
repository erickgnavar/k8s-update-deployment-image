FROM alpine:3.10

# Download kubectl binary
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

RUN chmod +x kubectl

RUN mkdir -p ~/.local/bin/kubectl

RUN mv ./kubectl ~/.local/bin/kubectl

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
