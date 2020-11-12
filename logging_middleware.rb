class LoggingMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    before = Time.now.to_i
    status, headers, body = @app.call(env)
    after = Time.now.to_i
    puts "[#{self.class}] Duration #{after - before}s\n"

    [status, headers, body]
  end
end

