defmodule IsitstillsnowingRevamp.Http.Router do
  use Plug.Router

  plug(Plug.Logger, log: :debug)

  plug(:match)

  plug(:dispatch)

  get "/" do
    IO.inspect(conn)
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> send_file(200, "priv/assets/index.html")
  end

  get _ do
    send_resp(conn, 404, "not found")
  end
end
