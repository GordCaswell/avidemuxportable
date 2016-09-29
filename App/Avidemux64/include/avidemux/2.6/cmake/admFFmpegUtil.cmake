MACRO (getFfmpegVersionFromHeader description headerFile definition ffmpegVersion)
	FILE(READ "${headerFile}" FFMPEG_H)
	STRING(REGEX MATCH "#define[ ]+${definition}[ ]+([0-9]+)" FFMPEG_H "${FFMPEG_H}")
	STRING(REGEX REPLACE ".*[ ]([0-9]+).*" "\\1" ${ffmpegVersion} "${FFMPEG_H}")
ENDMACRO (getFfmpegVersionFromHeader)

MACRO (getFfmpegLibNames sourceDir)
	getFfmpegVersionFromHeader("libavcodec" "${sourceDir}/libavcodec/version.h" LIBAVCODEC_VERSION_MAJOR LIBAVCODEC_VERSION)
	getFfmpegVersionFromHeader("libavformat" "${sourceDir}/libavformat/version.h" LIBAVFORMAT_VERSION_MAJOR LIBAVFORMAT_VERSION)
	getFfmpegVersionFromHeader("libavutil" "${sourceDir}/libavutil/version.h" LIBAVUTIL_VERSION_MAJOR LIBAVUTIL_VERSION)
	getFfmpegVersionFromHeader("libpostproc" "${sourceDir}/libpostproc/version.h" LIBPOSTPROC_VERSION_MAJOR LIBPOSTPROC_VERSION)
	getFfmpegVersionFromHeader("libswscale" "${sourceDir}/libswscale/version.h" LIBSWSCALE_VERSION_MAJOR LIBSWSCALE_VERSION)
        SET(VERBOSE 1)
	if (VERBOSE)
		MESSAGE(STATUS "AVFORMAT : ${LIBAVFORMAT_VERSION}, Major : ${LIBAVFORMAT_VERSION_MAJOR}")
		MESSAGE(STATUS "AVCODEC  : ${LIBAVCODEC_VERSION}, Major : ${LIBAVCODEC_VERSION_MAJOR}")
		MESSAGE(STATUS "AVUTIL   : ${LIBAVUTIL_VERSION}, Major : ${LIBAVUTIL_VERSION_MAJOR}")
		MESSAGE(STATUS "POSTPRC  : ${LIBPOSTPROC_VERSION}, Major : ${LIBPOSTPROC_VERSION_MAJOR}")
		MESSAGE(STATUS "SWSCALE  : ${LIBSWSCALE_VERSION}, Major : ${LIBSWSCALE_VERSION_MAJOR}")
		message("")
	endif (VERBOSE)

	if (UNIX)
		set(LIBAVCODEC_ADM ADM6)
	endif (UNIX)

	if (APPLE)
		set(LIBAVCODEC_LIB lib${LIBAVCODEC_ADM}avcodec.${LIBAVCODEC_VERSION}${CMAKE_SHARED_LIBRARY_SUFFIX})
		set(LIBAVFORMAT_LIB lib${LIBAVCODEC_ADM}avformat.${LIBAVFORMAT_VERSION}${CMAKE_SHARED_LIBRARY_SUFFIX})
		set(LIBAVUTIL_LIB lib${LIBAVCODEC_ADM}avutil.${LIBAVUTIL_VERSION}${CMAKE_SHARED_LIBRARY_SUFFIX})
		set(LIBPOSTPROC_LIB lib${LIBAVCODEC_ADM}postproc.${LIBPOSTPROC_VERSION}${CMAKE_SHARED_LIBRARY_SUFFIX})
		set(LIBSWSCALE_LIB lib${LIBAVCODEC_ADM}swscale.${LIBSWSCALE_VERSION}${CMAKE_SHARED_LIBRARY_SUFFIX})
	elseif (UNIX)
		set(LIBAVCODEC_LIB lib${LIBAVCODEC_ADM}avcodec${CMAKE_SHARED_LIBRARY_SUFFIX}.${LIBAVCODEC_VERSION})
		set(LIBAVFORMAT_LIB lib${LIBAVCODEC_ADM}avformat${CMAKE_SHARED_LIBRARY_SUFFIX}.${LIBAVFORMAT_VERSION})
		set(LIBAVUTIL_LIB lib${LIBAVCODEC_ADM}avutil${CMAKE_SHARED_LIBRARY_SUFFIX}.${LIBAVUTIL_VERSION})
		set(LIBPOSTPROC_LIB lib${LIBAVCODEC_ADM}postproc${CMAKE_SHARED_LIBRARY_SUFFIX}.${LIBPOSTPROC_VERSION})
		set(LIBSWSCALE_LIB lib${LIBAVCODEC_ADM}swscale${CMAKE_SHARED_LIBRARY_SUFFIX}.${LIBSWSCALE_VERSION})
	elseif (MINGW)
		set(LIBAVCODEC_LIB ${LIBAVCODEC_ADM}avcodec-${LIBAVCODEC_VERSION}${CMAKE_SHARED_LIBRARY_SUFFIX})
		set(LIBAVFORMAT_LIB ${LIBAVCODEC_ADM}avformat-${LIBAVFORMAT_VERSION}${CMAKE_SHARED_LIBRARY_SUFFIX})
		set(LIBAVUTIL_LIB ${LIBAVCODEC_ADM}avutil-${LIBAVUTIL_VERSION}${CMAKE_SHARED_LIBRARY_SUFFIX})
		set(LIBPOSTPROC_LIB ${LIBAVCODEC_ADM}postproc-${LIBPOSTPROC_VERSION}${CMAKE_SHARED_LIBRARY_SUFFIX})
		set(LIBSWSCALE_LIB ${LIBAVCODEC_ADM}swscale-${LIBSWSCALE_VERSION}${CMAKE_SHARED_LIBRARY_SUFFIX})
	elseif (MSVC)
		set(LIBAVCODEC_LIB ${LIBAVCODEC_ADM}avcodec${CMAKE_LINK_LIBRARY_SUFFIX})
		set(LIBAVFORMAT_LIB ${LIBAVCODEC_ADM}avformat${CMAKE_LINK_LIBRARY_SUFFIX})
		set(LIBAVUTIL_LIB ${LIBAVCODEC_ADM}avutil${CMAKE_LINK_LIBRARY_SUFFIX})
		set(LIBPOSTPROC_LIB ${LIBAVCODEC_ADM}postproc${CMAKE_LINK_LIBRARY_SUFFIX})
		set(LIBSWSCALE_LIB ${LIBAVCODEC_ADM}swscale${CMAKE_LINK_LIBRARY_SUFFIX})
	endif (APPLE)
ENDMACRO (getFfmpegLibNames)

MACRO (registerFFmpeg sourceDir binaryDir installed)
	getFfmpegLibNames("${sourceDir}")

	add_library(ADM_libswscale UNKNOWN IMPORTED)
	add_library(ADM_libpostproc UNKNOWN IMPORTED)
	add_library(ADM_libavutil UNKNOWN IMPORTED)
	add_library(ADM_libavcodec UNKNOWN IMPORTED)
	add_library(ADM_libavformat UNKNOWN IMPORTED)

	if (${installed})
		set_property(TARGET ADM_libswscale PROPERTY IMPORTED_LOCATION "${binaryDir}/${LIBSWSCALE_LIB}")
		set_property(TARGET ADM_libpostproc PROPERTY IMPORTED_LOCATION "${binaryDir}/${LIBPOSTPROC_LIB}")
		set_property(TARGET ADM_libavutil PROPERTY IMPORTED_LOCATION "${binaryDir}/${LIBAVUTIL_LIB}")
		set_property(TARGET ADM_libavcodec PROPERTY IMPORTED_LOCATION "${binaryDir}/${LIBAVCODEC_LIB}")
		set_property(TARGET ADM_libavformat PROPERTY IMPORTED_LOCATION "${binaryDir}/${LIBAVFORMAT_LIB}")
	else (${installed})
		set_property(TARGET ADM_libswscale PROPERTY IMPORTED_LOCATION "${binaryDir}/libswscale/${LIBSWSCALE_LIB}")
		set_property(TARGET ADM_libpostproc PROPERTY IMPORTED_LOCATION "${binaryDir}/libpostproc/${LIBPOSTPROC_LIB}")
		set_property(TARGET ADM_libavutil PROPERTY IMPORTED_LOCATION "${binaryDir}/libavutil/${LIBAVUTIL_LIB}")
		set_property(TARGET ADM_libavcodec PROPERTY IMPORTED_LOCATION "${binaryDir}/libavcodec/${LIBAVCODEC_LIB}")
		set_property(TARGET ADM_libavformat PROPERTY IMPORTED_LOCATION "${binaryDir}/libavformat/${LIBAVFORMAT_LIB}")

		add_custom_target(libavcodec DEPENDS "${binaryDir}/libavcodec/${LIBAVCODEC_LIB}")
		add_custom_target(libavformat DEPENDS "${binaryDir}/libavformat/${LIBAVFORMAT_LIB}")
		add_custom_target(libavutil DEPENDS "${binaryDir}/libavutil/${LIBAVUTIL_LIB}")
		add_custom_target(libpostproc DEPENDS "${binaryDir}/libpostproc/${LIBAVPOSTPROC_LIB}")
		add_custom_target(libswscale DEPENDS "${binaryDir}/libswscale/${LIBSWSCALE_LIB}")
		add_custom_target(ffmpeg DEPENDS "${binaryDir}/ffmpeg${CMAKE_EXECUTABLE_SUFFIX}")

		if (${CMAKE_VERSION} VERSION_GREATER 2.8.3)
			add_dependencies(ADM_libavcodec libavcodec)
			add_dependencies(ADM_libavformat libavformat)
			add_dependencies(ADM_libavutil libavutil)
			add_dependencies(ADM_libpostproc libpostproc)
			add_dependencies(ADM_libswscale libswscale)
		endif (${CMAKE_VERSION} VERSION_GREATER 2.8.3)
	endif (${installed})
ENDMACRO (registerFFmpeg)

MACRO (convertPathToUnix pathVariableName bashExecutable)
	if (WIN32)
		get_filename_component(directory ${${pathVariableName}} PATH)
		get_filename_component(fileName ${${pathVariableName}} NAME)

		execute_process(COMMAND ${bashExecutable} -c "echo $PWD" WORKING_DIRECTORY "${directory}"
						OUTPUT_VARIABLE ${pathVariableName})

		string(REGEX REPLACE "(\r?\n)+$" "" ${pathVariableName} "${${pathVariableName}}")
		set(${pathVariableName} "${${pathVariableName}}/${fileName}")
	endif (WIN32)
ENDMACRO (convertPathToUnix)
