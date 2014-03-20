Factory.define :extra_audio_file do |extra_audio_file|
  extra_audio_file.name "my text"
  extra_audio_file.mp3_file_name 'MyText.mp3'
  extra_audio_file.extra {|a| a.association(:extra)}
end