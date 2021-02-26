require 'rails_helper'

RSpec.describe "トレーニング", type: :system do
  before do
    @motion = FactoryBot.create(:motion)
  end
  context "トレーニングを入力できるとき" do
    it "ログインしたユーザーはトレーニングを入力できる" do
      # ログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @motion.user.email
      fill_in 'user_password', with: @motion.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ユーザー名をクリックするとトレーニングボタンがある
      find('.user-btn').click
      expect(page).to have_content("トレーニング")
      # トレーニングページに移動する
      visit new_motion_path
      # フォームに入力する
      fill_in 'run', with: @motion.run
      fill_in 'abs', with: @motion.abs
      fill_in 'squat', with: @motion.squat
      fill_in 'push-ups', with: @motion.push_ups
      fill_in 'spine', with: @motion.spine
      # 入力完了ボタンを押すとモデルのカウントが１つ増える
      expect{
        find('input[name="commit"]').click
      }.to change { Motion.count }.by(1)
      # ユーザー詳細ページへ遷移する
      expect(current_path).to eq(user_path(@motion.user))
      # 先程入力した情報が表示されている
      expect(page).to have_content(@motion.run)
      expect(page).to have_content(@motion.abs)
      expect(page).to have_content(@motion.squat)
      expect(page).to have_content(@motion.push_ups)
      expect(page).to have_content(@motion.spine)
    end
  end
  context "トレーニングを入力できないとき" do
    it "ログインしていないユーザーはトレーニングボタンが表示されない" do
      expect(page).to have_no_content("トレーニング")
    end
  end
end

RSpec.describe "トレーニング編集", type: :system do
  before do
    @motion1 = FactoryBot.create(:motion)
    @motion2 = FactoryBot.create(:motion)
  end
  context "編集できるとき" do
    it "ログインしたユーザーは自分のトレーニング情報を編集することができる" do
      # ログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @motion1.user.email
      fill_in 'user_password', with: @motion1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ユーザー名をクリックするとマイページボタンがある
      find('.user-btn').click
      expect(page).to have_content("マイページ")
      # ユーザー詳細ページに移動する
      visit user_path(@motion1.user)
      # 詳細ボタンがあることを確認する
      expect(page).to have_link "詳細を見る", href: motion_path(@motion1)
      # 詳細ページへ移動する
      visit motion_path(@motion1)
      # 編集ボタンがあることを確認する
      expect(page).to have_link "修正をする", href: edit_motion_path(@motion1)
      # 編集ページへ移動する
      visit edit_motion_path(@motion1)
      # データが入力されていることを確認する
      expect(
        find('#run').value
      ).to eq("#{@motion1.run}")
      expect(
        find('#abs').value
      ).to eq("#{@motion1.abs}")
      expect(
        find('#squat').value
      ).to eq("#{@motion1.squat}")
      expect(
        find('#push-ups').value
      ).to eq("#{@motion1.push_ups}")
      expect(
        find('#spine').value
      ).to eq("#{@motion1.spine}")
      # トレーニング情報を編集する
      fill_in 'run', with: '12'
      fill_in 'abs', with: '13'
      fill_in 'squat', with: '14'
      fill_in 'push-ups', with: '15'
      fill_in 'spine', with: '16'
      # ユーザー情報を編集してもモデルのカウント数は変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { Motion.count }.by(0)
      # ユーザー詳細ページに移動する
      expect(current_path).to eq(motion_path(@motion1))
      # 編集した情報がある
      expect(page).to have_content('12')
      expect(page).to have_content('13')
      expect(page).to have_content('14')
      expect(page).to have_content('15')
      expect(page).to have_content('16')
    end
  end
  context "編集できない" do
    it "ログインしたユーザーは他人のトレーニング情報を編集することができない" do
      # ログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @motion2.user.email
      fill_in 'user_password', with: @motion2.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ユーザー詳細ページに移動する
      visit user_path(@motion1.user)
      # トレーニング情報編集ページへのリンクがない
      expect(page).to have_no_link "詳細を見る", href: motion_path(@motion1)
    end
    it "ログインしていないとトレーニング情報を編集できない" do
      # ユーザー詳細ページに移動する
      visit user_path(@motion1.user)
      # トレーニング情報編集ページへのリンクがない
      expect(page).to have_no_link "詳細を見る", href: motion_path(@motion1)
    end
  end
end

RSpec.describe "トレーニング削除", type: :system do
  before do
    @motion1 = FactoryBot.create(:motion)
    @motion2 = FactoryBot.create(:motion)
  end
  context "削除できるとき" do
    it "ログインしたユーザーは自分のトレーニング情報を削除することができる" do
      # ログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @motion1.user.email
      fill_in 'user_password', with: @motion1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ユーザー名をクリックするとマイページボタンがある
      find('.user-btn').click
      expect(page).to have_content("マイページ")
      # ユーザー詳細ページに移動する
      visit user_path(@motion1.user)
      # 詳細ボタンがあることを確認する
      expect(page).to have_link "詳細を見る", href: motion_path(@motion1)
      # 詳細ページへ移動する
      visit motion_path(@motion1)
      # 削除ボタンがあることを確認する
      expect(page).to have_link "削除する", href: motion_path(@motion1)
      # 削除ボタンを押してモデルのカウントが１つ減ることを確認する
      expect{
        find_link("削除する", href: motion_path(@motion1)).click
        expect(page.accept_confirm).to eq "この記録を削除してもよろしいですか？"
        sleep 0.5
      }.to change { Motion.count }.by(-1)
      # ユーザー詳細ページへ遷移する
      expect(current_path).to eq(user_path(@motion1.user))
    end
    it "ログインしていないとトレーニング情報を削除できない" do
      # ユーザー詳細ページに移動する
      visit user_path(@motion1.user)
      # トレーニング情報編集ページへのリンクがない
      expect(page).to have_no_link "詳細を見る", href: motion_path(@motion1)
    end
  end
end
