defmodule BlogWeb.PostsController  do
use BlogWeb, :controller
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
def new(conn, _) do
 changeset = Posts.changeset(%Posts{})
 
 render(conn, "new.html", changeset: changeset)
end

def create(conn, %{"posts" => post_params}) do
 case Blog.RepoFunctions.insert_post(post_params) do
  {:ok, _post} ->
  conn
  |> put_flash(:info, "Post published")
  |> redirect(to: Routes.posts_path(conn, :index))

  {:error, %Ecto.Changeset{} = changeset} ->
    render(conn, "new.html", changeset: changeset)
  end
end


def edit(conn, %{"id" => id}) do
  post = Blog.RepoFunctions.get_post(id)
  changeset = Posts.changeset(post)
  render(conn, "edit.html", post: post, changeset: changeset)
end


def update(conn, %{"id" => id, "posts" => post_params}) do
  post = Blog.RepoFunctions.get_post(id)
 
  case Blog.RepoFunctions.update_post(post, post_params) do
    {:ok, post} ->
      conn
      
      |> redirect(to: Routes.posts_path(conn, :show, post.id))

    {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, "edit.html", changeset: changeset, post: post)
  end
  end

def delete(conn, %{"id" => id}) do
  post = Blog.RepoFunctions.get_post(id)

  case Blog.RepoFunctions.delete_post(post) do
    {:ok, _post} ->
      conn
      |> put_flash(:info, "Post deleted.")
      |> redirect(to: Routes.posts_path(conn, :index))

   {:error, _} ->
      conn
      |> put_flash(:error, "Post could not be deleted")
      |> redirect(to: Routes.posts_path(conn, :index))
  end
end
end