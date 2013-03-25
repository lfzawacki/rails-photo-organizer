class CreateTags < ActiveRecord::Migration
  def change
    create_table :categories_images do |t|
      t.references :image
      t.references :category

      # t.timestamps
    end
    add_index :categories_images, :image_id
    add_index :categories_images, :category_id
  end
end
