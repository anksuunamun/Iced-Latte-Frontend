FROM node:alpine
ENV NODE_ENV production
WORKDIR /usr/app
COPY --chown=node ./package*.json ./
RUN npm install --global pm2
RUN npm ci --omit=dev
COPY --chown=node ./ ./
RUN npm run build
EXPOSE 3000
USER node
CMD [ "pm2-runtime", "start", "npm", "--", "run", "start" ]
