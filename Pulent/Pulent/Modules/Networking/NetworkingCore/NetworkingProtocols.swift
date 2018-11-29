//
//  NetworkingProtocols.swift
//  Pulent
//
//  Created by Matías Contreras on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import Alamofire
import Foundation

//This lets us configure many servers if there will be more than 1
//the sample URL is: https://itunes.apple.com/search?term=in+utero&mediaType=music&limit=20

protocol Server{
    var urlComponents: URLComponents {get}
}

protocol Endpoint {
    var server : Server{get}
    var api : Api {get}
    var method : HTTPMethod {get}
    var urlParams: Codable? {get set}
}

//define the dateformat protocol so we can decode objects with diferent dateFormats
protocol DateFormatProtocol {
    static var dateFormat: String { get }
}

protocol CodableWithDateFormat: Codable, DateFormatProtocol {}

extension CodableWithDateFormat {
    public static var dateFormat: String { return "yyyy-MM-dd'T'HH:mm:ssZ" }
}

/*We can use this protocol by defining a structure the way it is below, if the dateformat is not overwritten
 then it will fall back to the default dateformat defined in the extension of the protocol*/

/*
 struct ExampleStruct: CodableWithDateFormat {
    public static var dateFormat: String { return "Overwritten Date Format" }
 
    let prop1: String
    let prop2: Int
}
 */
