class AddAffiliationAndCountryToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :affiliation, :string
    add_column :people, :country, :string
  end
end
