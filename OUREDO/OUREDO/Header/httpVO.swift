//
//  signUpVO.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/01.
//

import Foundation
import Alamofire

protocol HTTPClientProvider {
    func get(url : String, params : Parameters?, header : HTTPHeaders) -> DataRequest
    func post(url : String, params : Parameters?, header : HTTPHeaders) -> DataRequest
    func delete(url : String, params : Parameters?, header : HTTPHeaders) -> DataRequest
}

class HTTPClient : HTTPClientProvider {
    func get(url: String, params: Parameters?, header: HTTPHeaders) -> DataRequest {
        return AF.request(baseURL + url,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding.default,
                          headers: header,
                          interceptor: nil)
    }
    
    func post(url: String, params: Parameters?, header: HTTPHeaders) -> DataRequest {
        return AF.request(baseURL + url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.prettyPrinted,
                          headers: header,
                          interceptor: nil)
    }
    
    func delete(url: String, params: Parameters?, header: HTTPHeaders) -> DataRequest {
        return AF.request(baseURL + url,
                          method: .delete,
                          parameters: params,
                          encoding: JSONEncoding.prettyPrinted,
                          headers: header,
                          interceptor: nil)
    }
    
    let baseURL = "http://43.200.97.218:8080"//api입력
    
}
