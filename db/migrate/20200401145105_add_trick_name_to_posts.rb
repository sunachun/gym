class AddTrickNameToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :trick_name, :string
  end
end
