class AddAddressToCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :address, :text
    add_column :companies, :gst_number, :string, limit: 25
  end
end
