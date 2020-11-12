require "./frank"
require "./user"

APP = Frank.new do
  # GET /
  get "/" do |params|
    sleep rand(3)
    [200, "This is the root path"]
  end

  # GET /users
  get "/users" do |params|
    sleep rand(3)
    [200, User.find_all]
  end

  # GET /users/0
  get "/users/:user_id" do |params|
    sleep rand(5)
    [200, User.find_by_id(params.fetch("user_id"))]
  rescue ObjectNotFound => e
    [404, e.message]
  rescue => e
    [500, e.message]
  end

  # POST /users
  post "/users" do |params|
    [201, User.create(params)]
  rescue => e
    [400, e.message]
  end

  # PUT /users/1
  put "/users/:user_id" do |params|
    [200, User.update(params.fetch("user_id"), params)]
  rescue ObjectNotFound => e
    [404, e.message]
  rescue => e
    [500, e.message]
  end

  # DELETE /users/1
  delete "/users/:user_id" do |params|
    [200, User.delete(params.fetch("user_id"))]
  rescue ObjectNotFound => e
    [404, e.message]
  rescue => e
    [500, e.message]
  end
end
