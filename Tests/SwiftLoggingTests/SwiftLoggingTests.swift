import XCTest
@testable import SwiftLogging

final class SwiftLoggingTests: XCTestCase {
	let logger: Logger = Logger(createLogFile: false)
	
	func testInfoLog() {
		let logFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test.log")
		freopen(logFileURL.path, "w+", stderr)
		
		logger.info("This is an info message")
		
		fflush(stderr)
		
		let logContents = try? String(contentsOf: logFileURL)
		XCTAssertTrue(logContents?.contains("INFO: This is an info message") ?? false, "Info log not found in logs")
	}
	
	func testWarningLog() {
		let logFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test.log")
		freopen(logFileURL.path, "w+", stderr)
		
		logger.warning("This is a warning message")
		
		fflush(stderr)
		
		let logContents = try? String(contentsOf: logFileURL)
		XCTAssertTrue(logContents?.contains("WARN: This is a warning message") ?? false, "Warning log not found in logs")
	}
	
	func testErrorLog() {
		let logFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test.log")
		freopen(logFileURL.path, "w+", stderr)
		
		logger.error("This is an error message")
		
		fflush(stderr)
		
		let logContents = try? String(contentsOf: logFileURL)
		XCTAssertTrue(logContents?.contains("ERROR: This is an error message") ?? false, "Error log not found in logs")
		XCTAssertTrue(logContents?.contains("SwiftLoggingTests.swift") ?? false, "Context (file) not found in logs")
		XCTAssertTrue(logContents?.contains("testErrorLog") ?? false, "Context (function) not found in logs")
	}
	
	func testDateRepr() {
		let date = Date(timeIntervalSince1970: 1717437683)
		XCTAssertEqual(date.iso8601Representation, "2024-06-03T18:01:23Z+0000")
	}
}
