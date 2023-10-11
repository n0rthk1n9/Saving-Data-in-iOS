import Foundation

public extension FileManager {
    static var documentDirectoryUrl: URL {
        `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
