import foo.bar;
import std.array;
import std.stdio;
import std.traits;
import std.typetuple;

string[] getClassesForModule(alias T)() {
  string[] classes;
  foreach (m; __traits(allMembers, T)) {
  }
  return classes;
}

void main() {
  stdout.writefln("All members: %s", [__traits(allMembers, foo.bar)]);
  stdout.writefln("Got class members: %s", getClassesForModule!(foo.bar));
}
