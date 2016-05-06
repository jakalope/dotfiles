set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on

# the backtrace command will only show argument values 
# for scalar arguments (including pointers and C strings)
set print frame-arguments scalar

set demangle-style gnu-v3
set print sevenbit-strings off
set data-directory "/home/jake/.gdb/"

python
import sys
sys.path.insert(0, '/home/jake/.gdb')
from eigen_printers import register_eigen_printers
from stl_printers import register_libstdcxx_printers 
register_eigen_printers (None)
register_libstdcxx_printers (None)
end 
