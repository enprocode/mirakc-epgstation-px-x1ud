# px-x1ud-driver

[![Docker image publish](https://github.com/enprocode/mirakc-epgstation-px-x1ud/actions/workflows/build.yml/badge.svg)](https://github.com/enprocode/mirakc-epgstation-px-x1ud/actions/workflows/build.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/enprocode/mirack-epgstation-px-x1ud)](https://hub.docker.com/r/enprocode/mirack-epgstation-px-x1ud)
[![Docker Image Size](https://img.shields.io/docker/image-size/enprocode/mirack-epgstation-px-x1ud)](https://hub.docker.com/r/enprocode/mirack-epgstation-px-x1ud)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

PX-x1UDシリーズ地デジチューナー関連のリポジトリ一式。

## フォルダ構成と役割

| フォルダ | 役割 | 状態 |
|---|---|---|
| `driver` | PX-x1UDのLinuxドライバインストールスクリプト。他方の前提となる作業。 | 現行 |
| `mirakc-epgstation` | mirakc + epgstationのDockerビルド本体。Docker Hub (`enprocode/mirack-epgstation-px-x1ud`) と GitHub Container Registry (`ghcr.io/enprocode/mirakc-epgstation-px-x1ud`) の両方に公開イメージあり、GitHub Actionsでビルド自動化済み。 | 現行・メイン |

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
| `dependency-review.yml` | `driver/**`, `.github/workflows/**` | PR時の依存関係レビュー |
| `build.yml` | `mirakc-epgstation/**`, タグ `v*` | Dockerイメージをビルドし Docker Hub / GitHub Container Registry (GHCR) へpush |
| `release.yml` | `VERSION` | バージョンタグの作成とGitHub Releaseの自動作成（詳細は下記「バージョン管理・リリース」） |

※ いずれも一般的な標準構成で再作成したものです。`build.yml`の実行には `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN` のSecrets設定が別途必要です（手順: [ci-secrets.md](docs/ci-secrets.md)）。

## バージョン管理・リリース

ルート直下の [`VERSION`](VERSION) ファイル（例: `1.0.0`）でリポジトリ全体のバージョンを管理しています。

1. リリースしたいタイミングで `VERSION` の値をSemVer（`X.Y.Z`）で更新し、`main`にpush（またはPRをマージ）する
2. `release.yml` が起動し、`v` を付けたタグ（例: `v1.0.1`）を作成・push、GitHub Releaseを自動作成する
3. タグpushをトリガーに `build.yml` が走り、Docker Hubへそのバージョンのイメージ（`enprocode/mirack-epgstation-px-x1ud:1.0.1` など）をpushする

`VERSION`以外の変更（`mirakc-epgstation/**`のみの更新など）では`release.yml`は動かず、`main`への通常pushとして`:latest`イメージのみ更新されます。

## ライセンス

このリポジトリ内で書かれたスクリプト・設定ファイル・ドキュメントは [MIT License](LICENSE) です。
`driver/`配下のベンダー配布ドライバ（zip）、および mirakc / EPGStation / recdvb / libaribb25 などの上流プロジェクトは、それぞれ別のライセンスに従います。
