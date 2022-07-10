defmodule IsitstillsnowingRevamp.Renderer.Layout do
  require EEx

  require IsitstillsnowingRevamp.Renderer.Templates.Partials, as: Partials

  @path "lib/isitstillsnowing_revamp/renderer/templates/app.html.eex"

  def layout(snowing_text) do
    quoted = EEx.compile_file(@path)

    {result, _bindings} =
      Code.eval_quoted(quoted,
        header: Partials.header(),
        body: Partials.body(snowing_text),
        footer: Partials.footer()
      )

    result
  end
end
