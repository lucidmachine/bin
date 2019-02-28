#!/usr/bin/env bash

# ##############################################################################
# Finds Steam games in your Steam directory and writes .desktop shortcuts to an
# output directory.
# ##############################################################################

# Configuration
readonly ROMS_DIR="${HOME}/RetroPie/roms"
readonly OUTPUT_DIR="${ROMS_DIR}/steam"

# Steam stuff
readonly STEAM_APPS_DIR="${HOME}/.steam/steam/steamapps"
readonly STEAM_MANIFEST_EXT='.acf'


# ##############################################################################
# Echoes the given property from the given manifest.
#
# Arguments:
#   app_manifest_path   - The full path to the app manifest file from which the
#       property should be read.
#   property_name       - The string name of the property to be read from the
#       given app manifest.
# ##############################################################################
function getManifestProperty() {
    local app_manifest_path="$1"
    local property_name="$2"

    echo $(
        grep "$property_name" "${app_manifest_path}" \
        | rev \
        | cut -f 1 \
        | rev \
        | sed -e 's/"//g'
    )
}

# ##############################################################################
# Cats the contents of an XDG .desktop shortcut file for a Steam app.
#
# See: https://standards.freedesktop.org/desktop-entry-spec/latest/ar01s03.html
#
# Arguments:
#   app_id      - The numeric ID for the Steam app.
#   app_name    - The string name of the Steam app.
# ##############################################################################
function xdgDesktopTemplate() {
    local app_id="$1"
    local app_name="$2"

    cat <<EOF
[Desktop Entry]
Name=${app_name}
Comment=Play this game on Steam
Exec=steam steam://rungameid/${app_id}
Icon=steam_icon_${app_id}
Terminal=false
Type=Application
Categories=Game;
EOF
}


if [[ -d "${OUTPUT_DIR}" ]]; then
    rm -r "${OUTPUT_DIR}"
fi
mkdir -p "${OUTPUT_DIR}"

app_manifest_names=$(ls "${STEAM_APPS_DIR}" | grep "${STEAM_MANIFEST_EXT}")
for app_manifest_name in ${app_manifest_names}; do
    app_manifest_path="${STEAM_APPS_DIR}/${app_manifest_name}"
    app_id=$(getManifestProperty "${app_manifest_path}" '"appid"')
    app_name=$(getManifestProperty "${app_manifest_path}" '"name"')
    xdg_desktop_file_path="${OUTPUT_DIR}/${app_name}.desktop"
    xdg_desktop_file_contents=$(xdgDesktopTemplate "${app_id}" "${app_name}")

    echo "${xdg_desktop_file_contents}" > "${xdg_desktop_file_path}"
    chmod 755 "${xdg_desktop_file_path}"
done
