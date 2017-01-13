# mooncake

Lua Programming Practice

## Lua Basic

- [Programming in Lua (First Edition)](https://www.lua.org/pil/contents.html)
- [Lua 5.3 Reference Manual](https://www.lua.org/manual/5.3/)
- [Lua 5.1 参考手册 (Translated by 云风)](http://www.codingnow.com/2000/download/lua_manual.html)
- [Programming in Lua (中文版)](http://www.centoscn.com/uploads/file/20130903/13781389409335.pdf)


## Setup

### Installing Lua

```
sudo apt-get install lua5.2

-or-

curl -R -O http://www.lua.org/ftp/lua-5.3.3.tar.gz
tar zxf lua-5.3.3.tar.gz
cd lua-5.3.3
make linux test
```

### LuaRocks

**LuaRocks** is the package manager for Lua modules.

```
git clone git://github.com/luarocks/luarocks.git
./configure
make build
sudo make install

-or-

$ wget https://luarocks.org/releases/luarocks-2.4.1.tar.gz
$ tar zxpf luarocks-2.4.1.tar.gz
$ cd luarocks-2.4.1
$ ./configure; sudo make bootstrap
$ sudo luarocks install luasocket
$ lua
Lua 5.3.3 Copyright (C) 1994-2016 Lua.org, PUC-Rio
> require "socket"
```

> https://luarocks.org

> https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Unix

## Dependency

- [Lanes](http://lualanes.github.io/lanes/)
- [Lua-cURL](https://github.com/Lua-cURL/Lua-cURLv3)

## Reference

- https://www.lua.org
- https://en.wikipedia.org/wiki/Lua_(programming_language)
- http://lua-users.org/wiki/
