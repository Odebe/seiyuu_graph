# frozen_string_literal: true

def run_migrations(config)
  config.default.create_table(:graphs) do
    primary_key :id
    string :title, null: false
    string :state, null: false
    date :created_at, null: false
  end
end
