//
//  SystemLogger.swift
//  System Logger
//
//  Created by Mike Centers on 9/23/24.
//

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
/// let logger = SystemLogger(subsystem: "com.example.myapp", category: "General")
/// logger.logInfo("This is an informational message.")
/// logger.logError("An error occurred in the application.")
/// ```
///
/// The `SystemLogger` is designed to be used throughout the app by creating an instance
/// with the desired subsystem and category, making it easily accessible without needing to
/// instantiate multiple loggers.

final public class SystemLogger: Sendable {
    
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
    /// - Parameters:
    ///   - subsystem: The identifier for the app or module generating the log. It can be
    ///     overridden to provide a specific subsystem identifier.
    ///   - category: A string used to categorize logs within the subsystem. Defaults to `"default"`.
    ///
    /// ### Example:
    /// ```swift
    /// let customLogger = SystemLogger(subsystem: "com.example.myapp.network", category: "Networking")
    /// customLogger.logInfo("Network request started")
    /// ```
    public init(subsystem: String, category: String = "default") {
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
    /// let logger = SystemLogger(subsystem: "com.example.myapp")
    /// logger.logInfo("User logged in successfully")
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
    /// let logger = SystemLogger(subsystem: "com.example.myapp")
    /// logger.logDebug("Debugging user authentication process")
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
    /// let logger = SystemLogger(subsystem: "com.example.myapp")
    /// logger.logWarning("Low disk space detected")
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
    /// let logger = SystemLogger(subsystem: "com.example.myapp")
    /// logger.logError("Failed to load user profile data")
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
    /// let logger = SystemLogger(subsystem: "com.example.myapp")
    /// logger.logCritical("App crashed due to an unhandled exception")
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
    /// let logger = SystemLogger(subsystem: "com.example.myapp")
    /// logger.logPrivate("User email: example@example.com")
    /// ```
    public func logPrivate(_ message: String) {
        logger.log("\(message, privacy: .private)")
    }
}
