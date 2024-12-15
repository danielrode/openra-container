FROM fedora:latest AS build

RUN <<EOF
  dnf install -y wget
  wget https://github.com/OpenRA/OpenRA/releases/download/release-20231010/OpenRA-Red-Alert-x86_64.AppImage
  chmod +x ./OpenRA-Red-Alert-x86_64.AppImage
  ./OpenRA-Red-Alert-x86_64.AppImage --appimage-extract
EOF

FROM fedora:latest
COPY --from=build /squashfs-root /opt/openra
RUN dnf install -y libicu
EXPOSE 1234/tcp
ENTRYPOINT ["/opt/openra/AppRun", "--server"]
