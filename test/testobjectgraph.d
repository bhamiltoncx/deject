module deject.test.testobjectgraph;

import deject.objectgraph;

import deject.test.testmodule;

import std.stdio;
import std.typetuple;

unittest {
  auto objectGraph = new ObjectGraph!(deject.test.testmodule);

  // TODO: This fails at run time, even with explicit
  // specialization. (Also, why can I even call this private method?
  // Shouldn't this not compiler?)

  //auto foo = objectGraph.getImpl(cast(MyClassFoo)null);
  // assert(foo.getValue() == 23);
}
