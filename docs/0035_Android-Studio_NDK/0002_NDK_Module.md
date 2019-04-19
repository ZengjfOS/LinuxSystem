# NDK Module

**指令中的`target`是指通过add_executable()和add_library()指令生成已经创建的目标文件**

## 示例代码

* [google samples android-ndk](https://github.com/googlesamples/android-ndk)
* [android ndk hello libs](https://github.com/googlesamples/android-ndk/tree/master/hello-libs)

## 使用示例

https://github.com/googlesamples/android-ndk/tree/master/hello-libs/gen-libs

## 示例分析

* hello-libs/gen-libs/build.gradle 
  ```gradle
  apply plugin: 'com.android.library'
  android {
      compileSdkVersion 28
      defaultConfig {
          [...省略]
          externalNativeBuild {
              cmake {
                  // explicitly build libs
                  // 这里的target就是CMakeLists.txt中的add_library中需要生成的so库名
                  targets 'gmath', 'gperf'      
              }
          }
      }
      [...省略]
      externalNativeBuild {
          cmake {
              version '3.10.2'
              // 指向第一个CMakeLists.txt相对目录，这个CMakeLists.txt可以添加其他目录来增加so库
              path 'src/main/cpp/CMakeLists.txt'
          }
      }
  }
  [...省略]
  ```
* hello-libs/gen-libs/src/main/cpp/CMakeLists.txt
  ```CMake
  [...省略]
  # 这一行功能在确定当前使用的CMake版本符合要求，当版本不满足最低需求时会输出错误信息
  cmake_minimum_required(VERSION 3.4.1)
  
  # 开启输出详细的编译和链接信息
  set(CMAKE_VERBOSE_MAKEFILE on)
  
  # 设置一个lib_src_DIR变量, CMAKE_CURRENT_SOURCE_DIR是一个全局变量, 表示CMakeLists.txt文件的绝对路径
  set(lib_src_DIR ${CMAKE_CURRENT_SOURCE_DIR})
  
  # $ENV{HOME}: build目录
  set(lib_build_DIR $ENV{HOME}/tmp)
  # MAKE_DIRECTORY will create the given directories, also if their parent directories don’t exist yet
  file(MAKE_DIRECTORY ${lib_build_DIR})
  
  # add_subdirectory(source_dir [binary_dir] [EXCLUDE_FROM_ALL])
  add_subdirectory(${lib_src_DIR}/gmath ${lib_build_DIR}/gmath)
  add_subdirectory(${lib_src_DIR}/gperf ${lib_build_DIR}/gperf)
  ```
* hello-libs/gen-libs/src/main/cpp/gperf/CMakeLists.txt
  ```CMake
  [...省略]
  # 这一行功能在确定当前使用的CMake版本符合要求，当版本不满足最低需求时会输出错误信息
  cmake_minimum_required(VERSION 3.4.1)
  
  # 开启输出详细的编译和链接信息
  set(CMAKE_VERBOSE_MAKEFILE on)
  
  # 1. 添加target叫gperf的so库;
  # 2. so库是共享库;
  # 3. 源文件这里只有一个src/gperf.c，是可以有很多的;
  add_library(gperf SHARED src/gperf.c)
  
  # copy out the lib binary and remove generated files
  # 设置一个distribution_DIR变量, CMAKE_CURRENT_SOURCE_DIR是一个全局变量, 表示CMakeLists.txt文件的绝对路径
  set(distribution_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../../../../distribution)
  # 1. 前面已经添加了叫gperf的target，这里针对编译出gperf进行一些编译参数设定，具体参数可以参考：
  #     https://cmake.org/cmake/help/latest/manual/cmake-properties.7.html#target-properties
  # 2. ANDROID_ABI是当次前编译架构，防止编译输出覆盖
  set_target_properties(gperf
                        PROPERTIES
                        LIBRARY_OUTPUT_DIRECTORY
                        "${distribution_DIR}/gperf/lib/${ANDROID_ABI}")
  # 1.为目标如库添加一个客制命令。这对于要在构建一个目标之前或之后执行一些操作非常有用。该命令本身会成为目标的一部分，仅在目标本身被构建时才会执行。如果该目标已经构建，命令将不会执行
  #     https://cmake.org/cmake/help/latest/command/add_custom_command.html#build-events
  # 2. 编译库输出已经指定完成了，这里还需要将头文件导出
  # 3. CMAKE_COMMAND：This is the full path to the CMake executable cmake(1) which is useful from custom commands that want to use the cmake -E option for portable system commands.
  add_custom_command(TARGET gperf POST_BUILD
                     COMMAND "${CMAKE_COMMAND}" -E
                     copy "${CMAKE_CURRENT_SOURCE_DIR}/src/gperf.h"
                     "${distribution_DIR}/gperf/include/gperf.h"
                     COMMENT "Copying gperf to output directory")
  ```
* hello-libs/app/src/main/cpp/CMakeLists.txt
  ```CMake
  [...省略]
  cmake_minimum_required(VERSION 3.4.1)
  
  # configure import libs
  # 设置导入库所在的路径
  set(distribution_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../../../distribution)
  
  # 导入库声明，库名、类型
  add_library(lib_gmath STATIC IMPORTED)
  # 导入库位置设置
  set_target_properties(lib_gmath PROPERTIES IMPORTED_LOCATION
      ${distribution_DIR}/gmath/lib/${ANDROID_ABI}/libgmath.a)
  
  # shared lib will also be tucked into APK and sent to target
  # refer to app/build.gradle, jniLibs section for that purpose.
  # ${ANDROID_ABI} is handy for our purpose here. Probably this ${ANDROID_ABI} is
  # the most valuable thing of this sample, the rest are pretty much normal cmake
  # 导入库声明，库名、类型
  add_library(lib_gperf SHARED IMPORTED)
  # 导入库位置设置
  set_target_properties(lib_gperf PROPERTIES IMPORTED_LOCATION
      ${distribution_DIR}/gperf/lib/${ANDROID_ABI}/libgperf.so)
  
  # build application's shared lib
  # 设置一些编译参数
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
  
  # 添加编译目标
  add_library(hello-libs SHARED
              hello-libs.cpp)
  
  # 添加依赖头文件
  target_include_directories(hello-libs PRIVATE
                             ${distribution_DIR}/gmath/include
                             ${distribution_DIR}/gperf/include)
  
  # 加入link库
  target_link_libraries(hello-libs
                        android
                        lib_gmath
                        lib_gperf
                        log)
  ```