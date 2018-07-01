//
//  AlamofireManager.swift
//  NYTimes
//
//  Created by Amr ELghadban on 6/30/18.
//  Copyright © 2018 ADKA. All rights reserved.
//
import Foundation
import Alamofire
/// Class responsible to call teh networklayer and return back with response result
class AlamofireManager {
        // MARK: - properites
    var requestTimeout: TimeInterval = 60.0
    var commanParameters: Parameters = [:]
    var commanHttpHeader: HTTPHeaders = [:]

    /// SingleTon Varible for accessing the class.
    static let share: AlamofireManager = AlamofireManager()

    /// This prevents others from using the default '()' initializer for this class.
    private init() {
        commanHttpHeader.updateValue("application/json", forKey: "Accept")
        commanHttpHeader.updateValue("application/x-www-form-urlencoded", forKey: "Content-Type")
    }

    func InvokeURLRequest(request: URLRequest, completionHandler: @escaping (NetworkResult<Any>) -> Void) {
        if NetworkReachabilityManager()!.isReachable == false {
            completionHandler(NetworkResult.failure(.noInternet))
            return
        }
        Alamofire.request(request).validate(statusCode: 200..<300).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let _value):
                completionHandler(NetworkResult.success(_value))
            case .failure(let _error):
                let networkError = self.ErrorMapping(_error)
                completionHandler(NetworkResult.failure(networkError))
            }
        }
    }

    func InvokeGetURL(urlString: String, parameters: Parameters?, httpHeader: HTTPHeaders?, completionHandler: @escaping (NetworkResult<Any>) -> Void) {
        if NetworkReachabilityManager()!.isReachable == false {
            completionHandler(NetworkResult.failure(.noInternet))
            return
        }

        if httpHeader != nil {
            for item in httpHeader! {
                commanHttpHeader.updateValue(item.value, forKey: item.key)
            }
        }
        debugPrint(commanHttpHeader)
        if parameters != nil {
            for item in parameters! {
                commanParameters.updateValue(item.value, forKey: item.key)
            }
        }
        debugPrint(commanParameters)

        Alamofire.request(urlString, method: HTTPMethod.get, parameters: commanParameters, encoding: URLEncoding.default, headers: commanHttpHeader).validate(statusCode: 200..<300).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let _value):
                completionHandler(NetworkResult.success(_value))
            case .failure(let _error):
                let networkError = self.ErrorMapping(_error)
                completionHandler(NetworkResult.failure(networkError))
            }
        }
    }

    func InvokePostURL(urlString: String, parameters: Parameters?, httpHeader: HTTPHeaders?, completionHandler: @escaping (NetworkResult<Any>) -> Void) {
        if NetworkReachabilityManager()!.isReachable == false {
            completionHandler(NetworkResult.failure(.noInternet))
            return
        }

        if httpHeader != nil {
            for item in httpHeader! {
                commanHttpHeader.updateValue(item.value, forKey: item.key)
            }
        }
        debugPrint(commanHttpHeader)

        if parameters != nil {
            for item in parameters! {
                commanParameters.updateValue(item.value, forKey: item.key)
            }
        }
        debugPrint(commanParameters)

        Alamofire.request(urlString, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.httpBody, headers: commanHttpHeader).validate(statusCode: 200..<300).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let _value):
                completionHandler(NetworkResult.success(_value))
            case .failure(let _error):
                let networkError = self.ErrorMapping(_error)
                completionHandler(NetworkResult.failure(networkError))
            }
        }
    }
}

extension AlamofireManager {
    // MARK: - Helper methods
    func createRequest(urlString: String, forceUpdate: Bool) -> URLRequest? {
        guard let allowedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        guard let url = URL(string: allowedURL) else {
            return nil
        }
        return createRequest(url: url, forceUpdate: forceUpdate)
    }

    func createRequest(url: URL, forceUpdate: Bool) -> URLRequest? {
        var request = URLRequest(url: url, cachePolicy: forceUpdate ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad, timeoutInterval: requestTimeout)

        // All app requests are GET, and expect JSON response
        request.httpMethod = "GET"

        for header in commanHttpHeader {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        return request
    }

    func ErrorMapping(_ errorRaw: Error) -> NetworkErrorCodeForResponse {
        if let error = errorRaw as? AFError {
            switch error {
            case .invalidURL(let url):
                debugPrint("Invalid URL: \(url) - \(error.localizedDescription)")
                return NetworkErrorCodeForResponse.noInternet
            case .parameterEncodingFailed(let reason):
                debugPrint("Parameter encoding failed: \(error.localizedDescription)")
                debugPrint("Failure Reason: \(reason)")
                return NetworkErrorCodeForResponse.errorStatus
            case .multipartEncodingFailed(let reason):
                debugPrint("Multipart encoding failed: \(error.localizedDescription)")
                debugPrint("Failure Reason: \(reason)")
                return NetworkErrorCodeForResponse.errorStatus
            case .responseValidationFailed(let reason):
                debugPrint("Response validation failed: \(error.localizedDescription)")
                debugPrint("Failure Reason: \(reason)")
                return NetworkErrorCodeForResponse.errorInParsingResponse
            case .responseSerializationFailed(let reason):
                debugPrint("Response serialization failed: \(error.localizedDescription)")
                debugPrint("Failure Reason: \(reason)")
                return NetworkErrorCodeForResponse.errorInParsingResponse
            }

        } else if let error = errorRaw as? URLError {
            debugPrint("URLError occurred: \(error)")
            return NetworkErrorCodeForResponse.noInternet
        } else {
            debugPrint("Unknown error: \(errorRaw)")
            return NetworkErrorCodeForResponse.errorStatus
        }
    }
}
