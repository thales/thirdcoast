module AudioFilesHelper

  def seconds_to_time seconds
    time = Time.at(seconds.to_i).gmtime.strftime("%R:%S")
    time2 = time.sub(/^[0:]*/,"")
  end
  
  def edit_link(audio_file_id)

  end


end
