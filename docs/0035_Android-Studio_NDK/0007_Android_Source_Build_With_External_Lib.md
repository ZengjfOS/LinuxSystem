# Android Source Build With External Lib

## 参考文档

* [Android编译系统-完结](https://www.jianshu.com/p/662e780d833d)
* [Android.mk常用模板](https://www.linuxidc.com/Linux/2017-03/141468.htm)

## 处理方法

Android源代码尽量用这种方式加载`.so`

```Android.mk
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
# LOCAL_PREBUILT_LIBS += libopencv_java3:libs/libs/arm64-v8a/libopencv_java3.so
LOCAL_PREBUILT_LIBS := libassimpd:libs/libs/arm64-v8a/libassimpd.so \
                       libopencv_java3:libs/libs/arm64-v8a/libopencv_java3.so
include $(BUILD_MULTI_PREBUILT)

#-------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE := main
LOCAL_SRC_FILES := src/main.cpp
LOCAL_C_INCLUDES := ${LOCAL_PATH}/include
LOCAL_SHARED_LIBRARIES := libassimpd libopencv_java3
LOCAL_LDLIBS += -llog -lm
include $(BUILD_EXECUTABLE)
```