class AddDeviceToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :ip_address, :string
    add_column :submissions, :app_version, :string
    add_column :submissions, :device_model, :string
    add_column :submissions, :system_version, :string
    add_column :submissions, :device_locale, :string
  end
end
