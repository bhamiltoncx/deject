import std.array;
import std.stdio;
import std.traits;

string GetMembers(T)() {
  auto members = [__traits(allMembers, T)];
  return join(result, ", ");
}

void main() {
  stdout.writefln("Got members: %s", GetMembers!std.stdio);
}
