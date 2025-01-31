// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if SKIP

public typealias NSString = kotlin.String
public func NSString(string: String) -> NSString { string }

public func strlen(_ string: String) -> Int {
    return string.count
}

public func strncmp(_ str1: String, _ str2: String) -> Int {
    return str1.toLowerCase() == str2.toLowerCase() ? 0 : 1
}

extension String {
    public var capitalized: String {
        return split(separator: " ", omittingEmptySubsequences: false)
            .joinToString(separator: " ") {
                $0.replaceFirstChar { $0.titlecase() }
            }
    }

    public var deletingLastPathComponent: String {
        let lastSeparatorIndex = lastIndexOf("/")
        if lastSeparatorIndex == -1 || (lastSeparatorIndex == 0 && self.length == 1) {
            return self
        }
        let newPath = substring(0, lastSeparatorIndex)
        let newLastSeparatorIndex = newPath.lastIndexOf("/")
        if newLastSeparatorIndex == -1 {
            return newPath
        } else {
            return newPath.substring(0, newLastSeparatorIndex + 1)
        }
    }

    public func replacingOccurrences(of search: String, with replacement: String) -> String {
        return replace(search, replacement)
    }

    public func components(separatedBy separator: String) -> [String] {
        return Array(split(separator, ignoreCase: false))
    }

    public func trimmingCharacters(in set: CharacterSet) -> String {
        return trim { set.platformValue.contains(UInt32($0.code)) }
    }

    public typealias Encoding = StringEncoding

    public var utf8Data: Data {
        data(using: String.Encoding.utf8) ?? Data()
    }

    public func data(using: StringEncoding, allowLossyConversion: Bool = true) -> Data? {
        return try? Data(platformValue: toByteArray(using.rawValue))
    }

    public var utf8: [UInt8] {
        // TODO: there should be a faster way to convert a string to a UInt8 array
        return Array(toByteArray(StringEncoding.utf8.rawValue).map { it.toUByte() })
    }

    public var utf16: [UInt8] {
        return Array(toByteArray(StringEncoding.utf16.rawValue).map { it.toUByte() })
    }

    public var unicodeScalars: [UInt8] {
        return Array(toByteArray(StringEncoding.utf8.rawValue).map { it.toUByte() })
    }
}

public func String(data: Data, encoding: StringEncoding) -> String? {
    return java.lang.String(data.platformValue, encoding.rawValue) as kotlin.String?
}

public func String(bytes: [UInt8], encoding: StringEncoding) -> String? {
    let byteArray = ByteArray(size: bytes.count) {
         return bytes[$0].toByte()
     }
     return byteArray.toString(encoding.rawValue)
}

public func String(contentsOf: URL) -> String {
    return contentsOf.platformValue.readText()
}

#endif
