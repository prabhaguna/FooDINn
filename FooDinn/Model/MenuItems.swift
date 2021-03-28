//
//  MenuItems.swift
//  FooDinn
//
//  Created by Prabhakaran on 23/03/21.
//

import Foundation
import ObjectMapper

class MenuItems : Mappable, Equatable {

    var id : Int?
    var name : String?
    var ingredients : [String]?
    var weight : String?
    var size : String?
    var price : Int?
    var currency : String?
    var img : String?
    var category : [String]?
    
    //
    var OrderedCount : Int = 0
    
    required init(map: Map) {
        
    }
    
    func mapping(map : Map) {
        id <- map["id"]
        name <- map["name"]
        ingredients <- map["ingredients"]
        weight <- map["weight"]
        size <- map["size"]
        price <- map["price"]
        currency <- map["currency"]
        img <- map["img"]
        category <- map["category"]
    }
    
   static func == (lhs: MenuItems, rhs: MenuItems) -> Bool {
        return lhs.id == rhs.id
   }
    
}

class MenuItemsResponse: Mappable {
    var items: [MenuItems]?
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        items <- map["menuItems"]
    }
}
