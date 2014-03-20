class AddAdditionalFieldsToFeatures < ActiveRecord::Migration
  def self.up
    add_column    :features,                  :origin_country,          :string
    add_column    :features,                  :premier_locaction,       :string
    add_column    :features,                  :premier_date,            :date
    add_column    :features,                  :behind_the_scene_text,   :text
  end

  def self.down
  end
end
