class RemovePublicNameFromPeople < ActiveRecord::Migration[7.0]
  def change
    remove_column :people, :public_name, :string
  end
end
