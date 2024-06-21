FROM node:alpine3.15
#環境変数を設定
# ENV NODE_ENV="development"
# ENV LOG_LEVEL='debug'
# ENV BIGQUERY_PROJECT='th-all'
# ENV BIGQUERY_DATASET='th_dashboard_taiwan'
# ENV BIGQUERY_LOCATION='asia-east1'
# ENV BIGQUERY_KEYNAME='.secret/th-all-3d9764a8e71b.json'
ENV MYSQL_HOST='35.236.169.181'
ENV MYSQL_USER='th_all_admin'
ENV MYSQL_PASSWORD='YUyu0121jiJI'
ENV MYSQL_DBNAME='crowd_log'
ENV CROWDLOG_FROM='2024-06-01'
ENV CROWDLOG_TO='2024-06-30'
ENV CROWDLOG_TOKEN='Bearer CXCE5amyGwrhHV27JzW+aBqrgT-tI3-1I7LM6JfA'

# pnpmをインストール
RUN npm install -g pnpm
# backendディレクトリをワーキングディレクトリに指定
WORKDIR /backend
# packageインストールに必要なファイルをローカルからコンテナのワーキングディレクトリにコピー
COPY package.json ./
COPY pnpm-lock.yaml ./
# キーファイルをコピー 0713追記
# COPY .secret/th-all-3d9764a8e71b.json ./
# ENV BIGQUERY_KEYNAME='th-all-3d9764a8e71b.json'

# buildに必要なファイルファイルをローカルからコンテナのワーキングディレクトリにコピー
COPY tsconfig.json ./
COPY src ./src
# packageインストール、 build
RUN pnpm i
RUN pnpm build

# サーバー起動
CMD ["pnpm", "start"]