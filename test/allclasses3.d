import std.array;
import std.stdio;
import std.traits;

void main() {
  auto members = [__traits(allMembers, std.stdio)];
  auto joined = join(members, ", ");
  stdout.writefln("Got members: %s", members);
}
