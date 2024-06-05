//
//  LogFileManager.swift
//
//
//  Created by Jonas Lang on 03.06.24.
//

import Foundation

/// Utility class for managing log files.
class LogFileManager {
	/// The file manager instance.
	static let fileManager = FileManager.default
	
	/// Creates a new log file in the document directory.
	static func createLogFile() {
		guard let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
			return
		}
		let fileName = "\(Date().iso8601Representation).log"
		let logFilePath = (directory as NSString).appendingPathComponent(fileName)
		freopen(logFilePath.cString(using: String.Encoding.ascii), "a+", stderr)
	}
	
	/// Retrieves a list of log files in the document directory.
	/// - Returns: An array of URLs representing log files, or nil if an error occurs.
	static func getLogFiles() -> [URL]? {
		guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
			return nil
		}
		do {
			let urls = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: []).filter { $0.pathExtension == "log" }
			return urls
		} catch {
			print(error)
			return nil
		}
	}
	
	/// Reads the contents of a log file at the specified path.
	/// - Parameter url: The URL of the log file to read.
	/// - Returns: The contents of the log file as a string, or nil if an error occurs.
	static func readLogFile(atPath url: URL) -> String? {
		do {
			return try String(contentsOfFile: url.absoluteString.replacingOccurrences(of: "file://", with: ""), encoding: .utf8)
		} catch {
			return nil
		}
	}
}
