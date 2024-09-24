# SystemLogger

**SystemLogger** is a lightweight Swift package that provides a thread-safe, structured logging system for iOS applications using Apple's `os.log` framework. It allows developers to log messages with varying levels of severity, including informational, debug, warning, error, and critical messages, while supporting privacy-aware logging.

## Features

- Centralized logging mechanism using `os.log`.
- Support for multiple log levels: Info, Debug, Warning, Error, and Critical (Fault).
- Privacy-aware logging to protect sensitive information.
- Customizable subsystem and category for better log organization.
- Easy integration into any iOS application.

## Installation

To use the **SystemLogger** package in your Swift project, you can add it to your `Package.swift` file:

```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "YourProject",
    dependencies: [
        .package(url: "https://github.com/yourusername/SystemLogger.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "YourTarget",
            dependencies: ["SystemLogger"]),
    ]
)
