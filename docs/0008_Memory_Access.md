# Memory Access

在X86处理器中存在I/O空间的概念，I/O空间是相对于内存空间而言的，它通过特定的指令in、out来访问。端口号标识了外设的寄存器地址，个人感觉Supper IO就属于这个范围的设备；I/O空间是可选的，不是必须的；

目前，大多数嵌入式微处理器（如ARM、PowerPC等）中并不提供I/O空间，而仅存在内存空间。内存空间可以直接通过地址、指针来访问，程序及在程序运行中使用的变量和其他数据都存在于内存空间中，内存地址可以直接由C语言指针操作；

## MMU

[Samsung_tiny4412(驱动笔记02)----ASM with C,MMU,Exception,GIC](https://www.cnblogs.com/zengjfgit/p/4320885.html)

## ARM Memory

https://elixir.bootlin.com/linux/latest/source/Documentation/arm/memory.txt

## I/O Port or I/O Memory

设备通常会提供一组寄存器来控制控制设备、读写设备和获取设备状态，即控制寄存器、数据寄存器和状态寄存器。这些寄存器可能位于I/O空间中，也可能位于内存空间中。当位于I/O空间时，通常称为I/O端口；当位于内存空间时，对应的内存空间被称为I/O内存；

### I/O Port

在Linux设备驱动中，应使用Linux内核提供的函数来访问定位于I/O空间的端口：
* inb()
* outb()
* inw()
* outw()
* inl()
* outl()
* [...省略]

### I/O Memory

在内核中访问I/O内存（通常时芯片内存的各个I2C、SPI、USB等控制器的寄存器或者外部内存总线上的设备）之前，需要先使用`ioremap()`函数将设备所处的物理内存映射到虚拟地址上。

在设备的物理地址（一般都是寄存器）被映射到虚拟地址之后，尽管可以直接通过指针访问这些地址，但是Linux内核推荐用一组标准的API来完成设备内存映射的虚拟地址的读写：
* readb_relaxed()
* readw_relaxed()
* writeb_relaxed()
* writew_relaxed()
* [...省略]

