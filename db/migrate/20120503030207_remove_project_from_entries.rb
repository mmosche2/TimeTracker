class RemoveProjectFromEntries < ActiveRecord::Migration
  def up
    remove_column :entries, :project
  end

  def down
    add_column :entries, :project, :string
  end
end
