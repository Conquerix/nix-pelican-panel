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
  vendorHash = "sha256-lS1D3zxWYs9JtXrN3heeTf+mDoWyvQO1tL42Kskh3ig=";

  php = phpWithExtensions;

  passthru = {
    php = phpWithExtensions;
  };

  meta = {
    description = "Pelican Panel PHP";
  };
}
