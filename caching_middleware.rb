class CachingMiddleware
  CACHE = {}

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)

    if req.get?
      if cached_body = CACHE[req.path]
        puts "[#{self.class}] Cache hit"
        status, headers, body = *cached_body
      else
        puts "[#{self.class}] Cache miss"
        status, headers, body = @app.call(env)

        if status.to_s =~ /20[01]/
          CACHE[req.path] = [status, headers, body]
        else
          puts "[#{self.class}] 2xx status - not caching"
        end
      end
      return [status, headers, body]
    else
      @app.call(env)
    end
  end
end
