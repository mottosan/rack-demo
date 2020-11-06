class Application
  def call(env)
    [200, { "Content-Type" => "text/plain" }, ["Hello World!\n"]]
  end
end

class LoggingMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    before = Time.now.to_i
    status, headers, body = @app.call(env)
    after = Time.now.to_i
    log_message = "App took #{after - before} seconds.\n"

    [status, headers, body << log_message]
  end
end

