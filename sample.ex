Code.require_file "lib/exrtm.ex", __DIR__

defmodule ExrtmSample do
  def operate_tasks(user) do
    tasks = user |> Exrtm.Task.get_list()
    # task  = user |> Exrtm.Task.add("xxx")
    # count = user |> Exrtm.Task.delete(task)

    IO.puts "\n----operate_tasks----"
    IO.puts "<Tasks>"
    IO.puts Enum.join(Enum.map(tasks, fn(x) -> x.name end), ", ")
    # IO.puts "<Task>"
    # IO.inspect task
    # IO.puts "<Count>"
    # IO.inspect count
  end

  def operate_lists(user) do
    lists = user |> Exrtm.List.get_list()
    inbox = user |> Exrtm.List.find("Inbox")

    IO.puts "\n----operate_lists----"
    IO.puts "<Lists>"
    IO.puts Enum.join(Enum.map(lists, fn(x) -> x.name end), ", ")
    IO.puts "<Inbox>"
    IO.inspect inbox
  end
end

use_token = false # set true for using token

key    = :os.getenv("RTM_API_KEY")        # your api_key of remember the milk
secret = :os.getenv("RTM_SHARED_SECRET")  # your shared secret of remember the milk
perm   = "read"                           # "read", "write" or "delete"

if use_token do
  token = :os.getenv("RTM_TOKEN")         # use pre-stored token to authenticate
  user  = Exrtm.init_api(key, secret, token)
else
  user = Exrtm.init_api(key, secret)
  frob = Exrtm.get_frob(user)

  IO.puts "Access to the following url using browser to authenticate this script, and then press enter to proceed."
  IO.puts Exrtm.get_auth_url(user, perm, frob)
  IO.gets ""

  token = Exrtm.get_token(user, frob)
  user  = Exrtm.init_api(key, secret, token)
  IO.puts "token = #{token}"
end

ExrtmSample.operate_lists(user)
ExrtmSample.operate_tasks(user)
