# bootargs Module Param

* 在装载内核模块时，用户可以向模块传递参数，形式为"insmod(或者modprobe) 模块名 参数=参数值"；
* 如果不传递参数，参数将使用模块内定义的缺省值；
* 如果模块被内置了，就无法insmod了；
* 但是bootload可以通过bootargs里设置"模块名.参数名=值"的形式给该内置的模块传递参数；
