//
//  Utils.swift
//  Lake
//
//  Created by Boran Seckin on 2021-01-01.
//

import Foundation

extension Bundle {
    func decodeOld<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(data)")
        }
        
        return decoded
    }
    
    func encode<T: Encodable>(_ type: T.Type, data: T) -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        
        guard let encoded = try? encoder.encode(data) else {
            fatalError("Failed to encode \(data)")
        }
        
        return encoded
    }
}

extension Data {
    // https://gist.github.com/norsez/aa3f11c0e875526e5270e7791f3891fb
    
    static func saveFM(jsonObject: Data, toFilename filename: String) throws -> Bool {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            
            try jsonObject.write(to: fileURL, options: [.atomicWrite])
            return true
        }
        return false
    }
    
    static func loadFM(withFilename filename: String) throws -> Data? {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")

            let data = try Data(contentsOf: fileURL)
            return data
        }
        return nil
    }
}

extension Date {
    func formatShort(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}
