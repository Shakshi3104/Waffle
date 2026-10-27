# Release Guide

Waffle (iOS) の TestFlight 配信は [`asc`](https://github.com/rorkai/App-Store-Connect-CLI) (App Store Connect CLI) でローカル完結します。配信対象は **Internal Tester のみ**です(External / Beta App Review は使いません)。macOS 版は対象外です。

---

## セットアップ(初回のみ)

### 1. asc CLI をインストール

```bash
brew install asc
```

### 2. App Store Connect にアプリを作成

Bundle ID `com.shakshi.WaffleApp` (iOS) でアプリレコードを作成し、URL 中の App ID(数字)を控える。

> `com.shakshi.Waffle` は Apple 側で利用不可だったため `com.shakshi.WaffleApp` を使用しています。

### 3. 認証情報を .env に登録

```bash
cp .env.example .env
# ASC_KEY_ID / ASC_ISSUER_ID / ASC_PRIVATE_KEY_PATH / ASC_APP_ID / ASC_BETA_GROUP_ID を入力
```

`ASC_BETA_GROUP_ID` は配信先の Internal テストグループの ID です。グループが無ければ作成してから ID を控えます。

```bash
asc testflight groups create --app "$ASC_APP_ID" --name "<App> Internal" --internal
asc testflight groups list --app "$ASC_APP_ID" --internal
```

API キーは Specter / yomy などと共通のチームキーを使えます。`.env` は `.gitignore` 済みです。

---

## リリース手順

```bash
set -a; source .env; set +a
asc workflow run testflight_internal VERSION:1.0
```

archive → IPA エクスポート → アップロード → 処理完了待ち → `ASC_BETA_GROUP_ID` のグループへの割り当て を 1 コマンドで実行。割り当てが終わると、そのグループに入っている Internal Tester に届きます。

---

## ビルド番号の運用

`CFBundleVersion` は Run Script build phase「Set Build Number」で `git rev-list --count HEAD` の値に自動で書き換わります。

- ビルド設定の `CURRENT_PROJECT_VERSION` は `1` のまま据え置き
- 成果物の `Waffle.app/Info.plist` だけが書き換わる
- 何もコミットせずに再実行するとビルド番号が重複してアップロードが弾かれるので、コミットしてから実行する

---

## トラブルシュート

### `Error Opening Destination: [Operation not permitted]`

Run Script の sandbox が `.git/` 読み or `Info.plist` 書きをブロックしている。`ENABLE_USER_SCRIPT_SANDBOXING = NO` になっているか確認(設定済み)。

### アップロード時に App が見つからない

`ASC_APP_ID` が未設定か、App Store Connect にアプリレコードがない。上記セットアップ 2 を確認。
