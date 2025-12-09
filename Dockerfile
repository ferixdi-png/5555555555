FROM node:24-slim

WORKDIR /app

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python

COPY package*.json ./

RUN npm ci --only=production

COPY requirements.txt ./

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

ENV NODE_ENV=production

CMD ["npm", "start"]
