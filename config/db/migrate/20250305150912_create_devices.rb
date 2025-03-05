# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :devices do
      primary_key :id
      column :friendly_id, :string
      column :label, :string
      column :mac_address, :string
      column :api_key, :string
      column :firmware_version, :string
      column :firmware_beta, :boolean, null: false, default: false
      column :rssi, :integer, null: false, default: 0
      column :battery_voltage, :float, null: false, default: 0
      column :refresh_rate, :integer, null: false, default: 900
      column :setup_at, :timestamp
      column :created_at, :timestamp, null: false, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at, :timestamp, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
