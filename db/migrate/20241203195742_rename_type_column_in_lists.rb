class RenameTypeColumnInLists < ActiveRecord::Migration[7.2]
  def change
    rename_column :lists, :type, :status
  end
end
