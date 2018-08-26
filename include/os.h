#ifndef ENGINE_OS_H
#define ENGINE_OS_H

#define OS_DETECTED 0
#define OS_ANDROID  0
#define OS_IOS      0
#define OS_MACOS    0
#define OS_LINUX    0
#define OS_WINDOWS  0


#if defined(__APPLE__)
# include <TargetConditionals.h>
# if TARGET_OS_MAC == 1
#   if TARGET_OS_IPHONE == 1 || TARGET_OS_EMBEDDED == 1
#     undef  OS_IOS
#     define OS_IOS 1
#   else
#     undef  OS_MACOS
#     define OS_MACOS 1
#   endif  // TARGET_OS_IPHONE
#   undef  OS_DETECTED
#   define OS_DETECTED 1
# endif  // TARGET_OS_MAC
#endif  // defined(__APPLE__)

#if defined(_WIN32) || defined(__WIN32__) || defined(WIN32)
# undef  OS_WINDOWS
# define OS_WINDOWS 1
# undef  OS_DETECTED
# define OS_DETECTED 1
#endif	// defined(_WIN32) || defined(__WIN32__) || defined(WIN32)

#if defined(__ANDROID__)
# undef  OS_ANDROID
# define OS_ANDROID 1
# undef  OS_DETECTED
# define OS_DETECTED 1
#endif	// defined(__ANDROID__)

#if defined(linux) || defined(__linux)
# undef  OS_LINUX
# define OS_LINUX 1
# undef  OS_DETECTED
# define OS_DETECTED 1
#endif	// defined(linux) || defined(__linux)

#if !OS_DETECTED
# error "Fatal: trying to build for unknown OS"
#endif	// !OS_DETECTED

#endif	// ENGINE_OS_H
