//
//  Api.swift
//  Weather
//
//  Created by HeinHtet on 9/14/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    static let instance = Api()
    
    func request (lat : Double,lon : Double, loading : @escaping  loading,error : @escaping  error , success : @escaping success){
        loading(true)
        let urlLatLon = "\(url)&lat=\(lat)&lon=\(lon)"
        Alamofire.request(urlLatLon, method: .get, parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON { (response) in
            if (response.result.isSuccess){
                let decoder = JSONDecoder()
                do{
                    if let result = response.data{
                        let response = try decoder.decode(Weather.self, from: result)
                        response.list.forEach({ (data) in
        
                            
                    })
                        success(response)
                    }
                }catch {
                    debugPrint("decode error \(String(error.localizedDescription))")
                }
            }else{
                debugPrint("error \(String(describing: response.error?.localizedDescription))")
                error(response.error)
            }
            loading(false)
        }
    }
}
