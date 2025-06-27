FROM node:22 AS staging

WORKDIR /app
COPY package.json ./

RUN yarn install

COPY . .
RUN yarn build

FROM subquerynetwork/subql-node-ethereum:latest

WORKDIR /app

COPY --from=staging /app/dist ./dist
COPY --from=staging /app/schema.graphql ./schema.graphql
COPY --from=staging /app/project.yaml ./project.yaml
COPY --from=staging /app/package.json ./package.json
COPY --from=staging /app/abis /app/abis