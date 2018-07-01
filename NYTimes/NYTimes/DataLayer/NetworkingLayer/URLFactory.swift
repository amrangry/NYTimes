//
//  URLFactory .swift
//  RealEstate
//
//  Created by Amr ELghadban on 6/14/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

enum URLFactory {
    case getURL(EndPoint, section: String, timePeriod: String)

    enum EndPoint: String {
        case mostviewed
    }

    enum URLFactoryConstantsEnum: String {
        case scheme = "https://"
        case host = "api.nytimes.com"
        case basePathComponents = "/svc/mostpopular/v2/"
        // case path = "/mostviewed/{section}/{time-period}.json"
    }

    var url: URL? {
        switch self {
        case .getURL(let endPonit, let section, let timePeriod):
            guard section.isEmpty == false else {
                assertionFailure("section is mandatory")
                return nil
            }

            guard timePeriod.isEmpty == false else {
                assertionFailure("timePeriod is mandatory")
                return nil
            }

            let url = self.buildURL(parameters: self.mainDomain, endPonit.rawValue, "/\(section)", "/\(timePeriod).json", self.apiKey)

            return url
        }
    }

    var stringPath: String? {
        let url = self.url
        let urlAbsoluteString = url?.absoluteString
        return urlAbsoluteString
    }

    var mainDomain: String {
        let webServicePathURL = URLFactoryConstantsEnum.scheme.rawValue + URLFactoryConstantsEnum.host.rawValue + URLFactoryConstantsEnum.basePathComponents.rawValue
        return webServicePathURL
    }

    var apiKey: String {
//        let base64data = Data(base64Encoded: Constants.APIKey)
//
//        let apiKeyString = String(data: base64data!, encoding: .utf8)!

        let apiKeyString = Constants.APIKey
        return "?api-key=" + apiKeyString
    }

    func buildURL(parameters: String...) -> URL? {
        var urlStringBuilder: String = ""
        for componentPath in parameters {
            urlStringBuilder += componentPath
        }
        guard let allowedURL = urlStringBuilder.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        guard let url = URL(string: allowedURL) else {
            return nil
        }
        return url
    }
}
