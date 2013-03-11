module deject.bindingmodule;

import deject.detail.bindingmap;

interface BindingModule {
  void addBindingsToMap(ref BindingMap bindingMap);
}
