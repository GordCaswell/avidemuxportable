include(avidemuxVersion)
IF(WIN32)
        IF(CROSS)
                MESSAGE(STATUS "Using mingw Cross compiler setup")
                include(admFFmpegBuild_crossMingw)
        ELSE(CROSS)          
             IF(NOT VS_IMPORT)      
                include(admFFmpegBuild_vs)
             ELSE(NOT VS_IMPORT)      
                include(admFFmpegBuild_vs_import)
             ENDIF(NOT VS_IMPORT)      
        ENDIF(CROSS)

ELSE(WIN32)
        MESSAGE(STATUS "Using native unix setup")
        include(admFFmpegBuild_native)
ENDIF(WIN32)
