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
      it "ageが全角では登録できない" do
        @user.age = "１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include("Age is not a number")
      end
      it "ageが英数字混合では登録できない" do
        @user.age = "12cfg"
        @user.valid?
        expect(@user.errors.full_messages).to include("Age is not a number")
      end
      it "heightが空では登録できない" do
        @user.height = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Height can't be blank")
      end
      it "heightが全角では登録できない" do
        @user.height = "１１２"
        @user.valid?
        expect(@user.errors.full_messages).to include("Height is not a number")
      end
      it "heightが英数字混合では登録できない" do
        @user.height = "cccdg123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Height is not a number")
      end
      it "weightが空では登録できない" do
        @user.weight = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Weight can't be blank")
      end
      it "weightが全角では登録できない" do
        @user.weight = "１２３４"
        @user.valid?
        expect(@user.errors.full_messages).to include("Weight is not a number")
      end
      it "weightが英数字混合では登録できない" do
        @user.weight = "ffgfds234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Weight is not a number")
      end
      it "bmrが空では登録できない" do
        @user.bmr = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Bmr can't be blank")
      end
      it "bmrが全角では登録できない" do
        @user.bmr = "１２３４"
        @user.valid?
        expect(@user.errors.full_messages).to include("Bmr is not a number")
      end
      it "bmrが英数字混合では登録できない" do
        @user.bmr = "dc25f"
        @user.valid?
        expect(@user.errors.full_messages).to include("Bmr is not a number")
      end
    end
  end
end
