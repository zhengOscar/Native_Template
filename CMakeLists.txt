CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

PROJECT(template)

AUX_SOURCE_DIRECTORY(src/. SRC_LIST)

FILE(GLOB_RECURSE HEADER_LIST  src/*.h )
source_group("Header Files" FILES ${HEADER_LIST}) 

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third_part/include)
if (APPLE)
    link_libraries(${CMAKE_CURRENT_SOURCE_DIR}/third_part/lib/libmonosgen-2.0.a)
elseif (ANDROID)
	link_libraries(${CMAKE_CURRENT_SOURCE_DIR}/third_part/lib/${ANDROID_ABI}/libmonosgen-2.0.so)
else ()
	link_libraries(${CMAKE_CURRENT_SOURCE_DIR}/third_part/lib/mono-2.0-sgen.lib)
endif ()

if ( WIN32 AND NOT CYGWIN AND NOT ( CMAKE_SYSTEM_NAME STREQUAL "WindowsStore" ) )
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /MT" CACHE STRING "")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /MTd" CACHE STRING "")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT" CACHE STRING "")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd" CACHE STRING "")
    set(CompilerFlags
            CMAKE_CXX_FLAGS_DEBUG
            CMAKE_CXX_FLAGS_RELEASE
            CMAKE_C_FLAGS_DEBUG
            CMAKE_C_FLAGS_RELEASE
            )
    foreach(CompilerFlag ${CompilerFlags})
        string(REPLACE "/MD" "/MT" ${CompilerFlag} "${${CompilerFlag}}")
    endforeach()
endif ()

if (APPLE)
    if (IOS)
    	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fembed-bitcode")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fembed-bitcode")
    	ADD_Library(template  ${HEADER_LIST} ${SRC_LIST} )
		set_xcode_property (template IPHONEOS_DEPLOYMENT_TARGET "7.0" "all")
    else ()
		ADD_Library(template  MODULE ${HEADER_LIST} ${SRC_LIST} )
		set_target_properties(template PROPERTIES BUNDLE TRUE)
	endif ()
elseif (ANDROID)
	ADD_Library(template SHARED ${HEADER_LIST} ${SRC_LIST} )
else ()
	ADD_Library(template MODULE ${HEADER_LIST} ${SRC_LIST} )
	set_target_properties(template PROPERTIES BUNDLE TRUE)
endif ()