# to_string missing

## error

error: use of undeclared identifier 'to_string'

## 参考文档

[Android ndk std :: to_string支持](https://codeday.me/bug/20171016/86872.html)

## 处理方法

自己实现一个

```
#include <string>
#include <sstream>

template <typename T>
std::string to_string(T value)
{
    std::ostringstream os ;
    os << value ;
    return os.str() ;
}

int main()
{
    std::string perfect = to_string(5) ;
}
```