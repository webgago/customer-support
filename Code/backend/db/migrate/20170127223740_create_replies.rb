class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.string :body
      t.belongs_to :ticket
      t.belongs_to :user

      t.timestamps
    end
  end
end
