class AddDetailsToEntries < ActiveRecord::Migration
  def change
	add_column :entries, :hours, :decimal
	add_column :entries, :project_id, :integer
	rename_column :entries, :note, :tasks
  end
end
