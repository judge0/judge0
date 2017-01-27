class CreateLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :compile_cmd
      t.string :run_cmd
    end
  end
end
