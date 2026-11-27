require "rails_helper"

RSpec.describe Diary, type: :model do
  describe "バリデーション" do
    it "title、body、written_on、userがあれば有効であること" do
      diary = build(:diary)
      expect(diary).to be_valid
    end

    it "poemが未設定でも有効であること" do
      diary = build(:diary, poem: nil)
      expect(diary).to be_valid
    end

    it "titleが空の場合は無効であること" do
      diary = build(:diary, title: nil)
      expect(diary).to be_invalid
    end

    it "titleが256文字以上の場合は無効であること" do
      diary = build(:diary, title: "a" * 256)
      expect(diary).to be_invalid
    end

    it "bodyが空の場合は無効であること" do
      diary = build(:diary, body: nil)
      expect(diary).to be_invalid
    end

    it "written_onが空の場合は無効であること" do
      diary = build(:diary, written_on: nil)
      expect(diary).to be_invalid
    end

    it "userが紐づいていない場合は無効であること" do
      diary = build(:diary, user: nil)
      expect(diary).to be_invalid
    end
  end

  describe "和歌の自動マッチング（before_save :match_poem）" do
    let!(:kw_autumn) { Keyword.create!(name: "秋") }
    let!(:kw_moon) { Keyword.create!(name: "月") }
    let!(:poem1) { create(:poem, number: 1, poet: "天智天皇") }
    let!(:poem2) { create(:poem, number: 23, poet: "大江千里") }

    before do
      poem1.keywords << kw_autumn
      poem2.keywords << [ kw_autumn, kw_moon ]
    end

    it "タイトルや本文に含まれるキーワードが最も多い和歌が自動で紐づくこと" do
      diary = create(:diary, title: "秋の夜長", body: "きれいな月が見えた。")
      expect(diary.poem).to eq poem2
    end

    it "一致するキーワードがない場合はpoemがnilのまま保存されること" do
      diary = create(:diary, title: "春の朝", body: "桜が咲いていた。")
      expect(diary.poem).to be_nil
    end
  end
end
