# exbreakcompile

this is a minimal example for elixir import handling.

i am researching how and when erroneous code breaks.

long term goal is to gather correct compile configuration, such that code
breaks whilst compiling and not when it's too late (at runtime).

## findings

move the library you want to compile from `./hlib` into `./lib`

to test every ExBC_foo libary by itself, you can move the libs that shouldn't be
compiled back into `./hlib`.

the out-commenting of several code parts is **NOT** reverted, unless stated
otherwise.

### direct call (ExBC_dc)

#### compiling

```bash
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex
Compiled lib/ExBC_dc.ex
Generated exbreakcompile app
```

#### running

(does not break as desired)

```elixir
$ iex -S mix
Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:4:4] [async-threads:10] [kernel-poll:false]
iex(1)> ExBC.DC.l
lefe/0    lefn/0    lnfn/0    # note that all functions are listed
iex(1)> ExBC.DC.lefe()
true
iex(2)> ExBC.DC.lefn()
** (UndefinedFunctionError) undefined function: ExBC.Lefn.lefnfoofoo/0
    (exbreakcompile) ExBC.Lefn.foo()
iex(2)> ExBC.DC.lnfn()
** (UndefinedFunctionError) undefined function: ExBC.Lnfn.lnfnfoo/0 (module ExBC.Lnfn is not available)
    ExBC.Lnfn.foo()
```

### alias

#### compiling

```
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex
Compiled lib/ExBC_alias.ex
Generated exbreakcompile app
```

#### running

(does not break as desired)

(same behaviour as in direct call)

```elixir
iex -S mix
Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:4:4] [async-threads:10] [kernel-poll:false]

iex(1)> ExBC.ALIAS.l
lefe/0    lefn/0    lnfn/0    # note that all functions are listed
iex(1)> ExBC.ALIAS.lefe
true
iex(2)> ExBC.ALIAS.lefn
** (UndefinedFunctionError) undefined function: ExBC.Lefn.lefnfoo/0
    (exbreakcompile) ExBC.Lefn.lefnfoo()
iex(2)> ExBC.ALIAS.lnfn
** (UndefinedFunctionError) undefined function: ExBC.Lnfn.lnfnfoo/0 (module ExBC.Lnfn is not available)
    ExBC.Lnfn.lnfnfoo()

```

### require

#### compiling

```bash
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex

== Compilation error on file lib/ExBC_require.ex ==
** (CompileError) lib/ExBC_require.ex:13: module ExBC.Lnfn is not loaded and could not be found
```

after out-commenting `require ExBC.Lnfn`

```bash
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex
Compiled lib/ExBC_require.ex
Generated exbreakcompile app
```

the result of this will be tested below (see 'running')

to see how an unrequired macro is handled:

after out-commenting `require ExBC.Lefe`

```bash
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex

== Compilation error on file lib/ExBC_require.ex ==
** (CompileError) lib/ExBC_require.ex:16: you must require ExBC.Lefe before invoking the macro ExBC.Lefe.lefemacro/0
    (elixir) src/elixir_dispatch.erl:98: :elixir_dispatch.dispatch_require/6
    lib/ExBC_require.ex:15: (module)
```

#### running

(does not break fully as desired)

running the code with out-commented `require ExBC.Lnfn`

```elixir
iex -S mix
Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:4:4] [async-threads:10] [kernel-poll:false]

iex(1)> ExBC.Require.
lefe/0    lefn/0    lnfn/0    # note that all functions are listed
iex(1)> ExBC.Require.lefe
true
iex(2)> ExBC.Require.lefn
** (UndefinedFunctionError) undefined function: ExBC.Lefn.lefnmacro/0
    (exbreakcompile) ExBC.Lefn.lefnmacro()
iex(2)> ExBC.Require.lnfn
** (UndefinedFunctionError) undefined function: ExBC.Lnfn.lnfnmacro/0 (module ExBC.Lnfn is not available)
    ExBC.Lnfn.lnfnmacro()
```

### import (ExBC_imp)

#### compiling

```bash
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex
[...]

== Compilation error on file lib/ExBC_imp.ex ==
** (CompileError) lib/ExBC_imp.ex:13: module ExBC.Lnfn is not loaded and could not be found
```

after out-commenting `import ExBC.Lnfn`:

```bash
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex
[...]

== Compilation error on file lib/ExBC_imp.ex ==
** (CompileError) lib/ExBC_imp.ex:20: function lefnfoo/0 undefined
    (stdlib) lists.erl:1336: :lists.foreach/2
    (stdlib) erl_eval.erl:657: :erl_eval.do_apply/6
```

after out-commenting `lefnfoo()`

```
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex
[...]

== Compilation error on file lib/ExBC_imp.ex ==
** (CompileError) lib/ExBC_imp.ex:24: function lnfnfoo/0 undefined
    (stdlib) lists.erl:1336: :lists.foreach/2
    (stdlib) erl_eval.erl:657: :erl_eval.do_apply/6
```

#### running

no runnable result (breaks as desired)

### import-only (ExBC_imponly)

#### compiling

```
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex

== Compilation error on file lib/ExBC_imponly.ex ==
** (CompileError) lib/ExBC_imponly.ex:13: cannot import ExBC.Lefn.lefnfoo/0 because it doesn't exist
    (elixir) src/elixir_import.erl:58: :elixir_import.calculate/6
    (elixir) src/elixir_import.erl:18: :elixir_import.import/4
```

after out-commenting `import ExBC.Lefn, only: [lefnfoo: 0]`

```
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex

== Compilation error on file lib/ExBC_imponly.ex ==
** (CompileError) lib/ExBC_imponly.ex:14: module ExBC.Lnfn is not loaded and could not be found
```

and for clarity:

after out-commenting import ExBC.Lnfn, only: [lnfnfoo: 0]

```
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex

== Compilation error on file lib/ExBC_imponly.ex ==
** (CompileError) lib/ExBC_imponly.ex:21: function lefnfoo/0 undefined
    (stdlib) lists.erl:1336: :lists.foreach/2
    (stdlib) erl_eval.erl:657: :erl_eval.do_apply/6
```

#### running

no runnable result (breaks as desired)

### import-only-macro (ExBC_imponlymacro)

```
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex

== Compilation error on file lib/ExBC_imponlymacro.ex ==
** (CompileError) lib/ExBC_imponlymacro.ex:14: module ExBC.Lnfn is not loaded and could not be found
```

after out-commenting `import ExBC.Lnfn, only: :macros`

```
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex

== Compilation error on file lib/ExBC_imponlymacro.ex ==
** (CompileError) lib/ExBC_imponlymacro.ex:21: function lefnmacro/0 undefined
    (stdlib) lists.erl:1336: :lists.foreach/2
    (stdlib) erl_eval.erl:657: :erl_eval.do_apply/6
```

after out-commenting `lefnmacro()`

```
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex

== Compilation error on file lib/ExBC_imponlymacro.ex ==
** (CompileError) lib/ExBC_imponlymacro.ex:25: function lnfnmacro/0 undefined
    (stdlib) lists.erl:1336: :lists.foreach/2
    (stdlib) erl_eval.erl:657: :erl_eval.do_apply/6
```

after out-commenting `lnfnmacro()`

```
$ mix compile
Compiled lib/lefn.ex
Compiled lib/lefe.ex
Compiled lib/ExBC_imponlymacro.ex
Generated exbreakcompile app
```

#### running

(breaks as desired)

only runnable code results in nil for out-commented functionality:

```elixir
$ iex -S mix
Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:4:4] [async-threads:10] [kernel-poll:false]
iex(1)> ExBC.Imponlymacro.l
lefe/0    lefn/0    lnfn/0    
iex(1)> ExBC.Imponlymacro.lefe
true
iex(2)> ExBC.Imponlymacro.lefn
nil
iex(3)> ExBC.Imponlymacro.lnfn
nil

```
