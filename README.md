# README

以前记录的Linux内核相关的内容都是以博客的形式存在，并没有组织成体系，在阅读的时候没有先后的连续性，所以打算一点一点集成到一个仓库中，这样方便以后查阅。

## 参考文档

* [Welcome to The Linux Kernel’s documentation](https://www.kernel.org/doc/html/v4.11/index.html)
* 书籍：Linux设备驱动开发详解 基于最新的Linux 4.0内核

## 笔记文档

* [0008_Memory_Access.md](./docs/0008_Memory_Access.md)：I2C/SPI/USB/GPIO等各种控制器寄存器如何访问；
* [0007_Interrupt.md](./docs/0007_Interrupt.md)：驱动是为了操作硬件，硬件和软件之间的神经——中断；
* [0006_bootargs_Module_Param.md](./docs/0006_bootargs_Module_Param.md)：bootargs参数中那么多，到底是给谁的；
* [0005_devfs_udev.md](./docs/0005_devfs_udev.md)：设备节点自动生成到底是谁在维护；
* [0004_GPL.md](./docs/0004_GPL.md)：你用了有Linux内核的系统，也许你就可以要求要内核源代码，不过能不能看懂是另外一回事；
* [0003_Cross_Compiler_Tools.md](./docs/0003_Cross_Compiler_Tools.md)：怎么生成交叉工具链；
* [0002_define.md](./docs/0002_define.md)：常用宏定义使用；
* [0001_Coding_Style.md](./docs/0001_Coding_Style.md)：代码格式太蓝看的话，可能不会有人来帮你看Bug；
