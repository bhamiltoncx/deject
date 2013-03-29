module deject.test.testautobinding;

import deject.detail.autobinding;
import deject.test.testmodule;

import std.stdio;

class TestAutobinding {
  mixin AutoBindingsForModules!(deject.test.testmodule);
}

unittest {
  auto bindingsStr = generateBindingsForModules!(deject.test.testmodule);
  assert(bindingsStr ==
         "private deject.test.testmodule.MyClassFoo getImpl(" ~
         "T:deject.test.testmodule.MyClassFoo)(T t) {\n"~
         "  return new deject.test.testmodule.MyClassFoo();\n}\n");
}

unittest {
  auto t = new TestAutobinding();
  auto foo = t.getImpl!(MyClassFoo)(null);
  assert(foo.getValue() == 23);
}
