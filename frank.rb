class Frank
  def initialize(&block)
    @routes = RouteTable.new(&block)
  end

  def call(env)
    request = Rack::Request.new(env)

    @routes.each do |route|
      content = route.match(request)

      return [200, { "Content-Type" => "text/plain" }, [content.to_s]] if content
    end
    [404, {}, ["route #{request.path} not found"]]
  end
end

class RouteTable
  def initialize(&block)
    @routes = []
    instance_eval(&block)
  end

  def get(path, &block)
    add_route("get", path, block)
  end

  def post(path, &block)
    add_route("post", path, block)
  end

  def put(path, &block)
    add_route("put", path, block)
  end

  def delete(path, &block)
    add_route("delete", path, block)
  end

  def each(&block)
    @routes.each(&block)
  end

  private

  def add_route(method, path, block)
    @routes << Route.new(method, path, block)
  end
end

class Route < Struct.new(:method, :path, :block)
  def match(request)
    route_path_components = path.split("/")
    request_path_components = request.path.split("/")

    return nil unless route_path_components.length == request_path_components.length
    return nil unless request.request_method.downcase == method.downcase

    params = {}

    route_path_components.zip(request_path_components) do |route_component, path_component|
      is_var = route_component.start_with?(":")

      if is_var
        key = route_component.sub(%r{\A:}, "")
        params[key] = path_component
      elsif request.request_method == "POST" || request.request_method == "PUT"
        params.merge!(request.params)
      else
        return nil unless route_component == path_component
      end
    end
    block.call(params)
  end
end
