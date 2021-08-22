{ mkDerivation, async, base, lib, req, retry, scotty, turtle }:
mkDerivation {
  pname = "async-hs";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ async base req retry scotty turtle ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}
