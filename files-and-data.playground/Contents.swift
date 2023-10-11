import Foundation

let remindersDataUrl = URL(fileURLWithPath: "Reminders", relativeTo: FileManager.documentDirectoryUrl)

let stringURL = FileManager.documentDirectoryUrl.appendingPathComponent("String").appendingPathExtension("txt")

stringURL.path

let challengeString: String = "Camping ist schön"
let challengeURL: URL = .init(fileURLWithPath: challengeString, relativeTo: FileManager.documentDirectoryUrl).appendingPathExtension("txt")

challengeURL.lastPathComponent

//: ## Data Types

//: ### Integers
let age: UInt8 = 32
MemoryLayout.size(ofValue: age)
MemoryLayout<UInt8>.size
UInt8.min
UInt8.max
let height: Int8 = 72
MemoryLayout.size(ofValue: height)
MemoryLayout<Int8>.size
Int8.min
Int8.max

//: ### Floats
let weight: Float = 154.5
MemoryLayout.size(ofValue: weight)
MemoryLayout<Float>.size
Float.leastNormalMagnitude
Float.greatestFiniteMagnitude

//: ### Doubles
let earthRadius: Double = 3958.8
MemoryLayout.size(ofValue: earthRadius)
MemoryLayout<Double>.size
Double.leastNormalMagnitude
Double.greatestFiniteMagnitude

//: ### Binary & Hexadecimal
let ageBinary: UInt8 = 0b0010_0000
let ageBinaryNegative: Int8 = -0b0010_0000
let weightHexadecimal: UInt16 = 0x9B
let weightHexadecimalNegative: Int16 = -0x9B

//: ## Bytes
let favoriteBytes: [UInt8] = [
    240, 159, 152, 184,
    240, 159, 152, 185,
    0b1111_0000, 0b1001_1111, 0b1001_1000, 186,
    0xF0, 0x9F, 0x98, 187
]
MemoryLayout<UInt8>.size * favoriteBytes.count

let favoriteBytesData = Data(favoriteBytes)

let favoritesByteURL = URL(filePath: "Favorite Bytes", relativeTo: FileManager.documentDirectoryUrl)

try favoriteBytesData.write(to: favoritesByteURL)

let savedFavoriteBytesData = try Data(contentsOf: favoritesByteURL)

let savedFavoriteBytes = Array(savedFavoriteBytesData)

favoriteBytes == savedFavoriteBytes
favoriteBytesData == savedFavoriteBytesData
