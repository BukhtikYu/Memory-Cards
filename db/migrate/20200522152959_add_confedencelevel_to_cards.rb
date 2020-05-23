class AddConfedencelevelToCards < ActiveRecord::Migration[6.0]
  def change
  	add_column :cards, :confidence_level, :integer, default: 0
  end
end
