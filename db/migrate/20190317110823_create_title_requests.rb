class CreateTitleRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :title_requests do |t|
      t.integer :mal_id
      t.string :href
      t.references :graph_request, foreign_key: true

      t.timestamps
    end
  end
end
