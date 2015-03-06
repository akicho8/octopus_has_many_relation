class CreateArticles < ActiveRecord::Migration
  using(:master, :blue, :green)

  def change
    create_table :articles do |t|
      t.belongs_to :user
      t.string :name
    end
  end
end
