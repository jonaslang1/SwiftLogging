//
//  LogFileManagerTests.swift
//
//
//  Created by Jonas Lang on 03.06.24.
//

import XCTest
@testable import SwiftLogging

final class LogFileManagerTests: XCTestCase {
	func testCreateLogFile() throws {
		LogFileManager.createLogFile()
		NSLog("Foo)")
	}
	
	func testGetLogFileURLs () {
		let urls = LogFileManager.getLogFiles()
		XCTAssertNotNil(urls)
	}
	
	func testGetLogFiles() {
		let urls = LogFileManager.getLogFiles()
		XCTAssertNotNil(urls)
		let url = urls!.first
		XCTAssertNotNil(url)
		let content = LogFileManager.readLogFile(atPath: url!)
		XCTAssertNotNil(content)
	}
}

