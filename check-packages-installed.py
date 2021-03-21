#!/usr/bin/python3
import sys
try:
    import weasyprint
    print("0")
    sys.exit(0)
except ImportError:
    print("1")
    sys.exit(1)
