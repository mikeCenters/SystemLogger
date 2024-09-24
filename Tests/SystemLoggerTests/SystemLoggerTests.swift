import Testing
@testable import SystemLogger

// MARK: - Logger

let logger = SystemLogger(subsystem: "com.SystemLogger.Tests", category: "SystemLoggerTests")


// MARK: - Tests
// Since os.log doesn't return values, manually verify the logs in Xcode Console

@Test("Test information logging")
func testLogInfo() {
    let message = "This is an informational message."
    logger.logInfo(message)
    // Check the log in the console
}

@Test("Test dubug logging")
func testLogDebug() {
    let message = "Debugging process started."
    logger.logDebug(message)
    // Check the log in the console
}

@Test("Test warning message logging")
func testLogWarning() {
    let message = "This is a warning message."
    logger.logWarning(message)
    // Check the log in the console
}

@Test("Test error logging")
func testLogError() {
    let message = "An error occurred while loading data."
    logger.logError(message)
    // Check the log in the console
}

@Test("Test crital error logging")
func testLogCritical() {
    let message = "Critical failure due to an unhandled exception."
    logger.logCritical(message)
    // Check the log in the console
}

@Test("Test private logging")
func testLogPrivate() {
    let sensitiveMessage = "User email: user@example.com"
    logger.logPrivate(sensitiveMessage)
    // Check the log in the console
}
