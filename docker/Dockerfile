FROM flounder5/runner-bash:v0.0.1

RUN apt-get update && \
    apt-get install -y \
        shellcheck && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*