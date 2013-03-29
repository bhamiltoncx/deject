module deject.test.testobjectgraphgetimpl;

import deject.detail.objectgraphgetimpl;
import deject.detail.linker;
import deject.test.testmodule;

import std.stdio;

class TestObjectGraphGetImpl {
  mixin ObjectGraphGetImplForModules!(deject.test.testmodule);
  private Linker linker;
}

unittest {
  auto getImplStr = generateGetImplForModules!(deject.test.testmodule);
  assert(getImplStr ==
         "private deject.test.testmodule.MyClassFoo getImpl(" ~
         "T:deject.test.testmodule.MyClassFoo)(T t) {\n"~
         "  return new deject.test.testmodule.MyClassFoo();\n}\n" ~
         "private T getImpl(T)(T t) { return linker.requestBinding!T.get(); }\n");
}

unittest {
  auto t = new TestObjectGraphGetImpl();
  auto foo = t.getImpl!(MyClassFoo)(null);
  assert(foo.getValue() == 23);
}
