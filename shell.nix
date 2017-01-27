with import <nixpkgs> {};
let
  defaultElmFormat = stdenv.mkDerivation {
    name = "default-elm-format";
    src = elmPackages.elm;
    buildInputs = [ elmPackages.elm ];
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      ln -s ${elmPackages.elm}/bin/elm-format-0.18 $out/bin/elm-format
    '';
  };
in  
stdenv.mkDerivation rec {
  name = "elm-tutorial";
  buildInputs = [ elmPackages.elm defaultElmFormat nodejs-7_x foreman ];
  shellHook = ''
    export PS1="\[\033[33;1m\]${name}\[\033[00m\] > "
  '';
}
