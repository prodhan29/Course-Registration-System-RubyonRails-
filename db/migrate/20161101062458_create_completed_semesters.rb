class CreateCompletedSemesters < ActiveRecord::Migration[5.0]
  def up
    create_table :completed_semesters do |t|
      t.references :user, foreign_key: true
      t.references :semester, foreign_key: true
      t.string  :cgpa
      t.timestamps
    end
  end

  def down
    drop_table :completed_semesters
  end
end
