//
//  Client.swift
//  Tutorial
//
//  Created by Fernando Mazzon on 9/9/16.
//  Copyright © 2016 Fer662. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

internal enum Router: URLRequestConvertible {
    
    case Posts
    
    var method: Alamofire.Method {
        switch self {
        case .Posts:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .Posts:
            return "newapi/products"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: "https://preprod.fotosprint.com")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        //let baseParams: [String:String] = [:]
        /*
         if let token = keychain["token"] {
         baseParams["token"] = token
         }*/
        
        switch self {
        case .Posts:
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: [:]).0
        }
    }
}

class Client {
    
    private let manager: Manager
    
    static var sharedInstance: Client = Client()
    
    init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        manager = Manager(configuration: configuration)
    }
/*
    func errorFromJSON(json: JSON) -> NSError {
        if let errors = json["errors"].arrayObject as? [String] {
            if let firstError = errors.first {
                return NSError(domain: "FotoSprintErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: firstError.stringByDecodingHTMLEntities()])
            }
        }
        else if let errorsDictionary = json["errors"].dictionaryObject as? [String: String] {
            var error = ""
            for key in errorsDictionary.keys {
                error += errorsDictionary[key]!.stripHTML().capitalizedString + "\n"
            }
            return NSError(domain: "FotoSprintErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: error.stringByDecodingHTMLEntities().capitalizedString])
        }
        return NSError(domain: "FotoSprintErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Unknown error", comment: "Unknown API error")])
    }*/
    
    func getPosts(completion: (json: JSON) -> Void ) {
        Alamofire.request(Router.Posts).validate().responseJSON { (response) in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                completion(json: json)
                break
            case .Failure:
                break
            }
        }
    }
}
