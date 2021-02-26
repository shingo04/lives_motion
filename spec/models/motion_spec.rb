require 'rails_helper'

RSpec.describe Motion, type: :model do
  before do
    @motion = FactoryBot.build(:motion)
  end
  describe "トレーニング記録機能の実装" do
    context "記録を保存できる時" do
      it "全ての情報を正しく入力した時入力できる" do
        expect(@motion).to be_valid
      end
    end
    context "記録を保存できない時" do
      it "runが空のとき保存できない" do
        @motion.run = nil
        @motion.valid?
        expect(@motion.errors.full_messages).to include("Runを入力してください")
      end
      it "absが空のとき保存できない" do
        @motion.abs = nil
        @motion.valid?
        expect(@motion.errors.full_messages).to include("Absを入力してください")
      end
      it "squatが空のとき保存できない" do
        @motion.squat = nil
        @motion.valid?
        expect(@motion.errors.full_messages).to include("Squatを入力してください")
      end
      it "push_upsが空のとき保存できない" do
        @motion.push_ups = nil
        @motion.valid?
        expect(@motion.errors.full_messages).to include("Push upsを入力してください")
      end
      it "spineが空のとき保存できない" do
        @motion.spine = nil
        @motion.valid?
        expect(@motion.errors.full_messages).to include("Spineを入力してください")
      end
    end
  end
end
