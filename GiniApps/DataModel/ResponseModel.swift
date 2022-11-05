//
//  ResponseModel.swift
//  GiniApps
//
//  Created by Aviram on 2/11/22.
//

import Foundation

struct ResponseModel: Codable {
    
    var total: Int
    var totalHits: Int
    var hits: [Hit]
    
}
