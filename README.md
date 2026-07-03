# px-x1ud-driver

PX-x1UDシリーズ地デジチューナー関連のリポジトリ一式。

## フォルダ構成と役割

| フォルダ | 役割 | 状態 |
|---|---|---|
| `driver` | PX-x1UDのLinuxドライバインストールスクリプト。他方の前提となる作業。 | 現行 |
| `mirakc-epgstation` | mirakc + epgstationのDockerビルド本体。Docker Hub (`enprocode/mirack-epgstation-px-x1ud`) に公開イメージあり、GitHub Actionsでビルド自動化済み。 | 現行・メイン |

旧版だった`beta-mirakc-px-x1ud-docker-build`（`mirakc-epgstation-px-x1ud`に統合済みのベータ版）は削除済み。

※ フォルダ名は実体のソフトウェア名「mirakc」に合わせて修正済みです。ただし上記のDocker Hub/GitHubリポジトリ名は上流の公開名（`mirack-epgstation-px-x1ud`、スペルはそのまま）なので変更していません。

## ドキュメント

各リポジトリのREADMEを `docs/` に集約しています。

- [driver.md](docs/driver.md) — ドライバインストール手順
- [mirakc-epgstation.md](docs/mirakc-epgstation.md) — Docker構築手順
- [ci-secrets.md](docs/ci-secrets.md) — CI（Docker Hub push）用Secrets設定手順

## 導入順序

1. `driver` でドライバをインストール
2. `mirakc-epgstation/setup` で mirakc + epgstation をDocker構築

## CI設定 (.github/workflows)

各サブフォルダに分散していたGitHub Actions設定は、ルート直下の `.github/workflows/` に統合しています。

| ワークフロー | 対象パス | 内容 |
|---|---|---|
| `dependency-review.yml` | `driver/**`, `.github/workflows/**` | PR時の依存関係レビュー（公式テンプレート準拠） |
| `build.yml` | `mirakc-epgstation/**` | Dockerイメージをビルドし Docker Hub (`enprocode/mirack-epgstation-px-x1ud`) へpush（push時はamd64/arm64、PR時はamd64のみのビルド検証） |

※ いずれも一般的な標準構成で再作成したものです。`build.yml`の実行には `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN` のSecrets設定が別途必要です（手順: [ci-secrets.md](docs/ci-secrets.md)）。

## 比較メモ (beta版 vs 現行版)

- `docker-compose.yml`: バージョン記法が `1.1` → `3.8` に更新
- `Dockerfile`: 現行版は `mirakc_init.sh` をリポジトリ内（`docker/mirakc/mirakc_init.sh`）から `COPY` して組み込む方式に変更（beta版はGitHubから直接wgetする方式）
- `mirakc/config.yml`: 現行版はチャンネル数が大幅増加（関東エリア想定の局が追加）、`recdvb`のオプション(`--b25 --strip`)を削除、B25デコード用`filters`をコメントアウトから有効化に変更

以上より、`beta-mirakc-px-x1ud-docker-build`は`mirakc-epgstation-px-x1ud`の前身であり、内容的には後者に統合済みと考えられます。
