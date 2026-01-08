vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cddlib/cddlib
    REF "${VERSION}"
    SHA512 08314d757a55065fc09ca2b514d8425b651eee2f5a195d5fbc1369acde1dc704c31a7c0e85ef3f8ec72e36f5f6a10618acef95157fa78989da96ce34bc9bc7f9
    HEAD_REF master
    PATCHES
        0001-disable-doc-target.patch  # disable building docs, as they require latex
        0002-disable-dd-log.patch  # windows does not export global variables
)
vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    AUTOCONFIG
    COPY_SOURCE  # ensure generated files are found
)
vcpkg_install_make()
vcpkg_fixup_pkgconfig()
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING" "${SOURCE_PATH}/COPYING")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
