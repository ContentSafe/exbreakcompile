defmodule ExBC.Imponlymacro do
  @moduledoc """
  the purpose of this module is to use several functions via
  `import bar only: [foo: n]`
  * functional    (function existant,    library existant)
  * nonfunctional (function nonexistant, library existant)
  * nonfunctional (function nonexistant, library nonexistant)
  and to see the whether the result breaks whilst compiling, at runtime,
  or at all.
  """

    import ExBC.Lefe, only: :macros
    import ExBC.Lefn, only: :macros
    import ExBC.Lnfn, only: :macros

  def lefe() do
    lefemacro()
  end

  def lefn() do
    # lefnmacro()
  end

  def lnfn() do
    # lnfnmacro()
  end

end
