class AddPrioritizationToIssue < ActiveRecord::Migration
  def up
    add_column :issues, :prioritization, :integer, :default => 0
    add_index :issues, :prioritization
  end

  def down
    remove_column :issues, :prioritization, :integer
    remove_index :issues, :prioritization
  end
end
