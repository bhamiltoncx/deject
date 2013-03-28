module deject.test.testmoduleanalysis;

import deject.moduleanalysis;

import deject.test.testclass;

import std.stdio;
import std.typetuple;

unittest {
  assert(isInjected!(deject.test.testclass, "MyClassFoo"));

  alias TypeTuple!(InjectedClassesInModule!(deject.test.testclass)) injectedTypeClasses;

  assert(injectedTypeClasses.length == 1);
  assert(staticIndexOf!(MyClassFoo, injectedTypeClasses) != -1);
}
