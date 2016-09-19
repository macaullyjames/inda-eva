class CreateRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :repos do |t|
      t.string :org
      t.string :name

      t.timestamps
    end
  end
end
