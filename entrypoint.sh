#!/bin/bash

# コンテナ起動時に毎回実行されるスクリプト
# コマンドの終了ステータスがtrue(0)でない場合即座に処理を中止する
set -e

# 既にserver.pid が存在してしまっていると起動エラーが起こるため、削除する
rm -f /src/tmp/pids/server.pid

# コンテナーのプロセスを実行する（Dockerfile 内の CMD に設定されているもの）
exec "$@"