class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.string :email
      t.string :checkin
      t.string :checkout

      t.timestamps
    end
  end
end
