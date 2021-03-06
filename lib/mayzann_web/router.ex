defmodule MayzannWeb.Router do
  use MayzannWeb, :router

  pipeline :browser do
    plug CORSPlug, origin: "http://localhost:3006"
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MayzannWeb.Plugs.SetUser
  end

  pipeline :api do
    plug CORSPlug, origin: "http://localhost:3006"
    plug :accepts, ["json"]
  end

  scope "/", MayzannWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # get "/index", PostController, :index

    # get "/detail/:id", PostController, :detail

    # get "/new", PostCsontroller, :new
    # post "/post", PostController, :create
    # get "/edit", PostController, :edit
    get "/new", PostController, :new
    post "/post", PostController, :create
    get "/github_login", AuthController, :gg
  end

  scope "/auth", MayzannWeb do
    pipe_through :browser
    
    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback

  end

  # Other scopes may use custom stacks.
  scope "/api", MayzannWeb do
    pipe_through :api
    get "/", PostController, :index
    get "/posts", PostController, :index
    #get "/new", PostController, :new
    post "/upload", PostController, :create
    get "/post/:id", PostController, :detail
    delete "/post/:id", PostController, :delete
    # put "/post/:id", PostController, :update

    resources "/users", UserController, only: [:show]    
    post "/github_login", AuthController, :gg
  end

  # scope "/", MayzannWeb do
  #   pipe_through :browser
  #   get "/*path", PageController, :index
  # end

end
