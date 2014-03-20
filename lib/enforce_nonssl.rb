require 'rack/utils'
 
module Rack
  #
  # redirects SSL traffic to regular HTTP
  #
  class EnforceNonSSL
 
    include Rack::Utils

    def initialize(app)
      @app = app
    end
 
    def call(env)
      protocol = env['rack.url_scheme']
      uri = env['REQUEST_URI']
      
      unless protocol == 'http'
        path = env['PATH_INFO']
 
          return [
            307,
            {
              'Content-Type' => 'text/html',
              'Location' => "http://"+env["HTTP_HOST"]+uri
            },
            [%{<html>
  <head>
    <title>Non SSL Redirect</title>
  </head>
 
  <body>
    <h1>Non SSL Redirect</h1>
 
    <p>The requested path (#{escape_html(path)}) must be requested via non SSL. You are now being redirected to the non SSL encrypted path.</p>
  </body>
</html>}]
          ]
      else
        @app.call(env)
      end
    end
 
  end
end