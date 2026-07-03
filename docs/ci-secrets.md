# CI Secrets 設定手順（Docker Hub push用）

`.github/workflows/build.yml` は main ブランチへの push 時に、ビルドしたDockerイメージを Docker Hub (`enprocode/mirack-epgstation-px-x1ud`) へ push します。この push には GitHub リポジトリ側で以下の Secrets 登録が必要です。

- `DOCKERHUB_USERNAME` — Docker Hub のユーザー名
- `DOCKERHUB_TOKEN` — Docker Hub のアクセストークン（パスワードではなくアクセストークンを使用）

未設定のままだと、`docker/login-action` でログインに失敗し、mainへのpush時にワークフローがエラーになります（PR時のビルド検証ジョブはログイン不要なので影響ありません）。

## 1. Docker Hub でアクセストークンを発行する

1. [Docker Hub](https://hub.docker.com/) にログイン
2. 右上のアカウントメニュー → **Account Settings** → **Security**
3. **New Access Token** をクリック
4. 説明（例: `github-actions-mirakc-epgstation`）を入力し、権限は **Read & Write** を選択して発行
5. 表示されたトークンをコピーする（画面を閉じると再表示できないため、この時点で必ず控える）

## 2. GitHubリポジトリに Secrets を登録する

1. GitHubリポジトリ → **Settings** → **Secrets and variables** → **Actions**
2. **New repository secret** をクリックし、以下の2つを登録する
   - Name: `DOCKERHUB_USERNAME` / Value: Docker Hub のユーザー名
   - Name: `DOCKERHUB_TOKEN` / Value: 手順1で発行したアクセストークン

## 3. 動作確認

- main ブランチへ `mirakc-epgstation/**` 配下の変更を push するか、Actions タブから `Docker image publish` ワークフローを `workflow_dispatch` で手動実行する
- ビルド完了後、Docker Hub (`enprocode/mirack-epgstation-px-x1ud`) に `latest` タグでイメージが push されていることを確認する

## 参考

- 対象ワークフロー: [`../.github/workflows/build.yml`](../.github/workflows/build.yml)
