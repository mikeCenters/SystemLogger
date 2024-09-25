//
//  SystemLogger.swift
//  System Logger
//
//  Created by Mike Centers on 9/23/24.
//

import Foundation
import os

// MARK: - System Logger

/// `SystemLogger` is a final, thread-safe singleton class that provides structured logging
/// for an application using Apple's `os.log` framework. The logger is customizable through
/// a subsystem and category, which allow developers to better organize and filter log messages.
///
/// This class provides a centralized way to log messages with varying levels of severity, including:
/// - Info
/// - Debug
/// - Warning
/// - Error
/// - Critical (Fault)
///
/// Additionally, the logger supports privacy-aware logging, ensuring sensitive information
/// can be marked appropriately to avoid unintentional exposure in system logs.
///
/// ## Example Usage:
/// ```swift
/// SystemLogger.main.logInfo("This is an informational message.")
/// SystemLogger.main.logError("An error occurred in the application.")
/// ```
///
/// The `SystemLogger` is designed to be used throughout the app by utilizing its shared `main` instance,
/// making it easily accessible without needing to instantiate multiple loggers.
///
/// ### Main Instance:
/// The `SystemLogger.main` is the central logging instance for the entire app, offering a simple way to log messages
/// without explicitly creating a new instance of the logger. The default subsystem is the application's bundle identifier.
///
/// ### Default Subsystem:
/// If no `subsystem` is provided, the logger defaults to the application's main bundle identifier.
/// For example, if the app's bundle identifier is `com.example.myapp`, the logger will use this
/// identifier as the default subsystem:
/// ```swift
/// SystemLogger.main.logInfo("Default subsystem used for logging.")
/// ```

final public class SystemLogger: Sendable {
    
    // MARK: - Instances
    
    /// The main shared instance of `SystemLogger`, providing a simple access point for logging throughout the app.
    public static let main = SystemLogger()
    
    
    // MARK: - Properties
    
    /// The internal `Logger` instance from `os.log` that handles the actual logging operations.
    ///
    /// The `Logger` is initialized with the provided subsystem and category, which allow
    /// developers to filter logs related to specific parts of their application.
    private let logger: Logger
    
    
    // MARK: - Init
    
    /// Initializes a new instance of `SystemLogger` with an optional subsystem and category.
    ///
    /// The `subsystem` and `category` parameters are used to categorize log messages
    /// within the system logs. The subsystem typically represents the app or module's bundle
    /// identifier, while the category can represent a specific area of the app (e.g., networking,
    /// UI, or database operations).
    ///
    /// If no `subsystem` is provided, it defaults to the app's main bundle identifier (`Bundle.main.bundleIdentifier`).
    ///
    /// - Parameters:
    ///   - subsystem: The identifier for the app or module generating the log. Defaults to the main bundle identifier.
    ///   - category: A string used to categorize logs within the subsystem. Defaults to `"default"`.
    ///
    /// ### Example:
    /// ```swift
    /// let customLogger = SystemLogger(subsystem: "com.example.myapp.network", category: "Networking")
    /// customLogger.logInfo("Network request started")
    /// ```
    public init(subsystem: String = Bundle.main.bundleIdentifier ?? "com.systemlogger.default", category: String = "default") {
        logger = Logger(subsystem: subsystem, category: category)
    }
    
    
    // MARK: - Methods
    
    /// Logs an informational message.
    ///
    /// Informational messages provide useful insights about the regular operation of the app.
    /// These logs can be used to record events like app startup, user actions, or the completion
    /// of significant tasks.
    ///
    /// - Parameter message: The message to be logged as an informational log.
    ///
    /// ### Example:
    /// ```swift
    /// SystemLogger.main.logInfo("User logged in successfully")
    /// ```
    public func logInfo(_ message: String) {
        logger.info("\(message, privacy: .public)")
    }
    
    /// Logs a debug message.
    ///
    /// Debug messages are typically used during development to track down issues or monitor
    /// the app's behavior. These logs usually contain detailed information that helps developers
    /// understand what's happening under the hood.
    ///
    /// - Parameter message: The message to be logged as a debug log.
    ///
    /// ### Example:
    /// ```swift
    /// SystemLogger.main.logDebug("Debugging user authentication process")
    /// ```
    public func logDebug(_ message: String) {
        logger.debug("\(message, privacy: .public)")
    }
    
    /// Logs a warning message.
    ///
    /// Warning messages indicate that something unexpected occurred in the app, but it doesn't
    /// necessarily mean the app is malfunctioning. It could indicate potential issues that
    /// may need attention, but they don't require immediate action.
    ///
    /// - Parameter message: The message to be logged as a warning log.
    ///
    /// ### Example:
    /// ```swift
    /// SystemLogger.main.logWarning("Low disk space detected")
    /// ```
    public func logWarning(_ message: String) {
        logger.warning("\(message, privacy: .public)")
    }
    
    /// Logs an error message.
    ///
    /// Error messages indicate that a serious issue has occurred, but the app is still able to run.
    /// Use error logs to report unexpected situations that require intervention or debugging.
    ///
    /// - Parameter message: The message to be logged as an error log.
    ///
    /// ### Example:
    /// ```swift
    /// SystemLogger.main.logError("Failed to load user profile data")
    /// ```
    public func logError(_ message: String) {
        logger.error("\(message, privacy: .public)")
    }
    
    /// Logs a critical (fault) message.
    ///
    /// Critical logs are reserved for the most severe issues, such as when the app is in an
    /// unrecoverable state or experiencing a crash. Use these logs sparingly to highlight
    /// faults that need immediate attention.
    ///
    /// The `fault` log level is used to indicate a critical failure and may trigger system reporting
    /// tools to collect diagnostics.
    ///
    /// - Parameter message: The message to be logged as a critical fault.
    ///
    /// ### Example:
    /// ```swift
    /// SystemLogger.main.logCritical("App crashed due to an unhandled exception")
    /// ```
    public func logCritical(_ message: String) {
        logger.fault("\(message, privacy: .public)")
    }
    
    /// Logs a message with privacy protection.
    ///
    /// Use this method to log sensitive or private information, such as user data or identifiers.
    /// The privacy option ensures that the message is redacted or obfuscated in system logs, providing
    /// an extra layer of protection for user information.
    ///
    /// - Parameter message: The message to be logged with privacy protection.
    ///
    /// ### Example:
    /// ```swift
    /// SystemLogger.main.logPrivate("User email: example@example.com")
    /// ```
    public func logPrivate(_ message: String) {
        logger.log("\(message, privacy: .private)")
    }
}
