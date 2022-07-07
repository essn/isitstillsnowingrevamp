defmodule IsitstillsnowingRevamp.Http.Router do
  use Plug.Router

  plug(Plug.Logger, log: :debug)
  plug(Plug.CSRFProtection)

  plug(:match)

  plug(:dispatch)

  get "/" do
      send_resp(conn, 200, "world")
  end

  get _ do
    send_resp(conn, 404, "not found")
  end
end
