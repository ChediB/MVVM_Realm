//
//  Category.swift
//  Mobiapps
//
//  Created by Chedi Baccari on 25/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var categoryDescription: String = ""
    @objc dynamic var order: Int = 0
    @objc dynamic var icon: String = ""
    let achievements: [Int] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case categoryDescription = "description"
        case order
        case icon
        case achievements
    }
}
