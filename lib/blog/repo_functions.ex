defmodule Blog.RepoFunctions do
  alias Blog.Models.Posts
  import Ecto.Query
  alias Blog.Repo

  def insert_post(params) do
    %Posts{}
    |> Posts.changeset(params)
    |> Repo.insert()

  end
  def get_posts() do
    q = from p in Posts
    Repo.all q
  end
  def get_posts(:upvote) do
    q = from p in Posts, order_by: [desc: :upvote]

    Repo.all(q)
  end
  def get_posts(:inserted_at) do
    q = from p in Posts, order_by: [desc: :inserted_at]

    Repo.all(q)
  end
 def get_post(id) do
    q = from p in Posts, where: p.id == ^id
    Repo.one q
  end

def update_post(%Posts{} = post, params) do
  post
  |> Posts.changeset(params)
  |> Repo.update
end

def delete_post(post) do
  post
  |> Repo.delete()
end

def update_counter(post) do
  counter = post.view_counter
  update_post(post, %{view_counter: counter + 1})
  :ok
end
def upvote_post(%Posts{} = post) do
  votes = post.upvotes

  post
  |> Posts.changeset(%{upvotes: votes + 1})
  |> Repo.update()
end
end

