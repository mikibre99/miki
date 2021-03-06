defmodule Blog.Repo.Migrations.AddPosts do
  use Ecto.Migration

  def change do
    create table("posts") do
      add :title, :string, null: false
      add :body, :text, null: false
      add :view_counter, :integer, default: 0
      add :publisher, :string, null: false
      add :category, :string
      add :inserted_at, :date, default: fragment("now()")
      add :upvotes, :integer, default: 0


    end
  end
end
