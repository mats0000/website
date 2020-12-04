1.  このリポジトリを fork する

1.  fork したリポジトリを clone

    ```bash
    git clone [forkしたリポジトリのurl]
    ```

1.  nvm の install と nodev12.13.1 の install

    ```bash
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    source ~/.nvm/nvm.sh
    nvm install v12.13.1
    nvm use v12.13.1
    
    // nvm.shを読み込むコマンドを追加
    // zshを使ってる人
    touch ~/.zshrc
    echo source ~/.nvm/nvm.sh >> ~/.zshrc
    // bashを使ってる人
    touch ~/.bashrc
    echo source ~/.nvm/nvm.sh >> ~/.bashrc
    ```

1.  yarn の install

    ```bash
    npm install -g yarn
    ```

1.  関連パッケージの install

    ```bash
    yarn install
    ```

1.  local 環境の設定ファイルを作成

    ```bash
    cp .env.local.sample .env.local
    ```

    local サーバーを参照する場合は書き換えが必要です。

1.  実際の画面確認

        ```bash
        yarn serve
        ```

    http://localhost:8080
    にアクセス

## デプロイ

リリースタグを付けると、github actionsがリリースをしてくれます。


1. リリースしたいcommitに移動

masterの最新なら git checkout master でよい。
切り戻したい場合、切り戻したいcommit hashに移動する。

2. git tag v-yymmdd-HHdd

```
例） git tag v-200908-1923
```

3. git push upstream v-yymmdd-HHdd

```
例） git push upstream v-200908-1923
```

## デプロイ後の切り戻し

https://github.com/geo-logic/geologic-admin/releases

ここにリリースした内容が追記されていきます。

このcommit hashを使いcommitに戻り、再度タグ付けをしてもどってください。
