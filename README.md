# SwiftLogging

SwiftLogging is a simple logging utility written in Swift. It provides a `Logger` class for handling different levels of log messages and a `LogFileManager` class for managing log files.

## Features

- Log messages at different levels: info, warning, error.
- Include file, function, and line number in log messages.
- Create and manage log files.

## Installation

Simply add the `Logger.swift` and `LogFileManager.swift` files to your project.

## Usage

### Logging Messages

```swift
let logger = Logger()

logger.info("This is an informational message")
logger.warning("This is a warning message")
logger.error("This is an error message")
```

### Managing Log Files
```swift
// Create a log file
LogFileManager.createLogFile()

// Get a list of log files
if let logFiles = LogFileManager.getLogFiles() {
	for fileURL in logFiles {
		print("Log file: \(fileURL.lastPathComponent)")
	}
}

// Read the contents of a log file
if let firstLogFile = LogFileManager.getLogFiles()?.first,
   let logContent = LogFileManager.readLogFile(atPath: firstLogFile) {
	print("Log content:")
	print(logContent)
}
```
## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvement, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
