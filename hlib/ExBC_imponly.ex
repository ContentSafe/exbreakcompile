defmodule ExBC.Imponly do
  @moduledoc """
  the purpose of this module is to use several functions via
  `import bar only: [foo: n]`
  * functional    (function existant,    library existant)
  * nonfunctional (function nonexistant, library existant)
  * nonfunctional (function nonexistant, library nonexistant)
  and to see the whether the result breaks whilst compiling, at runtime,
  or at all.
  """

    import ExBC.Lefe, only: [lefefoo: 0]
    import ExBC.Lefn, only: [lefnfoo: 0]
    import ExBC.Lnfn, only: [lnfnfoo: 0]

  def lefe() do
    lefefoo()
  end

  def lefn() do
    lefnfoo()
  end

  def lnfn() do
    lnfnfoo()
  end

end
