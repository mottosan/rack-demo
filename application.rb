require "./frank"
require "./user"

APP = Frank.new do
  # GET /
  get "/" do |params|
    "This is the root path"
  end

  # GET /users
  get "/users" do |params|
    User.find_all
  end

  # GET /users/0
  get "/users/:user_id" do |params|
    User.find_by_id(params.fetch("user_id"))
  rescue => e
    e.message
  end

  # POST /users
  post "/users" do |params|
    User.create(params)
  rescue => e
    e.message
  end

  # PUT /users/1
  put "/users/:user_id" do |params|
    User.update(params.fetch("user_id"), params)
  rescue => e
    e.message
  end

  # DELETE /users/1
  delete "/users/:user_id" do |params|
    User.delete(params.fetch("user_id"))
  rescue => e
    e.message
  end
end
