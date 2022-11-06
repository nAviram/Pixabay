//
//  APIService.swift
//  GiniApps
//
//  Created by Aviram on 2/11/22.
//

import Foundation
import SwiftUI
import CoreData


class APIService {

    lazy var endPoint: String = { return Constants.baseUrl + "?key=" + Constants.key + "&per_page=50" }()

    //Params:
//    let q = "blue+sky"
    
    func getDataWith(completion: @escaping (Result<ResponseModel>) -> Void) async {
        print(endPoint)
        guard let url = URL(string: endPoint) else {
            print("URL Error!")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }

            guard let data = data else { return }
               do {

                   let response = try JSONDecoder().decode(ResponseModel.self, from: data)
                   
                   DispatchQueue.main.async {
                       
                        completion(.Success(response))
                   }

              } catch let error {
                  return completion(.Error(error.localizedDescription))
              }
        }.resume()
        
        
    }
    
}


enum Result <T>{
    case Success(T)
    case Error(String)
}
