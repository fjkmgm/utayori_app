require "rails_helper"

RSpec.describe "ユーザー登録〜日記投稿〜和歌表示の操作フロー", type: :system do
  let!(:kw_autumn) { Keyword.create!(name: "秋") }
  let!(:kw_moon) { Keyword.create!(name: "月") }
  let!(:poem) do
    create(
      :poem,
      number: 23,
      poet: "大江千里",
      kami_no_ku: "月見れば ちぢにものこそ 悲しけれ",
      shimo_no_ku: "わが身ひとつの 秋にはあらねど",
      translation: "月を見ると、あれこれと無性に悲しくなってしまうことだ。",
      explanation: "秋の夜の月を見て物思いにふける心情を詠んだ一首です。"
    )
  end

  before do
    poem.keywords << [ kw_autumn, kw_moon ]
  end

  describe "ユーザー登録" do
    it "必要な情報を入力して新規ユーザー登録ができること" do
      visit new_user_path

      fill_in "名前", with: "歌詠み花子"
      fill_in "メールアドレス", with: "hanako@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード確認", with: "password"

      expect {
        click_button "登録"
      }.to change(User, :count).by(1)

      expect(page).to have_current_path(root_path).or have_current_path(diaries_path).or have_current_path(login_path)
    end
  end

  describe "ログイン〜日記投稿〜和歌マッチング・表示" do
    let!(:user) { create(:user, email: "test@example.com", password: "password", password_confirmation: "password") }

    it "ログイン後に日記を投稿すると、キーワードに一致した和歌が詳細画面に表示されること" do
      # 1. ログイン
      visit login_path
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"

      # 2. 日記新規作成画面へ移動して投稿
      visit new_diary_path
      fill_in "日付", with: Date.new(2026, 11, 27)
      fill_in "タイトル", with: "秋の夜長に月を見上げる"
      fill_in "本文", with: "静かな秋の夜、窓からきれいな月が見えて心が落ち着いた。"
      click_button "投稿する"

      # 3. 投稿した日記と自動マッチングされた和歌が表示されることを確認
      expect(page).to have_content("秋の夜長に月を見上げる")
      expect(page).to have_content("静かな秋の夜、窓からきれいな月が見えて心が落ち着いた。")
      expect(page).to have_content("今日の一首")
      expect(page).to have_content("第23首 ・ 大江千里")
      expect(page).to have_content("月見れば ちぢにものこそ 悲しけれ")
      expect(page).to have_content("わが身ひとつの 秋にはあらねど")
      expect(page).to have_content("現代語訳")
      expect(page).to have_content("解説")
    end
  end

  describe "認証によるアクセス制限" do
    it "未ログイン状態では日記投稿画面にアクセスできずログイン画面にリダイレクトされること" do
      visit new_diary_path
      expect(page).to have_current_path(root_path)
    end
  end
end
