defmodule ExBC.Alias do
  @moduledoc """
  the purpose of this module is to use several functions via aliases
  * functional    (function existant,    library existant)
  * nonfunctional (function nonexistant, library existant)
  * nonfunctional (function nonexistant, library nonexistant)
  and to see the whether the result breaks whilst compiling, at runtime,
  or at all.
  """

    alias ExBC.Lefe
    alias ExBC.Lefn
    alias ExBC.Lnfn

  def lefe() do
    Lefe.lefefoo()
  end

  def lefn() do
    Lefn.lefnfoo()
  end

  def lnfn() do
    Lnfn.lnfnfoo()
  end

end
