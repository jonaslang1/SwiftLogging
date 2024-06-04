import XCTest
@testable import SwiftLogging

final class SwiftLoggingTests: XCTestCase {
	let logger: Logger = Logger()
	
    func testLogging() throws {
		logger.log(level: .info, "logged log message")
    }
	
	func testInfoLogging() {
		logger.info("logged info message")
	}
	
	func testWarningLogging() {
		logger.warning("logged warning message")
	}
	
	func testErrorLogging() {
		logger.error("logged error message")
	}
	
	func testDateRepr() {
		let date = Date(timeIntervalSince1970: 1717437683)
		XCTAssertEqual(date.iso8601Representation, "2024-06-03T18:01:23Z+0000")
	}
}
