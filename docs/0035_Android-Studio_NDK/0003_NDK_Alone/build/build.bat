set toolchain=D:\Software\androidStudio\sdk\android-ndk-r17c\build\cmake\android.toolchain.cmake
set android_ndk=D:\Software\androidStudio\sdk\android-ndk-r17c
set build_type=Debug
set gernerator="Ninja"
set eabi=arm64-v8a

if not exist %eabi% (
    md %eabi%
)
cd %eabi%

cmake ../../ ^
      -DCMAKE_TOOLCHAIN_FILE=%toolchain% ^
      -DANDROID_NDK=%android_ndk% ^
      -DCMAKE_BUILD_TYPE=%build_type% ^
      -DANDROID_ABI=%eabi% ^
      -DCMAKE_GENERATOR=%gernerator% 

ninja

pause

:: -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=output\lib\arm64-v8a


:: Executable : D:\Software\androidStudio\sdk\cmake\3.10.2.4988404\bin\cmake.exe
:: arguments :
:: -HD:\zengjf\SWDev\android\SurroundView\hello-libs\gen-libs\src\main\cpp
:: -BD:\zengjf\SWDev\android\SurroundView\hello-libs\gen-libs\.externalNativeBuild\cmake\debug\arm64-v8a
:: -DANDROID_ABI=arm64-v8a
:: -DANDROID_PLATFORM=android-21
:: -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=D:\zengjf\SWDev\android\SurroundView\hello-libs\gen-libs\build\intermediates\cmake\debug\obj\arm64-v8a
:: -DCMAKE_BUILD_TYPE=Debug
:: -DANDROID_NDK=D:\Software\androidStudio\sdk\android-ndk-r17c
:: -DCMAKE_SYSTEM_NAME=Android
:: -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a
:: -DCMAKE_SYSTEM_VERSION=21
:: -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
:: -DCMAKE_ANDROID_NDK=D:\Software\androidStudio\sdk\android-ndk-r17c
:: -DCMAKE_TOOLCHAIN_FILE=D:\Software\androidStudio\sdk\android-ndk-r17c\build\cmake\android.toolchain.cmake
:: -G Ninja
