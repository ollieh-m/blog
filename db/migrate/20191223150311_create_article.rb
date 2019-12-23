class CreateArticle < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
    	t.string :view_id
    	t.string :title

    	t.timestamps
    end

    add_index :articles, :view_id
  end
end
