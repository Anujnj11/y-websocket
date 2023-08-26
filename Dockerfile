FROM docker.io/node:lts-alpine

ENV PORT=1234

WORKDIR /work

RUN addgroup --system y-socket && adduser --system -G y-socket y-socket
RUN npm install pm2 -g
# Copy output from market-data dist
COPY . .


RUN chown -R y-socket:y-socket ./*
RUN npm install -f

# You can remove this install step if you build with `--bundle` option.
# The bundled output will include external dependencies.
# RUN dir -s
# RUN npm --prefix market-data --omit=dev -f install

# Expose application port 80 for middleware
EXPOSE 1234

# Run in cluster mode
# CMD [ "npm", "start" ]
CMD [ "pm2-runtime", "ecosystem.config.js"]