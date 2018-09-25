//
//  Group.swift
//  Mobiapps
//
//  Created by Chedi Baccari on 25/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation
import RealmSwift

class Group: Object, Codable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var groupDescription: String = ""
    @objc dynamic var order: Int = 0
    var categoryIdsObjects = List<CategoryId>()
    var categoriesIds: [Int] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case groupDescription = "description"
        case order  
        case categoriesIds = "categories"
    }
}

class CategoryId: Object {
    @objc dynamic var id: Int = 0
}
