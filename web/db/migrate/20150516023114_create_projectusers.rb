class CreateProjectusers < ActiveRecord::Migration
  def change
    create_table :projectusers do |t|
      t.string :name
      t.string :password
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :projectusers, :projects
  end
end
