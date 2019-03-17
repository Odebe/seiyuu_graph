class CreateRawTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :raw_titles do |t|
      t.string :href
      t.integer :mal_id
      t.json :body

      t.timestamps
    end
  end
end
