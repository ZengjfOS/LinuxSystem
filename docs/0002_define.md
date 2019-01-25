# define

## Generic Programming

泛型编程在Java、Python中用的比较多；

**typeof**

```C
#define min(x, y) ({                \
    const typeof(x) _x = (x);       \
    const typeof(y) _y = (y);       \
    (void) (&_x == &_y);            \
    _x < _y ? _x : _y; })
```

## do {} while(0)

用于`#define`的作为代码段；

```C
#define SAFE_FREE(p) do { free(p); p = NULL; } while(0)
// #define SAFE_FREE(p) free(p); p = NULL;

if (NULL != p)
    SAFE_FREE(p)        // 体会一下有do while包含和没有do while的区别；
else
    ... /* do something */
```

## goto

主要用于错误处理；

## 可变参数

```C
#define pr_debug(fmt, arg...) printk(fmt, ##arg)
```
