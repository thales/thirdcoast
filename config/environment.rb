# Be sure to restart your server when you modify this file
require 'rubygems'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

if Gem::VERSION >= "1.3.6" 
  module Rails
    class GemDependency
      def requirement
        r = super
        (r == Gem::Requirement.default) ? nil : r
      end
    end
  end
end

RIGHT_IMAGES = Dir.new(RAILS_ROOT+'/public/images' ).entries.find_all{|e| e.match(/^rightimage_(.*)\.png/) }.map{|e|  e.match(/^rightimage_(.*)\.png/)[1] }

Rails::Initializer.run do |config|  
  config.gem "ruby-mp3info", :lib => "mp3info"
  config.gem 'mislav-will_paginate', :version => '~> 2.3.11', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem "acts_as_commentable"
  config.gem 'jackdempsey-acts_as_commentable', :lib => 'acts_as_commentable', :source => "http://gems.github.com"
  config.gem "ambethia-recaptcha", :lib => "recaptcha/rails", :source => "http://gems.github.com"
  config.gem "nokogiri"
  config.gem "htmlentities"
  #config.gem "factory_girl"
  config.gem "jammit"
  config.gem "acts_as_list"
  config.gem 'searchlogic'
  config.gem 'javan-whenever', :lib => false, :source => 'http://gems.github.com'
  config.gem 'rmagick', :lib => "RMagick"
  config.gem 'sanitize'
  config.gem 'mysql'
  
  config.time_zone = 'UTC'
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_charset = "utf-8"
  
  config.action_mailer.sendmail_settings = {
    :location       => '/usr/sbin/sendmail',
    :arguments      => '-i -t'
  }
  
  config.action_mailer.smtp_settings = {
    :address => "smtp.emailsrvr.com",
    :authentication => :cram_md5,
    :port => 465,
    :user_name => "clientsend@thisismess.com",
    :reply_to => "pidgey@thirdcoastfestival.org",
    :password => "1500mess"
  }
  
end

require 'thinking_sphinx/0.9.9'
ThinkingSphinx.suppress_delta_output = true

