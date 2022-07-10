defmodule IsitstillsnowingRevamp.Renderer.Templates.Partials do
  require EEx

  @header "lib/isitstillsnowing_revamp/renderer/templates/partials/_header.html.eex"
  @body "lib/isitstillsnowing_revamp/renderer/templates/partials/_body.html.eex"
  @footer "lib/isitstillsnowing_revamp/renderer/templates/partials/_footer.html.eex"

  def header() do
    quoted = EEx.compile_file(@header)
    {result, _bindings} = Code.eval_quoted(quoted)
    result
  end

  def body(snowing_text) do
    quoted = EEx.compile_file(@body)
    {result, _bindings} = Code.eval_quoted(quoted, snowing_text: snowing_text)
    result
  end

  def footer() do
    quoted = EEx.compile_file(@footer)
    {result, _bindings} = Code.eval_quoted(quoted)
    result
  end
end
