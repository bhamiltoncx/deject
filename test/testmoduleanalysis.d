module deject.test.testmoduleanalysis;

import deject.detail.moduleanalysis;

import deject.test.testmodule;

import std.stdio;
import std.typetuple;

unittest {
  assert(isInjected!(deject.test.testmodule, "MyClassFoo"));

  alias TypeTuple!(InjectedClassesInModule!(deject.test.testmodule)) injectedTypeClasses;

  assert(injectedTypeClasses.length == 1);
  assert(staticIndexOf!(MyClassFoo, injectedTypeClasses) != -1);
}
