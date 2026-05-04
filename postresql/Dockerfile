FROM postgres:16.2

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       build-essential \
       postgresql-server-dev-16 \
       postgresql-plpython3-16 \
       python3-pip \
    && pip3 install pgxnclient --break-system-packages \
    && pgxn install postgresql_anonymizer \
    && apt-get purge -y \
       build-essential \
       postgresql-server-dev-16 \
       python3-pip \
       curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*