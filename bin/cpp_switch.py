#!/usr/bin/env python3
'''
Assumes a C++ named enum or enum class from stdin.
Prints C++ code for toString() and operator<<() methods to stdout.

Example usage:
    echo 'enum class Foo : unsigned char {kA,kB = 3,}' | cpp_switch.py

Results in:
    const char* toString(Foo value);

    std::ostream& operator<<(std::ostream& out, Foo value);

    const char* toString(Foo value) {
      switch (value) {
      case kA: return "kA";
      case kB: return "kB";
      }
    }

    std::ostream& operator<<(std::ostream& out, Foo value) {
      out << toString(value);
      return out;
    }
'''

import sys
import fileinput
from string import Template

body_template = Template('''
const char* toString($typename value);

std::ostream& operator<<(std::ostream& out, $typename value);

const char* toString($typename value) {
  switch (value) {
$case
  }
}

std::ostream& operator<<(std::ostream& out, $typename value) {
  out << toString(value);
  return out;
}
''')

case_template = Template('  case $value: return "$value";')


def type_split(line):
    return line.split(':')[0].split()[-1]


def case_split(line):
    return line.split('=')[0].split('[')[0].split()[0]


def cases_split(line):
    return [
        case_split(element) for element in line.split('{')[1].split(',')
        if case_split(element).isidentifier()
    ]


def generate(line):
    case = '\n'.join([
        case_template.substitute(value=symbol) for symbol in cases_split(line)
    ])
    return body_template.substitute(typename=type_split(line), case=case)


if __name__ == '__main__':
    print(generate(' '.join(fileinput.input())))
