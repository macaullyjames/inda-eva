class CreateChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :checks do |t|
      t.references :repo, foreign_key: true
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
