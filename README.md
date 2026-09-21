# SwiftGsk

A Swift wrapper around GSK 4 that is largely auto-generated from gobject-introspection.
For up to date (auto-generated) reference documentation, see https://rhx.github.io/SwiftGsk/

![macOS](https://github.com/rhx/SwiftGsk/actions/workflows/macOS.yml/badge.svg?branch=development)
![Linux](https://github.com/rhx/SwiftGsk/actions/workflows/Linux.yml/badge.svg?branch=development)

## Prerequisites

### Swift 5.6 or higher

To build, download Swift from https://swift.org/download/ -- if you are using macOS, make sure you have the command line tools installed as well).  Test that your compiler works using `swift --version`, which should give you something like

	$ swift --version
	swift-driver version: 1.168.6 Apple Swift version 6.4 (swiftlang-6.4.0.34.1 clang-2100.3.34.1)
	Target: arm64-apple-macosx27.2.0

on macOS, or on Linux you should get something like:

	$ swift --version
	Swift version 6.3.3 (swift-6.3.3-RELEASE)
	Target: x86_64-unknown-linux-gnu

### GLib 2.56 and GTK/GSK 4.0 or higher

These Swift wrappers have been tested with GLib 2.56, 2.58, 2.60, 2.62, 2.64, 2.66, 2.68, 2.70, 2.72, 2.74, 2.76, 2.78, 2.80, 2.82, 2.84, 2.86, 2.88, and 2.90, and GTK/GSK 4.0, 4.2, 4.4, 4.6, 4.8, 4.10, 4.12, 4.14, 4.16, 4.18, 4.20, 4.22, and 4.24.  Later versions may also work.  Make sure you have `gobject-introspection` and its `.gir` files installed.

#### Linux

##### Ubuntu

On Ubuntu 22.04, 24.04, and 26.04, you can use the GTK package supplied by the distribution.  Install the development packages with `apt`:

	sudo apt update
	sudo apt install libgtk-4-dev libglib2.0-dev glib-networking libcairo2-dev libpango1.0-dev gir1.2-pango-1.0 libgdk-pixbuf-2.0-dev gir1.2-gdkpixbuf-2.0 libgraphene-1.0-dev gir1.2-graphene-1.0 libharfbuzz-dev gobject-introspection libgirepository1.0-dev libxml2-dev jq

On Ubuntu 24.04 and earlier, install `libgdk-pixbuf2.0-dev` in place of `libgdk-pixbuf-2.0-dev`.

##### Fedora

On Fedora, you can use the GTK package supplied by the distribution.  Install the development packages with `dnf`:

	sudo dnf install gtk4-devel graphene-devel pango-devel harfbuzz-devel gdk-pixbuf2-devel cairo-devel glib2-devel gobject-introspection-devel libxml2-devel jq

#### macOS

On macOS, you can install gdk and gtk using HomeBrew (for setup instructions, see http://brew.sh).  Once you have a running HomeBrew installation, you can use it to install a native version of gtk:

	brew update
	brew install gtk4 glib glib-networking gobject-introspection pkg-config

## Usage

Normally, you don't build this package directly (but for testing you can - see 'Building' below). Instead you need to embed SwiftGsk into your own project using the [Swift Package Manager](https://swift.org/package-manager/).  After installing the prerequisites (see 'Prerequisites' below), add `SwiftGsk` as a dependency to your `Package.swift` file, e.g.:

```Swift
// swift-tools-version:5.6

import PackageDescription

let package = Package(name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/rhx/gir2swift.git", branch: "main"),
        .package(url: "https://github.com/rhx/SwiftGsk.git",  branch: "main"),
    ],
    targets: [
        .target(name: "MyPackage",
                dependencies: [
                    .product(name: "Gsk", package: "SwiftGsk")
                ]
        )
    ]
)
```

## Building

Normally, you don't build this package directly, but you embed it into your own project (see 'Usage' above).  However, you can build and test this module separately to ensure that everything works.  Make sure you have all the prerequisites installed (see above).  After that, you can simply clone this repository and build the command line executable (be patient, this will download all the required dependencies and take a while to compile) using

	git clone https://github.com/rhx/SwiftGsk.git
	cd SwiftGsk
    swift build
    swift test

### Xcode

On macOS, you can build the project using Xcode instead.  To do this, you need to create an Xcode project first, then open the project in the Xcode IDE:

	./xcodegen.sh
	open Gsk.xcodeproj

After that, use the (usual) Build and Test buttons to build/test this package.

## Documentation

You can find reference documentation inside the [docs](https://rhx.github.io/SwiftGLib/) folder.
This was generated using the [jazzy](https://github.com/realm/jazzy) tool.
If you want to generate your own documentation, matching your local installation,
you can use the `generate-documentation.sh` script in the repository.
Make sure you have [sourcekitten](https://github.com/jpsim/SourceKitten) and [jazzy](https://github.com/realm/jazzy) installed, e.g. on macOS:

	brew install sourcekitten
	sudo gem install jazzy
	./generate-documentation.sh


## Troubleshooting

Here are some common errors you might encounter and how to fix them.

### Old Swift toolchain or Xcode

If you get an error such as

	$ ./build.sh 
	error: unable to invoke subcommand: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-package (No such file or directory)
	
this probably means that your Swift toolchain is too old.  Make sure the latest toolchain is the one that is found when you run the Swift compiler (see above).

  If you get an older version, make sure that the right version of the swift compiler is found first in your `PATH`.  On macOS, use xcode-select to select and install the latest version, e.g.:

	sudo xcode-select -s /Applications/Xcode.app
	xcode-select --install
