FROM flounderpinto/runner-bash:v0.1.0

RUN apt-get update && \
    apt-get install -y \
        shellcheck \
        shunit2 && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*