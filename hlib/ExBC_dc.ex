defmodule ExBC.Dc do
  @moduledoc """
  the purpose of this module is to use several functions via direct call
  * functional    (function existant,    library existant)
  * nonfunctional (function nonexistant, library existant)
  * nonfunctional (function nonexistant, library nonexistant)
  and to see the whether the result breaks whilst compiling, at runtime,
  or at all.
  """
  def lefe() do
    ExBC.Lefe.lefefoo()
  end

  def lefn() do
    ExBC.Lefn.lefnfoo()
  end

  def lnfn() do
    ExBC.Lnfn.lnfnfoo()
  end

end
