Assembla Api
===========

Set environment variables with values from [API section][1]:
```shell
export ASSEMBLA_API_KEY='key'
export ASSEMBLA_API_KEY='secret'
```
or configure application in mix config file:
```elixir
config :assembla_api,
  api_key: "fill-me",
  api_secret: "fill-me"
```

## Usage

```elixir
my_info = AssemblaApi.User.me
other_user = AssemblaApi.User.get("bot")
spaces = AssemblaApi.Spaces.list
space = AssemblaApi.Spaces.get("sample")
space_tools = AssemblaApi.Spaces.SpaceTools.list("sample")
tool = AssemblaApi.Spaces.SpaceTools.get("sample", "git")

alias AssemblaApi.Spaces.SpaceTools.MergeRequests
mrs = MergeRequests.list "sample", "git", %{status: :open, per_page: 20}
mr = MergeRequests.get "sample", "git", 2022504
{ok, mr} = MergeRequests.create "project", "git", %{title: "Test API", source_symbol: "test_api", target_symbol: "master"}

alias AssemblaApi.Spaces.SpaceTools.MergeRequests.Versions
versions = Versions.list("sample", "git", 2022504)
version = Versions.get("sample", "git", 2022504, 1)

alias AssemblaApi.Spaces.SpaceTools.MergeRequests.Versions.Votes
{:ok, votes} = Votes.list("sample", "git", 2022504, 1)
{:ok, votes} = Votes.upvote("sample", "git", 2022504, 1)
{:ok, votes} = Votes.downvote("sample", "git", 2022504, 1)
{:ok, votes} = Votes.remove("sample", "git", 2022504, 1)

alias AssemblaApi.Spaces.SpaceTools.MergeRequests.Versions.Comments
{:ok, comments} = Comments.list "project", "git", 2027413, 1
{:ok, comments} = Comments.create "project", "git", 2027413, 1, "Elixir world!"
```

## TODO

* Add more api methods
* Add oauth token authentication

[1]: https://www.assembla.com/user/edit/manage_clients
