include(admAsNeeded)
SET(VF_PLUGIN_DIR "${AVIDEMUX_LIB_DIR}/${ADM_PLUGIN_DIR}/videoFilters/")
############## INIT_VIDEO_FILTER_INTERNAL ###################"
MACRO(INIT_VIDEO_FILTER_INTERNAL _lib)
    INCLUDE_DIRECTORIES(.)
    ADD_DEFINITIONS("-DADM_MINIMAL_UI_INTERFACE")
ENDMACRO(INIT_VIDEO_FILTER_INTERNAL)

############## INIT_VIDEO_FILTER ###################"

MACRO(INIT_VIDEO_FILTER _lib)
    if(DO_COMMON)
        INIT_VIDEO_FILTER_INTERNAL(${_lib})
    endif(DO_COMMON)
ENDMACRO(INIT_VIDEO_FILTER _lib)
############## INSTALL_VIDEO_FILTER_INTERNAL ###################"
MACRO(INSTALL_VIDEO_FILTER_INTERNAL _lib _extra)
	INSTALL(TARGETS ${_lib} 
                DESTINATION "${VF_PLUGIN_DIR}/${_extra}"
                COMPONENT plugins)
        IF(NOT MSVC) 
                SET(EXTRALIB "m")
        ENDIF(NOT MSVC) 
	TARGET_LINK_LIBRARIES(${_lib} ADM_core6 ADM_coreUI6 ADM_coreVideoFilter6 ADM_coreImage6 ADM_coreUtils6 ${EXTRALIB})
ENDMACRO(INSTALL_VIDEO_FILTER_INTERNAL)

############## INSTALL_VIDEO_FILTER ###################"
MACRO(INSTALL_VIDEO_FILTER _lib)
    IF(DO_COMMON)
        INSTALL_VIDEO_FILTER_INTERNAL(${_lib} "")
    ENDIF(DO_COMMON)
ENDMACRO(INSTALL_VIDEO_FILTER _lib)
############## ADD_VIDEO_FILTER ###################"
MACRO(ADD_VIDEO_FILTER name)
    IF(DO_COMMON)
        ADM_ADD_SHARED_LIBRARY(${name} ${ARGN})
        IF(NOT MSVC) 
                TARGET_LINK_LIBRARIES(${name} m)
        ENDIF(NOT MSVC) 
	ADM_TARGET_NO_EXCEPTION(${name})
    ENDIF(DO_COMMON)
ENDMACRO(ADD_VIDEO_FILTER name)
########### SIMPLE_VIDEO_FILTER
MACRO(SIMPLE_VIDEO_FILTER tgt src )
  ADD_VIDEO_FILTER(${tgt} ${src})
  INIT_VIDEO_FILTER(${tgt})
  INSTALL_VIDEO_FILTER(${tgt} "")
ENDMACRO(SIMPLE_VIDEO_FILTER tgt src)
