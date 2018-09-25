//
//  CategoryListViewModel.swift
//  Mobiapps
//
//  Created by Chedi Baccari on 25/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation

//MARK: - CategoryListViewModel

class CategoryListViewModel {
    
    //MARK: - Attributes
    
    var categoryViewModels: [CategoryViewModel] = [CategoryViewModel]()
    var groupViewModels: [GroupViewModel] = [GroupViewModel]()
    private var completionHandler: () -> () = {}
    
    //MARK: - Constructor
    
    init(_ completion: @escaping () -> Void) {
        self.completionHandler = completion
        self.populateCategories()
    }
    
    //MARK: - Public Methods
    
    func getCategories(ByGroup group: GroupViewModel) -> [CategoryViewModel] {
        var categories = [CategoryViewModel]()
        
        for category in self.categoryViewModels {
            if group.categories.contains(category.id) {
                categories.append(category)
            }
        }
        
        return categories
    }
    
    func categoryAtIndex(index: Int) -> CategoryViewModel {
        return self.categoryViewModels[index]
    }
    
    func groupAtIndex(index: Int) -> GroupViewModel {
        return self.groupViewModels[index]
    }
    
    //MARK: - Private Methods
    
    func populateCategories() {
        DataProvider.shared.getAllCategories { (categories) in
            self.categoryViewModels = categories.map(CategoryViewModel.init)
            self.populateGroups()
        }
    }
    func populateGroups() {
        DataProvider.shared.getAllGroups { (groups) in
            self.groupViewModels = groups.map(GroupViewModel.init)
            DispatchQueue.main.async {
                self.completionHandler()
            }
        }
    }
}

//MARK: - CategoryViewModel

class CategoryViewModel {
    
    var id: Int
    var name: String
    var description: String
    var order: Int
    var icon: String
    var achievements: [Int] = []
    
    init(category: Category) {
        self.id = category.id
        self.name = category.name
        self.description = category.categoryDescription
        self.order = category.order
        self.icon = category.icon
    }
    
    func iconUrl() -> URL {
        return URL(string: self.icon)!
    }
}

//MARK: - GroupViewModel

class GroupViewModel {
    
    var id: String
    var name: String
    var description: String
    var order: Int
    var categories: [Int]
    
    init(group: Group) {
        self.id = group.id
        self.name = group.name
        self.description = group.groupDescription
        self.order = group.order
        self.categories = []
        for id in group.categoryIdsObjects {
            self.categories.append(id.id)
        }
    }
}
