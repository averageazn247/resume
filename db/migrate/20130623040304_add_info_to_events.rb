class AddInfoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :dayof, :date
    add_column :events, :description, :text  
    add_column :events, :creator, :string
    
  end
end
