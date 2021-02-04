require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "ユーザー管理機能の実装" do
    context "新規登録できるとき" do
      it "全ての情報を正しく入力すると登録できる" do
        expect(@user).to be_valid
      end
      it "introductionが空白でも登録できる" do
        @user.introduction = ""
        expect(@user).to be_valid
      end
    end
    context "新規登録できないとき" do
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "ageが空では登録できない" do
        @user.age = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Age can't be blank")
      end
      it "heightが空では登録できない" do
        @user.height = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Height can't be blank")
      end
      it "weightが空では登録できない" do
        @user.weight = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Weight can't be blank")
      end
      it "bmrが空では登録できない" do
        @user.bmr = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Bmr can't be blank")
      end
    end
  end
end
