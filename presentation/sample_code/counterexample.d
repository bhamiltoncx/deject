import std.socket;
import std.stdio;

bool checkHost(string host) {
  auto ih = new InternetHost;
  if (!ih.getHostByName(host)) {
    reportError("No DNS: " ~ host);
    return false;
  }
  return true;
}

void reportError(string err) {
  auto f = File("log.txt", "w");
  f.write(err);
}

unittest {
  assert(checkHost("dlang.org"));
  assert(!checkHost("qlang.org"));
}
