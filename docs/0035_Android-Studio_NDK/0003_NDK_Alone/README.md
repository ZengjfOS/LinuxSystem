# README

主要是因为编译一些Android依赖库的情况下，不需要跑Android Studio中进行配置编译；

## 参考文档

* [脱离AS在windows下使用CMake交叉编译for Android](https://blog.csdn.net/LLJJYY001/article/details/77866049)

## 环境搭建

1. 使用Android Studio下载CMake、NDK；
2. 可能会缺少**ninja**，可以单独下载，配置路径；

## CMake使用方法

[build/build.bat](build/build.bat)

## Android.mk使用方法

* [jni/Android.mk](jni/Android.mk)
* [jni/Application.mk](jni/Application.mk)
* 注意：运行`ndk-build`命令的位置是jni目录上一级目录；

