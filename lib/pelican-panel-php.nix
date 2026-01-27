{
  php,
  pkgs,
  version,
  src,
}:

let
  phpWithExtensions = php.withExtensions (
    exts:
    with exts.all;
    [
      gd
      mysqli
      mbstring
      bcmath
      curl
      zip
      intl
      sqlite3
    ]
    ++ exts.enabled
  );
in

pkgs.php.buildComposerProject {
  pname = "pelican-panel-php";
  inherit version;
  inherit src;

  composerLock = "$src/composer.lock";
  vendorHash = "sha256-aaJOtoggfm1tyIkP2gi1M9RZbD/OxsePIWe8H50mpmo=";

  php = phpWithExtensions;

  passthru = {
    php = phpWithExtensions;
  };

  meta = {
    description = "Pelican Panel PHP";
  };
}
