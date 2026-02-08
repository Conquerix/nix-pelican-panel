{
  buildGoModule,
  lib,
  fetchFromGitHub,
}:

let
  version = "1.0.0-beta22";
in

buildGoModule {
  pname = "wings";
  inherit version;

  src = fetchFromGitHub {
    owner = "pelican-dev";
    repo = "wings";
    rev = "v${version}";
    sha256 = "sha256-CVH3oiqDa/kLEstvLwO45/jetKI/V1wlrXK1C+CVzgs=";
  };

  vendorHash = "sha256-Nkz9qz8rh+1dO9lGrTLLO0mOXLtcQmxi1R1jGxWiKic=";

  meta = {
    description = "Wings";
    homepage = "https://pelican.dev/";
    license = lib.licenses.agpl3Only;
    platforms = lib.platforms.linux;
  };
}
