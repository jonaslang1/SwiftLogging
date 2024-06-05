//
//  Logger.swift
//
//
//  Created by Jonas Lang on 03.06.24.
//

import Foundation

/// Logger class for handling different levels of log messages.
public class Logger {
	/// Enum representing the log levels.
	public enum LogLevel {
		case info
		case warning
		case error
		
		/// Prefix for the log level to be used in log messages.
		fileprivate var prefix: String {
			switch self {
			case .info:    return "INFO"
			case .warning: return "WARN"
			case .error:   return "ERROR"
			}
		}
	}
	
	/// Struct representing the context of a log message (file, function, line).
	struct Context {
		let file: String
		let function: String
		let line: Int
		
		/// Description of the context in the format: "filename:line function".
		var description: String {
			return "\((file as NSString).lastPathComponent):\(line) \(function)"
		}
	}
	
	/// Initializes the Logger and optionally creates a log file.
	/// - Parameter createLogFile: A Boolean indicating whether to create a log file.
	public init(createLogFile: Bool = false) {
		if createLogFile {
			LogFileManager.createLogFile()
		}
	}
	
	/// Logs an info level message.
	/// - Parameters:
	///   - str: The message to log.
	///   - shouldLogContext: Whether to include the context in the log message.
	///   - file: The file name where the log is called (default is current file).
	///   - function: The function name where the log is called (default is current function).
	///   - line: The line number where the log is called (default is current line).
	public func info(_ str: String, shouldLogContext: Bool = false, file: String = #file, function: String = #function, line: Int = #line) {
		log(level: .info, str, shouldLogContext: shouldLogContext, file: file, function: function, line: line)
	}
	
	/// Logs a warning level message.
	/// - Parameters:
	///   - str: The message to log.
	///   - shouldLogContext: Whether to include the context in the log message.
	///   - file: The file name where the log is called (default is current file).
	///   - function: The function name where the log is called (default is current function).
	///   - line: The line number where the log is called (default is current line).
	public func warning(_ str: String, shouldLogContext: Bool = false, file: String = #file, function: String = #function, line: Int = #line) {
		log(level: .warning, str, shouldLogContext: shouldLogContext, file: file, function: function, line: line)
	}
	
	/// Logs an error level message.
	/// - Parameters:
	///   - str: The message to log.
	///   - shouldLogContext: Whether to include the context in the log message.
	///   - file: The file name where the log is called (default is current file).
	///   - function: The function name where the log is called (default is current function).
	///   - line: The line number where the log is called (default is current line).
	public func error(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		log(level: .error, str, shouldLogContext: shouldLogContext, file: file, function: function, line: line)
	}
	
	/// Logs a message with a specified log level.
	/// - Parameters:
	///   - level: The level of the log message.
	///   - str: The message to log.
	///   - shouldLogContext: Whether to include the context in the log message.
	///   - file: The file name where the log is called (default is current file).
	///   - function: The function name where the log is called (default is current function).
	///   - line: The line number where the log is called (default is current line).
	public func log(level: LogLevel, _ str: String, shouldLogContext: Bool = false, file: String = #file, function: String = #function, line: Int = #line) {
		let context = Context(file: file, function: function, line: line)
		handleLog(level: level, str: str.description, shouldLogContext: shouldLogContext, context: context)
	}
	
	/// Handles the log message by formatting and outputting it.
	/// - Parameters:
	///   - level: The level of the log message.
	///   - str: The message to log.
	///   - shouldLogContext: Whether to include the context in the log message.
	///   - context: The context of the log message.
	fileprivate func handleLog(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
		let prefixString = ["\(Date())", level.prefix].joined(separator: " ")
		
		var fullString = "\(prefixString): \(str)"
		if shouldLogContext {
			fullString += " ➜ \(context.description)"
		}
		NSLog(fullString)
	}
}


/// Logger class extension for logging errors.
public extension Logger {
	/// Logs an error.
	/// - Parameters:
	///   - error: The error to log.
	///   - shouldLogContext: Whether to include the context in the log message.
	///   - file: The file name where the log is called (default is current file).
	///   - function: The function name where the log is called (default is current function).
	///   - line: The line number where the log is called (default is current line).
	func log(_ error: any Error, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		log(level: .error, "\(error)", shouldLogContext: shouldLogContext, file: file, function: function, line: line)
	}
	
	/// Logs an error.
	/// - Parameters:
	///   - error: The error to log.
	///   - shouldLogContext: Whether to include the context in the log message.
	///   - file: The file name where the log is called (default is current file).
	///   - function: The function name where the log is called (default is current function).
	///   - line: The line number where the log is called (default is current line).
	func error(_ error: any Error, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		log(error, shouldLogContext: shouldLogContext, file: file, function: function, line: line)
	}
}

extension Date {
	/// Returns the ISO 8601 representation of the date.
	var iso8601Representation: String {
		let string = "\(self)"
		if let index1 = string.firstIndex(of: " "),
		   let index2 = string.lastIndex(of: " ") {
			return string.replacingCharacters(in: index1...index1, with: "T").replacingCharacters(in: index2...index2, with: "Z")
		}
		return string
	}
}
