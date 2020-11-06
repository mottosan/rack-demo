require "./framework"

APP = Framework.new do
  # GET /
  get "/" do |params|
    "This is the root path"
  end

  # GET /users/morty
  # GET /users/matt
  get "/users/:username" do |params|
    "This is a user called #{params.fetch("username")}"
  end
end
