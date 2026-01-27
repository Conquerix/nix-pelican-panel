{
  buildGoModule,
  lib,
  fetchFromGitHub,
}:

let
  version = "1.0.0-beta19";
in

buildGoModule {
  pname = "wings";
  inherit version;

  src = fetchFromGitHub {
    owner = "pelican-dev";
    repo = "wings";
    rev = "v${version}";
    sha256 = "sha256-prjkFa4GbqChakMZ75GIexEN3C8W3s62V4/6xEfIWxg=";
  };

  vendorHash = "sha256-ozwgBvyu3Hnw0Zs54QnDUUBVuI+Hai8b7Yq9EWzqdfI=";

  meta = {
    description = "Wings";
    homepage = "https://pelican.dev/";
    license = lib.licenses.agpl3Only;
    platforms = lib.platforms.linux;
  };
}
