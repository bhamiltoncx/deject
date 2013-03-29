module deject.test.testautobinding;

import deject.detail.autobinding;
import deject.test.testmodule;

import std.stdio;

class TestAutobinding {
  mixin AutoBindingsForModules!(deject.test.testmodule);
}

unittest {
  auto bindingsStr = generateBindingsForModules!(deject.test.testmodule);
  assert(bindingsStr == "MyClassFoo get(MyClassFoo)() {\n  return new MyClassFoo();\n}\n");
}

unittest {
  auto t = new TestAutobinding();
  // XXX: Why does this not compile?
  //auto foo = t.get!MyClassFoo;
  //assert(foo.getValue() == 23);
}
