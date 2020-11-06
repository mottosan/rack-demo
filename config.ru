require "rack"
require_relative "./application"

app = Rack::Builder.new do
  use Rack::Reloader, 0    
  run APP
end

Rack::Handler::WEBrick.run app
