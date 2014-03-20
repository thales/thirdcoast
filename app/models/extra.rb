class Extra < ActiveRecord::Base
  after_save :set_feature_delta_flag
  belongs_to  :feature
  has_many    :extra_audio_files, :dependent => :destroy

  private

  def set_feature_delta_flag
    feature.delta = true
    feature.save
  end
end
