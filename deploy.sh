#!/bin/bash

#
# 使い方
#  sh deploy.sh preprd 準本番環境
#  sh deploy.sh dev 開発環境

SYSENV=$1

if [ ${SYSENV} = "prd" ]; then
  # 本番環境
  read -p "本番へデプロイしますか？ するばあいは「deploy me」と入力してください。" CONFIRM_STRING
  if [ "${CONFIRM_STRING}" != "deploy me" ]; then
    echo "デプロイ中止しました。"
    exit 1
  fi
  echo 'deploy for production...'
  BUILD_ARG=production
  BUCKET_NAME=gl-prd-admin-frontend
elif [ ${SYSENV} = "preprd" ]; then
  # 準本番環境
  echo 'deploy for pre production...'
  BUILD_ARG=preproduction
  BUCKET_NAME=gl-preprd-admin-frontend
else
  # 開発環境
  echo 'deploy for development...'
  BUILD_ARG=development
  BUCKET_NAME=gl-dev-admin-frontend
fi

check() {
  name=$1
  code=$2

  if [ $code -ne 0 ]; then
    echo "${name} error!!"
    exit 1
  fi
}

#
# moduleの更新
#
yarn --frozen-lockfile

#
# ファイルのbuild
#
yarn run build --mode ${BUILD_ARG}
check "yarn run build?" $?


# リビジョンNOを生成
revision=`date +"%Y%m%d%I%M%S"`

# index.htmlのjavascriptグローバル変数`g_revision`にリビジョンNOをセット
sed -i -e "s/localRevision=\"0\"/localRevision=\"$revision\"/g" ./dist/index.html

# revision.jsonファイルを作成しリビジョンNOをセット
echo "{\"revision\": \"$revision\"}" > ./dist/revision.json

#
# S3へファイルアップロード
#
aws s3 sync ./dist s3://${BUCKET_NAME}/
# revision.jsonだけブラウザcacheされないように修正
aws s3 cp --cache-control 'no-store, no-cache' ./dist/revision.json s3://${BUCKET_NAME}/revision.json
check "s3 upload?" $?

echo 'success!!'
