require "./frank"
require "./user"

APP = Frank.new do
  # GET /
  get "/" do |params|
    sleep rand(3)
    respond_with "This is the root path"
  end

  # GET /users
  get "/users" do |params|
    sleep rand(3)
    respond_with User.find_all
  end

  # GET /users/0
  get "/users/:user_id" do |params|
    sleep rand(5)
    respond_with User.find_by_id(params.fetch("user_id"))
  rescue ObjectNotFound => e
    respond_with e.message, status: 404
  rescue => e
    respond_with e.message, status: 500
  end

  # POST /users
  post "/users" do |params|
    respond_with User.create(params), status: 201
  rescue => e
    respond_with e.message, status: 400
  end

  # PUT /users/1
  put "/users/:user_id" do |params|
    respond_with User.update(params.fetch("user_id"), params)
  rescue ObjectNotFound => e
    respond_with e.message, status: 404
  rescue => e
    respond_with e.message, status: 500
  end

  # DELETE /users/1
  delete "/users/:user_id" do |params|
    respond_with User.delete(params.fetch("user_id"))
  rescue ObjectNotFound => e
    respond_with e.message, status: 404
  rescue => e
    respond_with e.message, status: 500
  end
end
