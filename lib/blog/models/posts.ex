defmodule Blog.Models.Posts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :category, :string
    field :view_counter, :integer, default: 0
    field :body, :string
    field :publisher, :string
    field :inserted_at, :date
    field :upvotes, :integer, default: 0



  end
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:title, :category, :view_counter, :body, :publisher, :upvotes])
    |> validate_required([:title, :body, :publisher])
  end


end
