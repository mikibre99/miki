defmodule BlogWeb.PageController do
  use BlogWeb, :controller
  alias Blog.RepoFunctions
  alias Blog.Models.Posts

  def index(conn, _params) do
    posts = Blog.RepoFunctions.get_posts()

    render(conn, "index.html", posts: posts)
  end
  def show(conn, %{"id" => id}) do
    post = Blog.RepoFunctions.get_post(id)
    conn = update_counter(conn, post)
    render(conn, "show.html", post: post)
  end
  def update_counter(conn, post) do
    case Plug.Conn.get_session(conn, :counted) do
      nil ->
        Blog.RepoFunctions.update_counter(post)
        Plug.Conn.put_session(conn, :counted, [post.id])
      list ->
        case Enum.any?(list, fn x -> x == post.id end) do
          false ->
            Blog.RepoFunctions.update_counter(post)
            Plug.Conn.put_session(conn, :counted, list ++ [post.id])
          true ->
            conn  
          end
      end
  end
end
