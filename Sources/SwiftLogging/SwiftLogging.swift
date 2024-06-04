//
//  Logger.swift
//
//
//  Created by Jonas Lang on 03.06.24.
//

import Foundation

class Logger {
	enum LogLevel {
		case info
		case warning
		case error
		
		fileprivate var prefix: String {
			switch self {
			case .info:    return "INFO"
			case .warning: return "WARN"
			case .error:   return "ERROR"
			}
		}
	}
	
	struct Context {
		let file: String
		let function: String
		let line: Int
		var description: String {
			return "\((file as NSString).lastPathComponent):\(line) \(function)"
		}
	}
	
	init() {
		LogFileManager.createLogFile()
	}
	
	func info(_ str: StaticString, shouldLogContext: Bool = false, file: String = #file, function: String = #function, line: Int = #line) {
		log(level: .info, str, shouldLogContext: shouldLogContext, file: file, function: function, line: line)
	}
	
	func warning(_ str: StaticString, shouldLogContext: Bool = false, file: String = #file, function: String = #function, line: Int = #line) {
		log(level: .warning, str, shouldLogContext: shouldLogContext, file: file, function: function, line: line)
	}
	
	func error(_ str: StaticString, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		log(level: .error, str, shouldLogContext: shouldLogContext, file: file, function: function, line: line)
	}
	
	func log(level: LogLevel, _ str: StaticString, shouldLogContext: Bool = false, file: String = #file, function: String = #function, line: Int = #line) {
		let context = Context(file: file, function: function, line: line)
		handleLog(level: level, str: str.description, shouldLogContext: shouldLogContext, context: context)
	}
	
	fileprivate func handleLog(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
		let prefixString = ["\(Date())", level.prefix].joined(separator: " ")
		
		var fullString = "\(prefixString): \(str)"
		if shouldLogContext {
			fullString += " ➜ \(context.description)"
		}
		NSLog(fullString)
	}
}

extension Date {
	var iso8601Representation: String {
		let string = "\(self)"
		if let index1 = string.firstIndex(of: " ") ,
		   let index2 = string.lastIndex(of: " ") {
			return string.replacingCharacters(in: index1...index1, with: "T").replacingCharacters(in: index2...index2, with: "Z")
		}
		return string
	}
}
