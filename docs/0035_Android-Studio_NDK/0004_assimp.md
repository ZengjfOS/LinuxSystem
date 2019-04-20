# assimp

## Download

https://github.com/assimp/assimp

## 参考文档

[Assimp Android 编译](https://cloud.tencent.com/developer/article/1148917)

## cmake bat

```bat
set toolchain=D:\Software\androidStudio\sdk\android-ndk-r17c\build\cmake\android.toolchain.cmake
set android_ndk=D:\Software\androidStudio\sdk\android-ndk-r17c
set build_type=Debug
set gernerator="Ninja"
set eabi=arm64-v8a

if not exist %eabi% (
    md %eabi%
)
cd %eabi%

cmake ../ ^
      -DCMAKE_TOOLCHAIN_FILE=%toolchain% ^
      -DANDROID_NDK=%android_ndk% ^
      -DCMAKE_BUILD_TYPE=%build_type% ^
      -DANDROID_ABI=%eabi% ^
      -DANDROID_STL=c++_shared ^
      -DASSIMP_BUILD_TESTS=OFF ^
      -DCMAKE_GENERATOR=%gernerator% 

ninja

pause
```
