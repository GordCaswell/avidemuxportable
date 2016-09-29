#ifndef ADM_CORE_H
#define ADM_CORE_H

#define ADM_INSTALL_DIR "/mingw/Release"
#define ADM_RELATIVE_LIB_DIR ""
#define ADM_PLUGIN_DIR "plugins"

// GCC - CPU
/* #undef ADM_BIG_ENDIAN */
/* #undef ADM_CPU_64BIT */
/* #undef ADM_CPU_ARMEL */
#define ADM_CPU_X86
#define ADM_CPU_X86_32
/* #undef ADM_CPU_X86_64 */

// GCC - Operating System
/* #undef ADM_BSD_FAMILY */

// use nvidia hw encoding 
/* #undef USE_NVENC */
// use vdpau h264 hw decoding 
/* #undef USE_VDPAU */
// use xvba h264 hw decoding 
/* #undef USE_XVBA */
// use libva h264 hw decoding 
/* #undef USE_LIBVA */

// 'gettimeofday' function is present
#define HAVE_GETTIMEOFDAY

// Presence of header files
#define HAVE_INTTYPES_H   1
#define HAVE_STDINT_H     1
#define HAVE_SYS_TYPES_H

#ifdef _MSC_VER
#	define ftello _ftelli64
#	define fseeko _fseeki64
#	define snprintf _snprintf
#	define strcasecmp(x, y) _stricmp(x, y)
#elif defined(__MINGW32__)
#	define rindex strrchr
#	define index strchr

#	if !1
#		define ftello ftello64 // not defined on every mingw64_w32 version (e.g. set 2011-11-03 does not have it)
#		define fseeko fseeko64
#	endif // FTELLO
#endif

#if defined(ADM_CPU_X86_32) && defined(__GNUC__)
#    define attribute_align_arg __attribute__((force_align_arg_pointer))
#else
#    define attribute_align_arg
#endif

/* use Nvwa memory leak detector */
/* #undef FIND_LEAKS */

#endif