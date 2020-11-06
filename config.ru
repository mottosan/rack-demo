require "rack"
require_relative "./application"

app = Application.new

use Rack::Reloader
use LoggingMiddleware
Rack::Handler::WEBrick.run LoggingMiddleware.new(app)
