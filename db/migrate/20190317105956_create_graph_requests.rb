class CreateGraphRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :graph_requests do |t|

      t.timestamps
    end
  end
end
