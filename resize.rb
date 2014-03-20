#!/usr/bin/env ruby

# A simple ruby rmagick resize script.
#
# Example: ./resize.rb /user/joe/mypics 400 533
#
# Searches /user/joe/mypics recursively for all files ending with 'jpg'; the search is case
# insensitive. The found image will be proprtinaly scaled to a max width of 400 pixels and 
# a max height of 533 pixels. The resized image will be written to a new file with the 
# extension 'preview.jpg'
#
# Thats all!

require 'find'
require 'RMagick'
include Magick


#if ARGV.length == 0
  # puts "Usage: resize.rb /path/to/directory maxwidth maxheight"
  #exit 0
#end


@features = Feature.published.all 

@features.each do |feature|
  puts feature.primary_image(:original)
  original = Magick::Image.read(feature.primary_image(:original)).first
  resized = original.resize_to_fit(Feature[1].to_i, Feature[2].to_i)
end


# Find.find(ARGV[0]) do |f|
#   if File.fnmatch('*.jpg', f, File::FNM_CASEFOLD)
#      target = f.to_s.gsub(/([jJ][pP][gG])/,"preview.#{$1}")

#     if not File.exists?(target)
#       puts "Resize #{f}"
#       original = Magick::Image.read(f).first
#       resized = original.resize_to_fit(ARGV[1].to_i, ARGV[2].to_i)
#       puts "Write #{target}"
#       resized.write(target)
#       GC.start
#     else
#       puts "Skip #{f}"
#     end
#   end
# end