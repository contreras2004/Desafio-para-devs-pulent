//
//  NetworkingManager.swift
//  Pulent
//
//  Created by Matías Contreras Selman on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkingManager{
    
    //we define this function as a generic so we dont have to do the same for each object type that we need to fetch from the server
    func request<T: Codable>(endpoint: Endpoint, completionHandler : @escaping (T?, Error?) -> ()) {
       
        let url = urlWithParams(endpoint: endpoint)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.timeoutInterval = 10.0
   
        Alamofire.request(urlRequest).responseData { (response) in
            switch response.result {
            case .success:
                
                //lets print the data in human redable to see if it is correct
                //let humanRedableResponse = "\(String(data: response.data!, encoding: String.Encoding.utf8))..."
                //debugPrint("The response is: \(humanRedableBodyParams)")
                
                if let data = response.data{
                    
                    let decoder = JSONDecoder()
                    //add the dateFormat decoding strategy if there is any format on the class of the object
                    if let dateFormatProtocol = T.self as? DateFormatProtocol.Type {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = dateFormatProtocol.dateFormat
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    }
                    
                    do{
                        let decodedData = try decoder.decode(T.self, from: data)
                        //save to local cache
                        //self.dataManager.save(object: decodedData)
                        
                        completionHandler(decodedData, nil)
                        return
                    }
                    catch{
                        debugPrint("Error while trying to decode response: \(error)")
                        completionHandler(nil, error)
                    }
                }
                
            case .failure(let error):
                debugPrint("Error in networking request: \(error)")
                completionHandler(nil, error)
                
            }
            return
        }
        
    }
    
    func urlWithParams(endpoint: Endpoint) -> URL{
        var urlComponents = endpoint.server.urlComponents
        urlComponents.path = "/\(endpoint.api.rawValue)"
        
        if let params = try? endpoint.urlParams?.asDictionary(){
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in params ?? [:] {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems!.append(queryItem)
            }
        }
        
        return urlComponents.url!
    }
}
