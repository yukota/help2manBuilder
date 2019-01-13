# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "help2man"
version = v"1.47.8"

# Collection of sources required to build texinfo
sources = [
    "https://ftp.gnu.org/gnu/help2man/help2man-1.47.8.tar.xz" =>
    "528f6a81ad34cbc76aa7dce5a82f8b3d2078ef065271ab81fda033842018a8dc",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd help2man-1.47.8/
./configure --prefix=$prefix --host=$target
make
make install
exit

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    ExecutableProduct(prefix, "help2man", Symbol("help2man")),
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

