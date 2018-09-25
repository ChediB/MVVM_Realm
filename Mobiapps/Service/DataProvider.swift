//
//  DataProvider.swift
//  Mobiapps
//
//  Created by Chedi Baccari on 25/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation
import RealmSwift

class DataProvider {
    
    let realm = try! Realm()
    
    //MARK: - Shared instance of NetworkingService
    
    static let shared = DataProvider()
    
    //MARK: - Public methods
    
    // get All groups
    func getAllGroups(completion: @escaping ([Group]) -> ()) {
        // get data from data base
        let groups = Array(realm.objects(Group.self))
        
        // if datat is empty, get data from server
        if groups.count > 0 {
            completion(groups)
        } else {
            NetworkingService.shared.getAllGroupsFromCloud { (groups) in
                
                try! self.realm.write {
                    for group in groups {
                        for id in group.categoriesIds {
                            let categoryId = CategoryId()
                            categoryId.id = id
                            group.categoryIdsObjects.append(categoryId)
                        }
                        self.realm.add(group)
                    }
                }
                completion(groups)
            }
        }
    }
    
    // get All categories
    func getAllCategories(completion: @escaping ([Category]) -> ()) {
        // get data from data base
        let categories = Array(realm.objects(Category.self))
        
        if categories.count > 0 {
            completion(categories)
        } else {
            NetworkingService.shared.getAllCategoriesFromCloud { (categories) in
                try! self.realm.write {
                    self.realm.add(categories)
                }
                completion(categories)
            }
        }
    }
}
