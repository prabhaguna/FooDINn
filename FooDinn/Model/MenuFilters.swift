//
//  MenuFilters.swift
//  FooDinn
//
//  Created by Prabhakaran on 23/03/21.
//

import Foundation
import ObjectMapper

class MenuFilters : Mappable {
    var id : Int?
    var name : String?
    
    required init(map: Map) {
        
    }
    
    func mapping(map : Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

class MenuFiltersResponse: Mappable {
    var items: [MenuFilters]?
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        items <- map["filters"]
    }
}
