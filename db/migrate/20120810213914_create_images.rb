class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.string :md5
      t.date :taken_at

      t.timestamps
    end
  end
end
