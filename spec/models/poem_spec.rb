require "rails_helper"

RSpec.describe Poem, type: :model do
  describe "バリデーション" do
    it "必須項目がすべて揃っていれば有効であること" do
      poem = build(:poem)
      expect(poem).to be_valid
    end

    it "numberが空の場合は無効であること" do
      poem = build(:poem, number: nil)
      expect(poem).to be_invalid
    end

    it "重複したnumberの場合は無効であること" do
      create(:poem, number: 1)
      poem = build(:poem, number: 1)
      expect(poem).to be_invalid
    end

    it "kami_no_kuが空の場合は無効であること" do
      poem = build(:poem, kami_no_ku: nil)
      expect(poem).to be_invalid
    end

    it "shimo_no_kuが空の場合は無効であること" do
      poem = build(:poem, shimo_no_ku: nil)
      expect(poem).to be_invalid
    end

    it "poetが空の場合は無効であること" do
      poem = build(:poem, poet: nil)
      expect(poem).to be_invalid
    end

    it "translationが空の場合は無効であること" do
      poem = build(:poem, translation: nil)
      expect(poem).to be_invalid
    end

    it "explanationが空の場合は無効であること" do
      poem = build(:poem, explanation: nil)
      expect(poem).to be_invalid
    end
  end

  describe "アソシエーション" do
    it "和歌を削除しても紐づく日記は削除されずpoem_idがnilになること" do
      poem = create(:poem)
      diary = create(:diary, poem: poem)
      expect { poem.destroy }.not_to change(Diary, :count)
      expect(diary.reload.poem_id).to be_nil
    end
  end

  describe ".search" do
    let!(:kw_love) { Keyword.create!(name: "恋") }
    let!(:poem1) { create(:poem, number: 1, poet: "天智天皇", kami_no_ku: "秋の田の") }
    let!(:poem9) { create(:poem, number: 9, poet: "小野小町", kami_no_ku: "花の色は") }

    before do
      poem9.keywords << kw_love
    end

    it "歌番号で検索できること" do
      expect(Poem.search("1")).to contain_exactly(poem1)
    end

    it "歌人名で検索できること" do
      expect(Poem.search("小野小町")).to contain_exactly(poem9)
    end

    it "キーワード名で検索できること" do
      expect(Poem.search("恋")).to contain_exactly(poem9)
    end
  end
end
