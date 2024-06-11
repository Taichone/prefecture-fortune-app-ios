# 株式会社ゆめみ iOS 未経験者エンジニア向けコードチェック課題

## 機能の紹介

### ユーザーの情報を入力
以下を入力し、`都道府県を占う！` ボタンを押すと、占い結果に遷移します。
- 名前
- 生年月日
- 血液型
  
<img src="https://github.com/Taichone/yumemi-ios-junior-engineer-codecheck-app/assets/86025871/61ce3703-cbef-46b1-9db0-2d19e47e4e38" width="300">

### 占い結果（おすすめの都道府県）
すると以下が表示されます。
- 都道府県の名前
- 都道府県庁所在地の名前
- 海岸線の有無
- 都道府県民の日（もしあれば）
- 都道府県の説明

また、`地図で確認する！` ボタンを押すと、県庁所在地マップビューに遷移します。

<img src="https://github.com/Taichone/yumemi-ios-junior-engineer-codecheck-app/assets/86025871/738a5624-6947-492a-80c3-fe767cb01770" width="300">

### 県庁所在地マップビュー
占い結果の都道府県庁所在地を初期位置とした、マップビューです。その都道府県がどのあたりに位置し、どのような地形をしているのか、すぐにご確認いただけます。

<img src="https://github.com/Taichone/yumemi-ios-junior-engineer-codecheck-app/assets/86025871/4a2329f4-0149-4f7c-be8b-4ac854446260" width="300">

### 占い結果の履歴画面
任意の都道府県の名前のセルをタップすると、その都道府県が占われたときと同様の画面に遷移します。

<img src="https://github.com/Taichone/yumemi-ios-junior-engineer-codecheck-app/assets/86025871/4779540d-098e-4809-817a-d91d418b9d18" width="300">

## 開発環境

### 主なライブラリ・フレームワーク
- SwiftUI
- Combine
- SwiftData

### 使用した外部ライブラリ
- Alamofire
  - Swift Package Manager によりインストール
 
### 環境
- Xcode 15.3
- iOS 17.4
- iPadOS 17.4
