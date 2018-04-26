class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :text
      t.references :reviewable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
