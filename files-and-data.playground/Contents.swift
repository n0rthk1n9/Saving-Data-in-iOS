import Foundation

let remindersDataUrl = URL(fileURLWithPath: "Reminders", relativeTo: FileManager.documentDirectoryUrl)

let stringURL = FileManager.documentDirectoryUrl.appendingPathComponent("String").appendingPathExtension("txt")

stringURL.path

let challengeString: String = "Camping ist schön"
let challengeURL: URL = .init(fileURLWithPath: challengeString, relativeTo: FileManager.documentDirectoryUrl).appendingPathExtension("txt")

challengeURL.lastPathComponent
