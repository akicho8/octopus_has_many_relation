class CreateUsers < ActiveRecord::Migration
  using(:master, :blue, :green)

  def change
    create_table :users do |t|
      t.string :name
    end
  end
end
