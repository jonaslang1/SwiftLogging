//
//  LogFileManager.swift
//
//
//  Created by Jonas Lang on 03.06.24.
//

import Foundation

class LogFileManager {
	static let fileManager = FileManager.default
	
	static func createLogFile() {
		guard let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
			return
		}
		let fileName = "\(Date().iso8601Representation).log"
		let logFilePath = (directory as NSString).appendingPathComponent(fileName)
		freopen(logFilePath.cString(using: String.Encoding.ascii), "a+", stderr)
	}
	
	static func getLogFiles() -> [URL]? {
		guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
			return nil
		}
		do {
			let urls = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: []).filter{$0.pathExtension == "log"}
			return urls
		} catch {
			print(error)
			return nil
		}
	}
	
	static func readLogFile(atPath url: URL) -> String? {
		do {
			return try String(contentsOfFile: url.absoluteString.replacingOccurrences(of: "file://", with: ""), encoding: .utf8)
		} catch {
			return nil
		}
	}
}
