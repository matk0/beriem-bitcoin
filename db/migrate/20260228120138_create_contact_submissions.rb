class CreateContactSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :contact_submissions do |t|
      t.string :sender_name, null: false
      t.string :sender_email, null: false
      t.text :message, null: false
      t.references :expert, null: true, foreign_key: true
      t.string :status, default: "new"

      t.timestamps
    end
  end
end
