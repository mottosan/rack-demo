require "rack"

class Application
  def call(env)
    [200, { "Content-Type" => "text/plain" }, ["Hello World!"]]
  end
end

use Rack::Reloader
Rack::Handler::WEBrick.run Application.new
