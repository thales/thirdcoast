xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
 xml.channel do
   xml.title @title
   xml.link @url_link
   xml.description @description

   @features.each do |feature|
     xml.item do
       xml.title       feature.title
       xml.link        player_url(feature)
       xml.pubDate     feature.created_at.to_s(:rfc822)
       xml.description Sanitize.clean(feature.description)
       xml.guid        player_url(feature)
     end
   end

 end
end