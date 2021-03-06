# Blink.jl
[![Build Status](https://travis-ci.org/JuliaGizmos/Blink.jl.svg?branch=master)](https://travis-ci.org/JuliaGizmos/Blink.jl)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://JuliaGizmos.github.io/Blink.jl/stable)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://JuliaGizmos.github.io/Blink.jl/latest)

Blink.jl is the Julia wrapper around [Electron](https://electronjs.org/). It
can serve HTML content in a local window, and allows for communication between
Julia and the web page. In this way, therefore, Blink can be used as a GUI
toolkit for building HTML-based applications for the desktop.

To install, do:
```julia
julia> # press ] to enter the Pkg REPL mode
(v1.3) pkg> add Blink
# ... Blink builds and downloads Electron ...
(v1.3) pkg> # press backspace to exit Pkg REPL mode
julia> using Blink
```

### Dependencies
- [7z](https://www.7-zip.org/download.html) on Windows and `unzip` on Linux. You'll need to install the appropriate one for your system to be able to install Electron:
    - For Linux, `apt get install -y unzip` or similar should work.
    - For Windows, we use the `7z` that is normally packaged with binary distributions of Julia (via the BinDeps.jl build dependency). `7z` may be unavailable in case of a source build of Julia on Windows, in which case it can be obtained by running `make win-extras` after running `make`.

# Basic usage:

```julia
julia> using Blink

julia> w = Window() # Open a new window
Blink.AtomShell.Window(...)

julia> body!(w, "Hello World") # Set the body content

julia> loadurl(w, "http://julialang.org") # Load a web page
```

<div align="left">
<img src="https://raw.githubusercontent.com/JuliaGizmos/Blink.jl/master/docs/src/ReadMeTutorialImage.png" alt="Blink Window showing the JuliaLang website" width="480">
</div>

For options see the functions defined in [window.jl](src/AtomShell/window.jl), which closely follow [electron's API](https://github.com/atom/electron/blob/master/docs/api/browser-window.md).

You can also use the JS API to interact with the window. For example:

```julia
julia> @js w Math.log(10)
2.302585092994046
```

If that's not convincing enough, open the console (`Cmd-Alt-I` on OS X) and evaluate:

```julia
@js w console.log("hello, web-scale world")
```

## Issues & Caveats

* On Windows, the spawned process dumps its output into Julia's STDOUT, which is kind of annoying.
* When running on a headless linux instance (such as for CI tests), you must start julia via `xvfb-run julia`. More information can be found in the electron docs [here](https://electronjs.org/docs/tutorial/testing-on-headless-ci#configuring-the-virtual-display-server). See the Blink.jl [.travis.yml](https://github.com/JunoLab/Blink.jl/blob/master/.travis.yml) file for an example.

    Otherwise you will see the following error:
    ```
    │    LoadError: IOError: connect: connection refused (ECONNREFUSED)
    ```
