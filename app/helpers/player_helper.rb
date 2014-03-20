module PlayerHelper

  def server_path
    if RAILS_ENV == 'production' 
      return "http://3rdcoast-features.s3.amazonaws.com"
    else
      return "http://dev-3rdcoast-features.s3.amazonaws.com"
    end
  end

  def tags_separated(tags)   
    tags.collect{|u| u.name.tr('-', ' ')}.join(', ')   
  end



end
