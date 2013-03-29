module deject.test.testobjectgraph;

import deject.objectgraph;

import deject.test.testmodule;

import std.stdio;
import std.typetuple;

unittest {
  auto objectGraph = new ObjectGraph!(deject.test.testmodule);
  // auto foo = objectGraph.get!MyClassFoo;
  // assert(foo.getValue() == 23);
}
