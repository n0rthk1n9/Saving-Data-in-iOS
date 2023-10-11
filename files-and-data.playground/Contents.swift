import Foundation

let remindersDataUrl = URL(fileURLWithPath: "Reminders", relativeTo: FileManager.documentDirectoryUrl)

let stringURL = FileManager.documentDirectoryUrl.appendingPathComponent("String").appendingPathExtension("txt")

stringURL.path
