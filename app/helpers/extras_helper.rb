module ExtrasHelper

  def formatted_mp3_filename(fname)
    fname.chomp(File.extname(fname))
    fname.tr('_', ' ')
  end
end
