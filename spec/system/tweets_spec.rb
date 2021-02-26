require 'rails_helper'

RSpec.describe "ツイート投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.build(:tweet)
  end
  context "ツイートできるとき" do
    it "ログインしたユーザーはツイートできる" do
      # ログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ユーザー名をクリックするとツイートボタンがある
      find('.user-btn').click
      expect(page).to have_content("ツイート")
      # ツイートページに移動する
      visit new_tweet_path
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # フォームに情報を記入する
      fill_in 'tweet_content', with: @tweet.content
      attach_file('tweet[image]', image_path, make_visible: true)
      # 投稿ボタンを押す
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # 先程投稿した内容のツイートが存在している（本文）
      expect(page).to have_content(@tweet.content)
      # 先程投稿した内容のツイートが存在している（画像）
      expect(page).to have_selector('img')
    end
    context "ツイートできないとき" do
      it "ログインしていないとツイートページに移動できない" do
        # トップページに遷移する
        visit root_path
        # ツイートページへのリンクがない
        expect(page).to have_no_content('ツイート')
      end
    end
  end
end

RSpec.describe "ツイート削除", type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context "ツイート削除ができるとき" do
    it 'ログインしたユーザーは自分が投稿したツイートの削除ができる' do
      # ＠tweet1のユーザーでログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @tweet1.user.email
      fill_in 'user_password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ユーザー名をクリックするとマイページボタンがある
      find('.user-btn').click
      expect(page).to have_content("マイページ")
      # ユーザー詳細ページに移動する
      visit user_path(@tweet1.user)
      # ツイートに削除ボタンがあることを確認する
      expect(page).to have_link "削除する", href: tweet_path(@tweet1)
      # 投稿を削除するとレコードの数が1つ減る
      expect{
        find_link('削除する', href: tweet_path(@tweet1)).click
        expect(page.accept_confirm).to eq "ツイートを削除してもよろしいですか？"
        sleep 0.5
      }.to change { Tweet.count }.by(-1)
      # マイページに遷移する
      expect(current_path).to eq(user_path(@tweet1.user))
    end
  end
  context "ツイート削除ができないとき" do
    it "ログインしたユーザーは自分以外が投稿したツイートの削除ができない" do
      # ＠tweet1のユーザーでログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @tweet1.user.email
      fill_in 'user_password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @tweet2のユーザー名がある
      expect(page).to have_content(@tweet2.user.nickname)
      # @tweet2のユーザー詳細ページに移動する
      visit user_path(@tweet2.user)
      # ツイート2に削除ボタンがない
      expect(page).to have_no_link '削除する', href: tweet_path(@tweet1)
    end
    it 'ログインしていないと削除ボタンがない' do
      # トップページへ移動する
      visit root_path
      # @tweet2のユーザー名がある
      expect(page).to have_content(@tweet2.user.nickname)
      # @tweet2のユーザー詳細ページに移動する
      visit user_path(@tweet2.user)
      # ツイート2に削除ボタンがない
      expect(page).to have_no_link '削除する', href: tweet_path(@tweet1)
    end
  end
end