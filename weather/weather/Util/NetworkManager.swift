//
//  NetworkManager.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func HttpDataRequest(url: String, httpMethod: HttpMethod, data jsonBody: Data?, completionHandler: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let nsurl = NSURL(string: url) as URL? else { return }
        let request: NSMutableURLRequest = NSMutableURLRequest(url:nsurl)
        request.httpMethod = httpMethod.rawValue
        if let jsonRequest = jsonBody {
            request.httpBody = jsonRequest
        }
        self.setBasicHeaders(request)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error -> Void in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if let responseData = data {
                            self.printJsonResponse(url: url, responseData)
                            completionHandler(.success(responseData))
                        }
                    }else if httpResponse.statusCode == 401 {
                        completionHandler(.failure(.unauthorized))
                    }
                }
            }else {
                print("Request Failed: \(url) with error : \(error)")
                completionHandler(.failure(.invalid))
            }
        })
        task.resume()
    }
}


extension NetworkManager {
    
    fileprivate func setBasicHeaders(_ request: NSMutableURLRequest) {
        request.addValue(self.getHeaderValuefor(headerKey: .contentType), forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
    }
    
    fileprivate func getHeaderValuefor( headerKey: HttpHeaderField) -> String {
        switch headerKey {
        case .contentType: return HttpHeaderFieldValue.contentTypeJson.rawValue
        }
    }
    
    fileprivate func printJsonResponse(url: String, _ responseData: Data) {
          let responseDataEncoded = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue)
          let responsDataString: String = responseDataEncoded! as String
          print("Request: \(url)")
          print("Response: \(responsDataString)")
      }
}

enum HttpMethod: String {
    case GET
    case POST
}

enum HttpHeaderField: String {
    case contentType = "Content-Type"
}

enum HttpHeaderFieldValue: String {
    case contentTypeJson = "application/json"
}
enum NetworkError: Error{
    case invalid
    case unauthorized
}



