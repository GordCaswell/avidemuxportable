#
#
include(admTimeStamp)
SET(CPACK_SET_DESTDIR "ON")
SET (CPACK_GENERATOR "RPM")
# ARCH
IF (X86_64_SUPPORTED)
SET(CPACK_RPM_PACKAGE_ARCHITECTURE "x86_64")
ELSE (X86_64_SUPPORTED)
SET(CPACK_RPM_PACKAGE_ARCHITECTURE "i386")
ENDIF (X86_64_SUPPORTED)
# Mandatory
SET(CPACK_RPM_PACKAGE_VERSION "${AVIDEMUX_VERSION}")
SET(CPACK_RPM_PACKAGE_RELEASE "1.r${ADM_SUBVERSION}.bootstrap")

SET(CPACK_RPM_PACKAGE_LICENSE "GPLv2+")
SET(CPACK_RPM_PACKAGE_GROUP "Development/Libraries")
SET(CPACK_RPM_PACKAGE_VENDOR "mean")
SET(CPACK_RPM_PACKAGE_URL "http://www.avidemux.org")
#
ADM_TIMESTAMP(date)
SET(CPACK_PACKAGE_FILE_NAME "${CPACK_RPM_PACKAGE_NAME}-${CPACK_RPM_PACKAGE_VERSION}-${date}.${CPACK_RPM_PACKAGE_ARCHITECTURE}")


SET(CPACK_RPM_PACKAGE_SECTION "extra")
SET(CPACK_RPM_PACKAGE_PRIORITY "optional")

include(CPack)

#SET(CPACK_RPM_PACKAGE_PROVIDES "avidemux3 = ${CPACK_RPM_PACKAGE_VERSION}")
#SET(CPACK_RPM_PACKAGE_NAME "avidemux3-core")
#SET(CPACK_RPM_PACKAGE_DESCRIPTION "Simple video editor,core libraries and development files.")
#SET(CPACK_RPM_PACKAGE_SUMMARY "Graphical video editing and transcoding tool and its development files.")

