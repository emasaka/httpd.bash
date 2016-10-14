httpd.bash
==========

Simple HTTP server written in bash script


Requirements
============

* bash
* ncat (nmap)
* file
* wc
* cat
* upnpc (MiniUPnP)


Usage
=====

./httpd.bash [port] < address > [external port]

(port is default to 3000)
< address > is the adress of the eth that will receive requests. Needed to configure port foward under NAT.
    Use ipconfig to check it out or use a dash '-' to ignore UPnP.
(external port is default to 8080)


Warning
=======

This isn't secure. Don't export to internet.

Note from Lisias: I did it, since the UPnP port forward setup. But I used an expendable Raspberry PI box, without any usefull or sensitive data.


Forked from
===========

https://github.com/emasaka/httpd.bash


License
=======

The MIT License

Copyright
	(c) 2016 Lisias T
	(c) 2009 emasaka

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
