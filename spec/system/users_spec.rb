require 'rails_helper'

RSpec.describe "サインイン", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context "ユーザー新規登録ができるとき" do
    it "正しい情報を入力すればユーザー新規登録ができてトップページへ遷移する" do
      # トップページへ移動する
      visit root_path
      # ページ内に新規登録ボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      fill_in 'user_nickname', with: @user.nickname
      select '男', from: 'user[gender_id]'
      fill_in 'user_age', with: @user.age
      fill_in 'user_height', with: @user.height
      fill_in 'user_weight', with: @user.weight
      fill_in 'user_introduction', with: @user.introduction
      # 登録ボタンを押す
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # ユーザー名をクリックするとログアウトボタンが表示される
      find('.user-btn').click
      expect(page).to have_content('ログアウト')
      # ログインボタンや新規登録ボタンがないことを確認する
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end
  context "ユーザー新規登録できないとき" do
    it "誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる" do
      # トップページへ移動する
      visit root_path
      # ページ内に新規登録ボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      fill_in 'user_nickname', with: ''
      fill_in 'user_age', with: ''
      fill_in 'user_height', with: ''
      fill_in 'user_weight', with: ''
      fill_in 'user_introduction', with: ''
      # 登録ボタンを押す
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context "ログインできるとき" do
    it "保存されているユーザーの情報と合致すればログインできる" do
      # トップページへ移動する
      visit root_path
      # ページ内にログインボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # ユーザー名をクリックするとログアウトボタンが表示される
      find('.user-btn').click
      expect(page).to have_content('ログアウト')
      # ログインボタンや新規登録ボタンがないことを確認する
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end
  context "ログインできないとき" do
    it "保存されているユーザーの情報と合致しなければログインできない" do
      # トップページへ移動する
      visit root_path
      # ページ内にログインボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe "ユーザー情報編集", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end
  context "編集できるとき" do
    it "ログインしているユーザーは自分のアカウントを編集できる" do
      # トップページへ移動する
      visit root_path
      # ページ内にログインボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: @user1.email
      fill_in 'user_password', with: @user1.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # ユーザー名をクリックするとマイページボタンが表示される
      find('.user-btn').click
      expect(page).to have_content('マイページ')
      # ユーザー詳細ページに移動する
      visit user_path(@user1)
      # ユーザー編集ページへのリンクがある
      expect(page).to have_link 'ユーザー情報を編集する', href: edit_user_registration_path
      # ユーザー編集ページへ移動する
      visit edit_user_registration_path(@user1)
      # すでにユーザー情報がフォームに入力されていることを確認する
      expect(
        find('#user_email').value
      ).to eq(@user1.email)
      expect(
        find('#user_nickname').value
      ).to eq(@user1.nickname)
      expect(
        find('#user_height').value
      ).to eq("#{@user1.height}")
      expect(
        find('#user_weight').value
      ).to eq("#{@user1.weight}")
      expect(
        find('#user_introduction').value
      ).to eq("#{@user1.introduction}")
      # ユーザー情報を編集する
      fill_in 'user_email', with: 'aa@com'
      fill_in 'user_nickname', with: 'KS'
      fill_in 'user_age', with: '42'
      fill_in 'user_height', with: '12'
      fill_in 'user_weight', with: '122'
      fill_in 'user_introduction', with: '1111312'
      # ユーザー情報を編集してもモデルのカウント数は変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # ユーザー詳細ページに移動する
      expect(current_path).to eq(user_path(@user1))
      # 編集した情報がある
      expect(page).to have_content('KS')
      expect(page).to have_content('42')
      expect(page).to have_content('12')
      expect(page).to have_content('122')
      expect(page).to have_content('1111312')
    end
    context "編集できない" do
      it "ログインしているユーザーは他のユーザーの情報を編集することができない" do
      # トップページへ移動する
      visit root_path
      # ページ内にログインボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: @user2.email
      fill_in 'user_password', with: @user2.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # ユーザー詳細ページに移動する
      visit user_path(@user1)
      # ユーザー情報編集ページへのリンクがない
      expect(page).to have_no_link "ユーザー情報を編集する", href: edit_user_registration_path
      end
      it "ログインしていないとアカウントを削除できない" do
        # ユーザー詳細ページに移動する
        visit user_path(@user1)
        # ユーザー情報編集ページへのリンクがない
        expect(page).to have_no_link "ユーザー情報を編集する", href: edit_user_registration_path
      end
    end
  end
end

RSpec.describe "ユーザー削除", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end
  context "アカウント削除ができるとき" do
    it "ログインしているユーザーは自分のアカウントを削除できる" do
      # トップページへ移動する
      visit root_path
      # ページ内にログインボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: @user1.email
      fill_in 'user_password', with: @user1.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # ユーザー名をクリックするとマイページボタンが表示される
      find('.user-btn').click
      expect(page).to have_content('マイページ')
      # ユーザー詳細ページに移動する
      visit user_path(@user1)
      # ユーザー編集ページへのリンクがある
      expect(page).to have_link 'ユーザー情報を編集する', href: edit_user_registration_path
      # ユーザー編集ページへ移動する
      visit edit_user_registration_path(@user1)
      # ユーザーを削除するとレコードの数が1つ減る
      expect{
        find_link('アカウントを削除する', href: user_registration_path).click
        expect(page.accept_confirm).to eq "ユーザー情報を削除してもよろしいですか？"
        sleep 0.5
      }.to change { User.count }.by(-1)
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
    end
  end
  context "アカウントが削除できないとき" do
    it "ログインしたユーザーは自分以外のアカウントを削除ができない" do
      # トップページへ移動する
      visit root_path
      # ページ内にログインボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: @user2.email
      fill_in 'user_password', with: @user2.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # ユーザー詳細ページに移動する
      visit user_path(@user1)
      # ユーザー情報編集ページへのリンクがない
      expect(page).to have_no_link "ユーザー情報を編集する", href: edit_user_registration_path
    end
    it "ログインしていないとアカウントを削除できない" do
      # ユーザー詳細ページに移動する
      visit user_path(@user1)
      # ユーザー情報編集ページへのリンクがない
      expect(page).to have_no_link "ユーザー情報を編集する", href: edit_user_registration_path
    end
  end
end
