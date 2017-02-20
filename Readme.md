# ConTeXt/LaTeX modules for Textadept 

This project contains [Textadept](https://foicica.com/textadept/) 
modules which adds [ConTeXt](http://wiki.contextgarden.net/Main_Page) 
and [LaTeX](https://www.latex-project.org/) capabilities to the 
Textadept editor.

# Dependencies

We provide a number of [Textadept](https://foicica.com/textadept/) 
modules which together with TextAdept provides a powerful configurable 
IDE for both ConTeXt and LaTeX. Please see the [Textadept installation 
instructions](https://foicica.com/textadept/manual.html#Installation) 
for details on installing Textadept.

These modules are not much use without ConTeXt (and/or LaTeX) installed. 
The [TeXLive](https://www.tug.org/texlive/) installation contains 
reasonably up to date versions of both ConTeXt and LaTeX. Alternatively 
ConTeXt can be installed stand alone. Please see the relevant 
installation manuals for details.

Navigating a large ConTeXt or LaTeX project is critical. We use 
[Exuberant-CTags](http://ctags.sourceforge.net/) and the TextAdept 
module [Texredux](http://rgieseke.github.io/textredux/) to provide this 
navigation. Please see their relevant installation instructions for 
details for details on installation on your system.

While the ConTeXt, LaTeX and common Textadept modules should work on any 
platform, the setup script is a bash script which has only been tested 
on Ubuntu. Users who do not have access to the bash scripting language 
will need to make the required changes by hand.

# Installation

On a unix machine you can use the following command to install all of the 
modules:

> ./setup all

To install only the ConTeXt, LaTeX or XML modules type:

> ./setup context

or

> ./setup latex

or

> ./setup xml

# License

## Main lua code

Unless specified otherwise the Lua code in this directory is released under 
the following [MIT License](https://opensource.org/licenses/MIT): 

Copyright 2017 Stephen Gaito

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
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE. 

## XML lua code 

The xml/init.lua and xml/xml.lua code have been taken from Brian Schott's 
[ta-xml](https://bitbucket.org/SirAlaran/ta-xml/src)/init.lua and 
[ta-common](https://bitbucket.org/SirAlaran/ta-common/src)/xml.lua projects 
respectively. Except for minor modifications, both are Copyright Brian Schott 
and are released under MIT licenses. Please see the top of each file for 
details. 

