module deject.detail.objectgraphgetimpl;

import std.stdio;
import std.traits;
import std.typetuple;

import deject.detail.binding;
import deject.detail.linker;
import deject.detail.moduleanalysis;

string generateGetImplForModules(DModule...)() {
  string bindings;

  foreach (dmodule ; DModule) {
    foreach (klass ; deject.detail.moduleanalysis.InjectedClassesInModule!(dmodule)) {
      auto t = fullyQualifiedName!(__traits(getMember, dmodule, klass.stringof));
      bindings ~= "private " ~ t ~ " getImpl(T:" ~ t ~ ")(T t) {\n"
        // XXX: This is a stub. We need to get the dependencies here and pass them to
        // the constructor.
        ~ "  return new " ~ t ~ "();\n"
        ~ "}\n";
    }
  }

  // TODO: If we don't define getImpl(T) in the same mixin template as getImpl(T : U),
  // the compiler doesn't seem to choose the specialization.
  //
  // Started a forum thread about this:
  //
  // http://tinyurl.com/cn25e2t
  return bindings ~ "private T getImpl(T)(T t) { return linker.requestBinding!T.get(); }\n";
}

mixin template ObjectGraphGetImplForModules(DModule...) {
  mixin(generateGetImplForModules!(DModule));
}
