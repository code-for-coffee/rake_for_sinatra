class CreateKittens < ActiveRecord::Migration
  def change
    create_table :kittens do |table|
      table.text :name
      table.integer :age
      table.float :number_of_catnips
      table.text :favourite_hooman
      table.boolean :is_alive
      table.text :favourite_food
    end
  end
end
