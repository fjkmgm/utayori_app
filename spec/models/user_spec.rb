require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "name、email、password、password_confirmationがあれば有効であること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nameが空の場合は無効であること" do
      user = build(:user, name: nil)
      expect(user).to be_invalid
    end

    it "emailが空の場合は無効であること" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
    end

    it "重複したemailの場合は無効であること" do
      create(:user, email: "duplicate@example.com")
      user = build(:user, email: "duplicate@example.com")
      expect(user).to be_invalid
    end

    it "passwordが3文字未満の場合は無効であること" do
      user = build(:user, password: "ab", password_confirmation: "ab")
      expect(user).to be_invalid
    end

    it "passwordとpassword_confirmationが一致しない場合は無効であること" do
      user = build(:user, password: "password", password_confirmation: "different")
      expect(user).to be_invalid
    end

    it "password_confirmationが空の場合は無効であること" do
      user = build(:user, password_confirmation: nil)
      expect(user).to be_invalid
    end
  end

  describe "アソシエーション" do
    it "ユーザーを削除すると紐づく日記も削除されること" do
      user = create(:user)
      create(:diary, user: user)
      expect { user.destroy }.to change(Diary, :count).by(-1)
    end
  end
end
