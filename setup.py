from setuptools import setup, Extension

mojo_arrow_sys_module = Extension(
    "mojo_arrow_sys.mojo_arrow_sys",
    sources=["mojo_arrow_sys/mojo_arrow_sys.c"],
    include_dirs=[],
    libraries=[],
    extra_compile_args=["-Wall", "-Wextra"],
)


setup(
    name="mojo_arrow_sys",
    description="Python C extension for accessing Arrow C streams from Mojo",
    author="Marius Seritan",
    author_email="pypi@seritan.net",
    url="https://github.com/winding-lines/mojo_arrow_sys",
    ext_modules=[mojo_arrow_sys_module],
    python_requires=">=3.10",
)
