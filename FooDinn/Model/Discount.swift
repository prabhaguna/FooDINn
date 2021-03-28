//
//  Discount.swift
//  FooDinn
//
//  Created by Prabhakaran on 23/03/21.
//

import Foundation
import ObjectMapper

class Discount : Mappable {
    var id : Int?
    var name : String?
    var desc : String?
    var img : String?
    
    required init(map: Map) {
        
    }
    
    func mapping(map : Map) {
        id <- map["id"]
        name <- map["name"]
        desc <- map["desc"]
        img <- map["img"]
    }
}

class DiscountResponse: Mappable {
    var items: [Discount]?
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        items <- map["discount"]
    }
}
