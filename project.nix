{ mkDerivation, async, base, lib, process, req, retry
, safe-exceptions, scotty, turtle
}:
mkDerivation {
  pname = "async-hs";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    async base process req retry safe-exceptions scotty turtle
  ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}
