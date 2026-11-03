vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO selmf/unarr
    REF "v${VERSION}"
    SHA512 84cf296ee3bdcfa4c57db2491af37a2b76065d2eb5a898047e07cde27186bdb2ec8a9d5705167582301dcd69ef458c9e458b399642020205dc31b360a95f13ea
    HEAD_REF master
    PATCHES
        debundle-7zip.patch
)

file(REMOVE_RECURSE "${SOURCE_PATH}/lzmasdk")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DENABLE_7Z=ON
        -DUSE_SYSTEM_BZ2=ON
        -DUSE_SYSTEM_LZMA=ON
        -DUSE_SYSTEM_ZLIB=ON
        -DUSE_ZLIB_CRC=ON
        -DBUILD_INTEGRATION_TESTS=OFF
        -DBUILD_FUZZER=OFF
        -DBUILD_UNIT_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/unarr")
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
