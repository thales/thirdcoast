class CreateSideBarTiles < ActiveRecord::Migration
	def self.up
		create_table :side_bar_tiles do |t|
		t.string :title
		t.tinyint :deleted
		t.tinyint :displayed
		t.string :file_file_name
		t.string :file_content_type
		t.string :file_file_size
		t.datetime :file_updated_at
		t.string :link
		t.datetime :created_at
		t.datetime :updated_at

		t.timestamps
		end
	end

	def self.down
		drop_table :side_bar_tiles
	end
end
