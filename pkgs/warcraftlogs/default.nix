{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "8.20.17";
  pname = "warcraftlogs";

  src = fetchurl {
    url = "https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v${version}/warcraftlogs-v${version}.AppImage";
    hash = "sha256-sdf7ALa66cFmomlXAD+cbI/zr0lsH2U+pdKwZ7cAVkM=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname version src; };
in
appimageTools.wrapType1 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm444 /dev/stdin $out/share/applications/${pname}.desktop <<EOF
    [Desktop Entry]
    Name=Warcraft Logs Uploader
    Exec=${pname}
    Icon=${pname}
    Type=Application
    Categories=Game;Utility;
    EOF

    install -Dm444 \
      "${appimageContents}/usr/share/icons/hicolor/512x512/apps/Warcraft Logs Uploader.png" \
      "$out/share/icons/hicolor/512x512/apps/${pname}.png"
  '';

  meta = {
    description = "Uploader for WarcraftLogs combat log analysis";
    homepage = "https://www.warcraftlogs.com/client";
    downloadPage = "https://github.com/RPGLogs/Uploaders-warcraftlogs/releases";
    license = lib.licenses.unfree;
    mainProgram = "warcraftlogs";
    maintainers = with lib.maintainers; [ wobbier ];
    platforms = [ "x86_64-linux" ];
  };
}