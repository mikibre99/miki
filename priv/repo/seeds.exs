# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Blog.RepoFunctions
for i <- 0..150 do
  RepoFunctions.insert_post(%{title: "title#{i}", category: "category#{i}", body: "some body #{i}", publisher: "Johny"})
end
