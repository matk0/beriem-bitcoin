class CreateExperts < ActiveRecord::Migration[8.0]
  def change
    create_table :experts do |t|
      t.string :name, null: false
      t.string :city, null: false
      t.text :bio
      t.string :email, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
