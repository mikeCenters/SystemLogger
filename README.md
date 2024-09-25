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
        .package(url: "https://github.com/mikeCenters/SystemLogger", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "YourTarget",
            dependencies: ["SystemLogger"]),
    ]
)
```

After adding the dependency, you can run swift package update to fetch the SystemLogger package.

# Usage

## Basic Setup

You can initialize a logger by specifying a custom subsystem and category, or let it default to your app’s bundle identifier.

```swift
import SystemLogger

let logger = SystemLogger(subsystem: "com.example.myapp", category: "Networking")
logger.logInfo("Network request started")
```

If you don’t provide a subsystem, SystemLogger defaults to your app’s main bundle identifier.

```swift
let defaultLogger = SystemLogger()
defaultLogger.logInfo("App launched successfully")
```

# Log Levels

You can log messages at different levels of severity:

## Info

```swift
logger.logInfo("User successfully logged in")
```

## Debug
```swift
logger.logDebug("Debugging the login process")
```

## Warning
```swift
logger.logWarning("Low disk space warning")
```

## Error
```swift
logger.logError("Failed to load user data")
```

## Critical(Fault)
```swift
logger.logCritical("App crashed due to unhandled exception")
````

## Privacy-Aware Logging

For sensitive information, SystemLogger supports privacy-aware logging, ensuring that private data is redacted in system logs:

```swift
logger.logPrivate("User email: example@example.com")
```

## Singleton Access

You can also use a shared instance of SystemLogger throughout your app:

```swift
SystemLogger.main.logInfo("Logging from shared instance")
```

# Contributing

Contributions are welcome! Please fork the repository and submit a pull request if you want to make improvements or add new features.

# License

SystemLogger is available under the MIT license. See the [LICENSE](https://github.com/mikeCenters/SystemLogger/blob/main/LICENSE) file for more info.
