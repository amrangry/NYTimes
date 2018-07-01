//
//  URLSessionManager.swift
//  RealEstate
//
//  Created by Amr ELghadban on 6/14/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

class URLSessionManager {
    // SingleTon Varible for accessing the class.
    static let share: URLSessionManager = URLSessionManager()

    // This prevents others from using the default '()' initializer for this class.
    private init() {
    }

    // MARK: - Helper Methods

    func errorMapping(_ errorRaw: Error) -> NetworkErrorCodeForResponse {
        if let error = errorRaw as? URLError {
            debugPrint("URLError occurred: \(error)")
            return NetworkErrorCodeForResponse.noInternet
        } else {
            debugPrint("Unknown error: \(errorRaw)")
            return NetworkErrorCodeForResponse.errorStatus
        }
    }

    func createRequest(url: URL, forceUpdate: Bool) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: forceUpdate ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad, timeoutInterval: 10)

        // All app requests are GET, and expect JSON response
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        return request
    }

    func invokeAPI(_ url: URL, completionHandler: @escaping (NetworkResult<Any>) -> Void) {
        let defaultConfigObject = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: defaultConfigObject)

        let urlRequest = createRequest(url: url, forceUpdate: false)

        let task = defaultSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard error == nil && data != nil else {
                completionHandler(NetworkResult.failure(.noInternet))
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                do {
                    guard let responseObj = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary else {
                        completionHandler(NetworkResult.failure(.errorStatus))
                        return
                    }

                    print("*** parsed date as NSDictiornary : ", responseObj)

                    DispatchQueue.main.async {
                        completionHandler(NetworkResult.success(responseObj))
                    }

                } catch {
                    DispatchQueue.main.async {
                        completionHandler(NetworkResult.failure(.errorStatus))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(NetworkResult.failure(.errorStatus))
                }
            }
        })
        task.resume()
    }
}
