# Android Studio NDK

* 正常的下载Android Studio进行安装: Android Studio 3.1.2
* 正常的安装SDK/NDK；
* 可能会遇到下面的情况；
* 善用查看gradlew信息：
  * `gradlew build --stacktrace`
  * `gradlew compileDebug --stacktrace`
* OpenCV 3.4.2
* NDK r17c

## 参考文档

* [OpenCV On Android最佳环境配置指南(Android Studio篇)](https://www.jianshu.com/p/6e16c0429044)
* [Android Studio 报错 executing external native build for cmake xxx CMakeLists.txt](https://blog.csdn.net/kidults/article/details/80599923)
* [Ninja for Windows Installation Instructions](https://github.com/rwols/CMakeBuilder/wiki/Ninja-for-Windows-Installation-Instructions)
* [Android: How to change specific name of the generated apk file in Android Studio?](https://stackoverflow.com/questions/39654620/android-how-to-change-specific-name-of-the-generated-apk-file-in-android-studio/39654621)
* [Android Studio, CMake. How to print debug message in compile time?](https://stackoverflow.com/questions/42229620/android-studio-cmake-how-to-print-debug-message-in-compile-time)
* [OpenGL CMakeLists](https://github.com/learnopengles/Learn-OpenGLES-Tutorials/blob/master/android/AndroidOpenGLESLessonsCpp/app/CMakeLists.txt)

## app gradle config 

Supported ABIs are [armeabi-v7a, arm64-v8a, x86, x86_64].

* app/build.gradle
  ```
  android {
      compileSdkVersion 28
      defaultConfig {
  
          [...省略]
  
          ndk {
              abiFilters "arm64-v8a"
          }
      }
      [...省略]
  }
  ```

## install ninja

* Android Studio的终端中运行：`gradlew build --stacktrace`
  ```
  D:\zengjf\SWDev\android\SurroundView>gradlew build --stacktrace
  [...省略]
  [== "CMake Server" ==[
  
  {"cookie":"","inReplyTo":"configure","message":"CMake Error: CMake was unable to find a build program corresponding to \"Ninja\".  CMAKE_MAKE_PROGRAM is not set.  You probably need to select a different build tool.","title":"
  Error","type":"message"}
  
  ]== "CMake Server" ==]
  
  CMake Error: CMake was unable to find a build program corresponding to "Ninja".  CMAKE_MAKE_PROGRAM is not set.  You probably need to select a different build tool.
  CMake Error: CMake was unable to find a build program corresponding to "Ninja".  CMAKE_MAKE_PROGRAM is not set.  You probably need to select a different build tool.
  [...省略]
  ```
* 目前用最新的发行版

## 修改模块名称

* 一个应用软件就是一个Module；
* 软件Module文件夹 --> 右键 --> refactor --> rename -> 选择重命名模块 --> 系统修改好后重新编译

## Release/Debug

Android Studio IDE右侧有一个`Build Variants`可以进行选择，这几个字是竖着写的；

## 给项目添加OpenCV Java库依赖

* File --> Project Structure --> Modules --> Dependencies --> 绿色+号 --> Choose Modules
* 导入的Modules可能不需要兼容很多设备，所以Modlues的gradle中的sdk版本之类尽量一致，尤其是很有NDK的，因为有些函数可能被取消了会导致一些问题；

## c++ STL

* SurrondView/build.gradle
  ```
  [...省略]
  externalNativeBuild {
      cmake {
          cppFlags "-std=c++14 -frtti -fexceptions"
          arguments '-DANDROID_STL=gnustl_shared'   //支持C++异常处理标准模板库
      }
  
      ndk {
          abiFilters "arm64-v8a"
      }
  }
  [...省略]
  ```

## CMakeLists.txt 

* `CMakeLists.txt`
  ```
  [...省略]
  # ##################### OpenCV 环境 ############################
  #设置OpenCV-android-sdk路径
  set( OpenCV_DIR D:/zengjf/SWDev/android/OpenCV-android-sdk/sdk/native/jni )
  
  find_package(OpenCV REQUIRED )
  if(OpenCV_FOUND)
      include_directories(${OpenCV_INCLUDE_DIRS})
      message(STATUS "OpenCV library status:")
      message(STATUS "    version: ${OpenCV_VERSION}")
      message(STATUS "    libraries: ${OpenCV_LIBS}")
      message(STATUS "    include path: ${OpenCV_INCLUDE_DIRS}")
  else(OpenCV_FOUND)
      message(FATAL_ERROR "OpenCV library not found")
  endif(OpenCV_FOUND)
  [...省略]
  ```
* `find * -iname cmake_build_output.txt`
  ```
  SurrondView/.externalNativeBuild/cmake/debug/arm64-v8a/cmake_build_output.txt
  SurrondView/.externalNativeBuild/cmake/release/arm64-v8a/cmake_build_output.txt
  ```
* cmake_build_output.txt
  ```
  OpenCV library status:
      version: 3.4.2
      libraries: opencv_highgui;opencv_features2d;opencv_shape;opencv_imgcodecs;opencv_ml;opencv_videoio;opencv_dnn;opencv_flann;opencv_objdetect;opencv_core;opencv_calib3d;opencv_video;opencv_superres;opencv_photo;opencv_imgproc;opencv_stitching;opencv_videostab
      include path: D:/zengjf/SWDev/android/OpenCV-android-sdk/sdk/native/jni/include;D:/zengjf/SWDev/android/OpenCV-android-sdk/sdk/native/jni/include/opencv
  Configuring done
  ```

## JNI头文件

* `cd SurrondView\src\main\java`
* `javah -encoding utf-8 com.adan.surroundview.JniActivity`：注意这里最后是文件名，也就是类名
* `copy app\src\main\java\com_adan_surroundview_JniActivity.h app\src\main\cpp\com_adan_surroundview_JniActivity.h`

## NDK版本修改

* `error: Expected NDK STL shared object file at D:\Software\androidStudio\sdk\ndk-bundle\sources\cxx-stl\gnu-libstdc++\4.9\libs\arm64-v8a\libgnustl_shared.so`
* 降低ndk版本，用r17版本，修改local.properties
  ```
  [...省略]
  #ndk.dir=D\:\\Software\\androidStudio\\sdk\\ndk-bundle
  ndk.dir=D\:\\Software\\androidStudio\\sdk\\android-ndk-r17c
  sdk.dir=D\:\\Software\\androidStudio\\sdk
  ```