require "rack"

app = -> (env) do
  [200, { "Content-Type" => "text/plain" }, ["Hello World!"]]
end

use Rack::Reloader
Rack::Handler::WEBrick.run app
