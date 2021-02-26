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
        expect(@user.errors.full_messages).to include("Nicknameを入力してください")
      end
      it "nicknameが10文字以上では登録できない" do
        @user.nickname = "あああああああああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Nicknameは10文字以内で入力してください")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "ageが空では登録できない" do
        @user.age = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Ageを入力してください")
      end
      it "ageが全角では登録できない" do
        @user.age = "１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include("Ageは数値で入力してください")
      end
      it "ageが英数字混合では登録できない" do
        @user.age = "12cfg"
        @user.valid?
        expect(@user.errors.full_messages).to include("Ageは数値で入力してください")
      end
      it "ageが0では登録できない" do
        @user.age = 0
        @user.valid?
        expect(@user.errors.full_messages).to include("Ageは0以外の値にしてください")
      end
      it "heightが空では登録できない" do
        @user.height = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Heightを入力してください")
      end
      it "heightが全角では登録できない" do
        @user.height = "１１２"
        @user.valid?
        expect(@user.errors.full_messages).to include("Heightは数値で入力してください")
      end
      it "heightが英数字混合では登録できない" do
        @user.height = "cccdg123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Heightは数値で入力してください")
      end
      it "heightが0では登録できない" do
        @user.height = 0
        @user.valid?
        expect(@user.errors.full_messages).to include("Heightは0以外の値にしてください")
      end
      it "weightが空では登録できない" do
        @user.weight = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Weightを入力してください")
      end
      it "weightが全角では登録できない" do
        @user.weight = "１２３４"
        @user.valid?
        expect(@user.errors.full_messages).to include("Weightは数値で入力してください")
      end
      it "weightが英数字混合では登録できない" do
        @user.weight = "ffgfds234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Weightは数値で入力してください")
      end
      it "weightが0では登録できない" do
        @user.weight = 0
        @user.valid?
        expect(@user.errors.full_messages).to include("Weightは0以外の値にしてください")
      end
      it "gender_idが空では登録できない" do
        @user.gender_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Genderは数値で入力してください")
      end
      it "gender_idが0では登録できない" do
        @user.gender_id = 0
        @user.valid?
        expect(@user.errors.full_messages).to include("Genderは0以外の値にしてください")
      end
    end
  end
end
