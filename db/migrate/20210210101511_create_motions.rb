class CreateMotions < ActiveRecord::Migration[6.0]
  def change
    create_table :motions do |t|
      t.integer    :run,      null: false, default: "0"
      t.integer    :abs,      null: false, default: "0"
      t.integer    :squat,    null: false, default: "0"
      t.integer    :push_ups, null: false, default: "0"
      t.integer    :spine,    null: false, default: "0"
      t.references :user,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
