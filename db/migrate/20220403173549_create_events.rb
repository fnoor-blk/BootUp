class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :when
      t.datetime :till
      t.boolean :open
      t.timestamps
    end
  end
end
