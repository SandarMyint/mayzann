defmodule MayzannWeb.Router do
  use MayzannWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MayzannWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MayzannWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", MayzannWeb do
    pipe_through :browser
    
    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", MayzannWeb do
  #   pipe_through :api
  # end
end
