class AddCalDateToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :cal_date, :date
  end
end
