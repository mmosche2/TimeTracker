class AddProjectToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :project, :string
  end
end
