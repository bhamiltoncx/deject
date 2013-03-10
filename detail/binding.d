module deject.detail.binding;

import deject.detail.linker;
import deject.provider;

interface Binding (T) : Provider!T {
  void attach(Linker linker);
}
