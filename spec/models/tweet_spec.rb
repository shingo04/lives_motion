require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end
  describe "ツイート機能の実装" do
    context "ツイートできるとき" do
      it "全ての情報が正しく入力されているとツイートできる" do
        expect(@tweet).to be_valid
      end
      it "imageが空でもcontentがあればツイートできる" do
        @tweet.image = nil
        expect(@tweet).to be_valid
      end
      it "contentが空でもimageがあればツイートできる" do
        @tweet.content = ""
        expect(@tweet).to be_valid
      end
    end
    context "ツイートできないとき" do
      it "contentとimageが空のときツイートできない" do
        @tweet.content = ""
        @tweet.image = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Contentを入力してください")
      end
    end
  end
end
