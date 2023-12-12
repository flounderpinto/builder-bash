#TODO
FROM flounder5/runner-bash:3bc95641187ab116fad9f5695f827b48c9d0ca23

RUN apt-get update && \
    apt-get install -y \
        shellcheck && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*