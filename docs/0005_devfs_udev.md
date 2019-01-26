# devfs udev

## 参考文档

* [udev](https://zh.wikipedia.org/wiki/Udev)

## devfs

* 可以在驱动中创建设备文件，卸载设备时将其删除；
* 设备驱动中指定设备名称、所有者、权限；
* 设备驱动中，主设备号可以自动分配，子设备指定

devfs有优点，不过还是属于被淘汰的方式，被udev取代；

## udev

* udev完全在用户态工作，利用设备插入或移除时内核所发送的热插拔事件（Hotplug Event）来工作；
* 在热插拔时，设备的详细信息会由内核通过netlink套接字发送出来，叫uevent；
* udev的设备命名策略、权限控制和事件处理都是在用户态完成的，它利用从内核收到的信息来进行创建设备节点等工作；
* 上面是处理热插拔设备，冷插拔设备，Linux内核提供了sysfs下面一个uevent节点，可以王该节点写一个"add"，导致内核重新发送netlink，之后udev就可以收到冷插拔的netllink消息了。
* 2012年4月，udev被合并至systemd。
* udev编写规则：https://zh.wikipedia.org/wiki/Udev#%E7%BC%96%E5%86%99%E8%A7%84%E5%88%99；
* 在嵌入式系统中，也可以用udev的轻量级把本mdev，mdev集成于busybox中；
* Android也没有采用udev，它采用了vold。vold的机制和udev是一样的，理解了udev，也就理解了vold；
