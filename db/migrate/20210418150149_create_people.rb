class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
    end
  end
end
