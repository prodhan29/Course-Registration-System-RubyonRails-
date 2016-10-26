class AddCreditToCourses < ActiveRecord::Migration[5.0]

  def up
    add_column :courses, :credit, :string
  end

  def down
    remove_column :courses, :credit
  end
end
