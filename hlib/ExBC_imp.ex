defmodule ExBC.Imp do
  @moduledoc """
  the purpose of this module is to use several functions via import
  * functional    (function existant,    library existant)
  * nonfunctional (function nonexistant, library existant)
  * nonfunctional (function nonexistant, library nonexistant)
  and to see the whether the result breaks whilst compiling, at runtime,
  or at all.
  """

    import ExBC.Lefe
    import ExBC.Lefn
    import ExBC.Lnfn

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
