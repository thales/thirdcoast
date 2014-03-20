Factory.define :audio_file do |audio_file|
  audio_file.downloadable true
  audio_file.mp3_file_name 'MyText.mp3'
  audio_file.feature {|a| a.association(:feature)}
end