xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd" do
  xml.channel do
    xml.title "ThirdCoast podcast"
    xml.language "en-us"
    xml.copyright "Third Coast"
    xml.description "Our official podcast"
    xml.link "http://thirdcoastfestival.org/"
    xml.tag!("itunes:image", :href => "http://thirdcoastfestival.org/images/pigeonplaceholder.jpg")
    xml.tag!("itunes:category", :text => "Music")
    xml.itunes :author, "Third Coast Festival"
    xml.itunes :subtitle, "Our ofificial podcast subtitle"
    xml.itunes :owner do
      xml.itunes :name, "Third Coast"
      xml.itunes :email, "third@coast"
    end
    
    @podcast_items.each do |item|
      xml.item do
        xml.title item.title
        xml.description item.description
        xml.pubDate item.created_at.to_s(:rfc822)
        xml.link item.file.url(:original, false)
        xml.guid item.file.url(:original, false)
        xml.itunes :duration, toHHMMSS(item.duration)
        xml.itunes :author, "Author"
        xml.tag!(:enclosure, :url => item.file.url(:original, false), :length => item.file_file_size, :type => item.file_content_type)
      end
    end
  end
end

