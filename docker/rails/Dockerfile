FROM ruby:3.1.0

# Rails7ではnode.jsのインストールは不要
RUN apt-get update -qq && apt-get install -y default-mysql-client

# ワーキングディレクトリを指定
RUN mkdir /src
WORKDIR /src

# COPY <src>... <dest>
# <src>はビルドコンテキストからの相対パス
COPY ./src/Gemfile /src/Gemfile
COPY ./src/Gemfile.lock /src/Gemfile.lock

RUN bundle install
COPY ./src /src

# ---- コンテナ起動時に毎回実行されるスクリプト ----
COPY ./entrypoint.sh /usr/bin/

# ファイル所有者に実行権限(x)を付与(+)
RUN chmod +x /usr/bin/entrypoint.sh

# 必ず実行する固定コマンド
ENTRYPOINT ["entrypoint.sh"]

# コンテナがリッスン(待機)するポート番号
EXPOSE 3000
# ---- ここまで ----

# railsの実行
CMD ["rails", "server", "-b", "0.0.0.0"]