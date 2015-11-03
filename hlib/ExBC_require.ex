defmodule ExBC.Require do
  @moduledoc """
  the purpose of this module is to use several functions via aliases
  * functional    (function existant,    library existant)
  * nonfunctional (function nonexistant, library existant)
  * nonfunctional (function nonexistant, library nonexistant)
  and to see the whether the result breaks whilst compiling, at runtime,
  or at all.
  """

    require ExBC.Lefe
    require ExBC.Lefn
    require ExBC.Lnfn

  def lefe() do
    ExBC.Lefe.lefemacro()
  end

  def lefn() do
    ExBC.Lefn.lefnmacro()
  end

  def lnfn() do
    ExBC.Lnfn.lnfnmacro()
  end

end
