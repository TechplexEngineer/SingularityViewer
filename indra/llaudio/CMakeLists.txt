# -*- cmake -*-

project(llaudio)

include(00-Common)
include(Audio)
include(LLAudio)
if(FMODEX)
	include(FMODEX)
	if(FMODEX)
		set(FMOD OFF)
	endif(FMODEX)
endif(FMODEX)
if(NOT FMODEX)
	include(FMOD)
endif(NOT FMODEX)
include(OPENAL)
include(LLCommon)
include(LLMath)
include(LLMessage)
include(LLVFS)

if(FMODEX)
	include_directories(${FMODEX_INCLUDE_DIR})
endif(FMODEX)
if(FMOD)
	include_directories(${FMOD_INCLUDE_DIR})
endif(FMOD)

include_directories(
    ${LLAUDIO_INCLUDE_DIRS}
    ${LLCOMMON_INCLUDE_DIRS}
    ${LLMATH_INCLUDE_DIRS}
    ${LLMESSAGE_INCLUDE_DIRS}
    ${LLVFS_INCLUDE_DIRS}
    ${OGG_INCLUDE_DIRS}
    ${VORBISENC_INCLUDE_DIRS}
    ${VORBISFILE_INCLUDE_DIRS}
    ${VORBIS_INCLUDE_DIRS}
    ${OPENAL_LIB_INCLUDE_DIRS}
    ${FREEAULT_LIB_INCLUDE_DIRS}
    )

set(llaudio_SOURCE_FILES
    llaudioengine.cpp
    lllistener.cpp
    llaudiodecodemgr.cpp
    llvorbisdecode.cpp
    llvorbisencode.cpp
    )

set(llaudio_HEADER_FILES
    CMakeLists.txt

    llaudioengine.h
    lllistener.h
    llaudiodecodemgr.h
    llvorbisdecode.h
    llvorbisencode.h
    llwindgen.h
    )

if (FMODEX)
    list(APPEND llaudio_SOURCE_FILES
         llaudioengine_fmodex.cpp
         lllistener_fmodex.cpp
         llstreamingaudio_fmodex.cpp
         )

    list(APPEND llaudio_HEADER_FILES
         llaudioengine_fmodex.h
         lllistener_fmodex.h
         llstreamingaudio_fmodex.h
         )
endif (FMODEX)
if (FMOD)
    list(APPEND llaudio_SOURCE_FILES
         llaudioengine_fmod.cpp
         lllistener_fmod.cpp
         llstreamingaudio_fmod.cpp
         )

    list(APPEND llaudio_HEADER_FILES
         llaudioengine_fmod.h
         lllistener_fmod.h
         llstreamingaudio_fmod.h
         )

    if (LINUX)
      if (${CXX_VERSION} MATCHES "4.[23]")
        set_source_files_properties(llaudioengine_fmod.cpp
                                    COMPILE_FLAGS -Wno-error=write-strings)
      endif (${CXX_VERSION} MATCHES "4.[23]")
    endif (LINUX)
endif (FMOD)

if (OPENAL)
  list(APPEND llaudio_SOURCE_FILES
    llaudioengine_openal.cpp
    lllistener_openal.cpp
    )
  
  list(APPEND llaudio_HEADER_FILES
    llaudioengine_openal.h
    lllistener_openal.h
    )
endif (OPENAL)

set_source_files_properties(${llaudio_HEADER_FILES}
                            PROPERTIES HEADER_FILE_ONLY TRUE)

list(APPEND llaudio_SOURCE_FILES ${llaudio_HEADER_FILES})

add_library (llaudio ${llaudio_SOURCE_FILES})
add_dependencies(llaudio prepare)
target_link_libraries(
    llaudio
    ${VORBISENC_LIBRARIES}
    ${VORBISFILE_LIBRARIES}
    ${VORBIS_LIBRARIES}
    ${OGG_LIBRARIES}
    )
