import std.socket;
import std.stdio;

class HostChecker {
  private InternetHost ih;

  this(InternetHost ih /*, Logger logger */) {
    this.ih = ih;
//    this.logger = logger;
  }

  bool checkHost(string host) {
    if (!ih.getHostByName(host)) {
      return false;
    }
    return true;
  }
}

unittest {
  import dmocks.Mocks;
  auto mocker = new Mocker;
  auto mockInetHost = mocker.mock!(InternetHost);
  auto host = "a.b.c";
  mocker.expect(mockInetHost.getHostByName(host)).returns(true);
  mocker.replay();

  auto checker = new HostChecker(mockInetHost);
  assert(checker.checkHost(host));

  mocker.verify();
}
