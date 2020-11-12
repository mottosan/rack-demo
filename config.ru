require "rack"
require_relative "./application"
require_relative "./logging_middleware"
require_relative "./caching_middleware"

app = Rack::Builder.new do |builder|
  builder.use LoggingMiddleware
  builder.use CachingMiddleware
  builder.run APP
end

Rack::Handler::WEBrick.run app
