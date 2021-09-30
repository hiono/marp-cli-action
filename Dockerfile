FROM marpteam/marp-cli:latest

USER root
WORKDIR /github/workspace

ENV LANG="ja_JP.UTF-8"
RUN apk --no-cache add curl && \
    cd /tmp && \
    mkdir noto && \
    curl -O -L https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip && \
    unzip NotoSansCJKjp-hinted.zip -d ./noto && \
    mkdir -p /usr/share/fonts/noto && \
    cp ./noto/*.otf /usr/share/fonts/noto/ && \
    chmod 644 /usr/share/fonts/noto/*.otf && \
    fc-cache -fv && \
    rm -rf NotoSansCJKjp-hinted.zip ./noto

COPY fontconfig.xml /home/marp/.cli-action/
COPY package.json package-lock.json /home/marp/.cli-action/
RUN cd /home/marp/.cli-action/ && npm ci
COPY entrypoint.js /home/marp/.cli-action/

ENTRYPOINT ["/home/marp/.cli-action/entrypoint.js"]
CMD []
