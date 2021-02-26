require 'rails_helper'

RSpec.describe "コメント", type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
    @comment = FactoryBot.build(:comment)
  end
  context "コメントできるとき" do
    it "ログインしたユーザーは詳細ページに遷移してコメント投稿欄に入力するとコメントできる" do
      # ログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @tweet.user.email
      fill_in 'user_password', with: @tweet.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @tweetのツイートにリンクがある
      expect(page).to have_link href: tweet_path(@tweet)
      # @tweetのツイート詳細ページに移動する
      visit tweet_path(@tweet)
      # コメント用のフォームがある
      expect(page).to have_selector 'form'
      # フォームに入力する
      fill_in 'comment_comment', with: @comment.comment
      # SENDボタンを押す
      find('input[name="commit"]').click
      # ツイート詳細ページにリダイレクトされる
      expect(current_path).to eq tweet_path(@tweet)
      # 先程投稿したコメントがある
      expect(page).to have_content @comment.comment
    end
    it "ログインしていないユーザーはコメント欄が表示されない" do
      # トップページへ移動する
      visit root_path
      # @tweetのツイートにリンクがある
      expect(page).to have_link href: tweet_path(@tweet)
      # @tweetのツイート詳細ページに移動する
      visit tweet_path(@tweet)
      # コメント用のフォームがない
      expect(page).to have_no_selector 'form'
    end
  end
end