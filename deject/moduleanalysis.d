module deject.moduleanalysis;

import std.algorithm;
import std.traits;
import std.typetuple;

import deject.attributes;

template isModule(alias T) {
  // TODO: Is there a better way to distinguish modules and classes?
  enum isModule = T.stringof.startsWith("module ");
}

template isInjected(alias T, string name) {
  enum isInjected =
    staticIndexOf!(Inject, __traits(getAttributes, __traits(getMember, T, name))) != -1;
}

template FilterInjectedClassesInModule(alias T, names...)
  if (isModule!T) {

  // TODO: Actually limit this to classes that can be constructed.

  static if (names.length > 0) {
    static if (isInjected!(T, names[0])) {
      alias TypeTuple!(
        __traits(getMember, T, names[0]),
        FilterInjectedClassesInModule!(T, names[1 .. $])
      ) FilterInjectedClassesInModule;
    } else {
      alias TypeTuple!(
        FilterInjectedClassesInModule!(T, names[1 .. $])
      ) FilterInjectedClassesInModule;
    }
  } else {
    alias TypeTuple!() FilterInjectedClassesInModule;
  }
}

template InjectedClassesInModule(alias T) {
  alias TypeTuple!(FilterInjectedClassesInModule!(T, __traits(allMembers, T)))
    InjectedClassesInModule;
}

// Unit tests live in deject.test.testmoduleanalysis.
