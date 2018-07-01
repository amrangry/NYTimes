//
//  DataManager.swift
//  RealEstate
//
//  Created by Amr ELghadban on 6/14/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class DataManager {
    static func getNYTimesArticles(completionHandler: @escaping (_ isSuccess: Bool, _ status: ResponseStatus, _ result: [Displayable]?) -> Void) {
        ProgressLoader.show()

        BackendAPI.getNYTimesArticles { result in
            ProgressLoader.dismiss()
            debugPrint(result)
            switch result {
            case .success(let value):
                guard let jsonData = Data.convertToData(value) else {
                    completionHandler(false, ResponseStatus.errorInParsingResponse, nil)
                    return
                }

                guard let mostViewedResponseResult = MostViewedResponse.decodeJsonData(parcelable: MostViewedResponse(), jsonData, isObject: true) as? MostViewedResponse else {
                    completionHandler(false, ResponseStatus.errorInParsingResponse, nil)
                    return
                }

                guard let result = mostViewedResponseResult.results, result.isEmpty == false else {
                    completionHandler(false, ResponseStatus.notFound, nil)
                    return
                }

                completionHandler(true, ResponseStatus.success, result)

            case .failure(let error):
                let failureObject = failureErrorCompletionHandler(error: error)
                completionHandler(failureObject.0, failureObject.1, nil)
            }
        }
    }
}

extension DataManager {
    static func failureErrorCompletionHandler(error: NetworkErrorCodeForResponse) -> (Bool, ResponseStatus, String) {
        switch error {
        case .errorInParsingResponse:
            return (false, ResponseStatus.errorInParsingResponse, "Connection error")
        case .errorStatus:
            return (false, ResponseStatus.errorStatus, "Can't Parse")
        case .noInternet:
            return (false, ResponseStatus.connectionError, "Connection error")
        }
    }
}
