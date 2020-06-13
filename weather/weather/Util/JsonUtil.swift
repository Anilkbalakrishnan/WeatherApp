//
//  JsonUtil.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation

extension Data {
    func decodeJSON<T: Decodable>() -> T? {
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            return try jsonDecoder.decode(T.self, from: self)
        } catch {
            print("Error occured in Decoding of json to \(T.self) : \(error)")
        }
        return nil
    }
}
