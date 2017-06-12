#!/usr/bin/env python3
'''
MIT License

Copyright (c) 2017 Jake Askeland

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Assumes a C++ named enum or enum class from stdin.
Prints C++ code for toString() and operator<<() methods to stdout.

Example usage:
    echo 'enum class Foo : unsigned char {kA,kB = 3,}' | cpp_switch.py

Or in vim, make a visual selection of the enum and then:
    :'<,'>!cpp_switch.py

Results in:
    enum class Foo : unsigned char {kA,kB = 3,}

    const char* toString(Foo value);

    std::ostream& operator<<(std::ostream& out, Foo value);

    const char* toString(Foo value) {
      switch (value) {
      case Foo::kA: return "kA";
      case Foo::kB: return "kB";
      }
    }

    std::ostream& operator<<(std::ostream& out, Foo value) {
      out << toString(value);
      return out;
    }
'''

import fileinput
from string import Template

body_template = Template('''\
const char* toString($typename value);

std::ostream& operator<<(std::ostream& out, $typename value);

const char* toString($typename value) {
  switch (value) {
$case
  }
  return "";
}

std::ostream& operator<<(std::ostream& out, $typename value) {
  out << toString(value);
  return out;
}
''')

case_template = Template('  case $typename::$value: return "$value";')


def type_split(line):
    return line.split('{')[0].split(':')[0].split()[-1]


def case_split(line):
    return line.split('=')[0].split('[')[0].split()[0]


def cases_split(line):
    return [
        case_split(element) for element in line.split('{')[1].split(',')
        if case_split(element).isidentifier()
    ]


def generate(line):
    typename = type_split(line)
    case = '\n'.join([
        case_template.substitute(
            typename=typename, value=symbol) for symbol in cases_split(line)
    ])
    return body_template.substitute(typename=typename, case=case)


if __name__ == '__main__':
    lines = [line for line in fileinput.input()]
    print(''.join(lines))
    print(generate(' '.join(lines)))
