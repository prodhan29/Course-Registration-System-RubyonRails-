class CreateRegdetails < ActiveRecord::Migration[5.0]
  def change
    create_table :regdetails do |t|
      t.references :user, foreign_key: true
      t.references :semester, foreign_key: true
      t.integer :course
      t.string :cgpa

      t.timestamps
    end
  end
end
