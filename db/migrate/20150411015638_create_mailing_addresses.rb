class CreateMailingAddresses < ActiveRecord::Migration
  def change
    create_table :mailing_addresses do |t|
      t.string :name
      t.string :email
      t.boolean :subscribed

      t.timestamps null: false
    end
  end
end
