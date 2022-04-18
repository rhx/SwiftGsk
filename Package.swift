// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Gsk",
    products: [
        .library(
            name: "Gsk",
            targets: ["Gsk"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rhx/gir2swift.git",     branch: "development"),
        .package(url: "https://github.com/rhx/SwiftGObject.git",  branch: "development"),
        .package(url: "https://github.com/rhx/SwiftGraphene.git", branch: "development"),
        .package(url: "https://github.com/rhx/SwiftGdk.git", branch: "gtk4-development"),
    ],
    targets: [
        .systemLibrary(
            name: "CGsk",
            pkgConfig: "gtk4",
            providers: [
                .brew(["gtk4", "glib", "glib-networking", "gobject-introspection"]),
                .apt(["libgtk-4-dev", "libglib2.0-dev", "glib-networking", "gobject-introspection", "libgirepository1.0-dev"])
            ]),
        .target(
            name: "Gsk",
            dependencies: [
                "CGsk",
                .product(name: "gir2swift",  package: "gir2swift"),
                .product(name: "GLibObject", package: "SwiftGObject"),
                .product(name: "Graphene",   package: "SwiftGraphene"),
                .product(name: "Gdk",        package: "SwiftGdk"),
            ],
            swiftSettings: [
                .unsafeFlags(["-suppress-warnings"], .when(configuration: .release)),
                .unsafeFlags(["-suppress-warnings", "-Xfrontend", "-serialize-debugging-options"], .when(configuration: .debug)),
            ],
            plugins: [
                .plugin(name: "gir2swift-plugin", package: "gir2swift")
            ]
        ),
        .testTarget(
            name: "GskTests",
            dependencies: ["Gsk"]),
    ]
)
