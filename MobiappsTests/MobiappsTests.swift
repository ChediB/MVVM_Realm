//
//  MobiappsTests.swift
//  MobiappsTests
//
//  Created by Chedi Baccari on 25/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import XCTest

@testable import Mobiapps

class MobiappsTests: XCTestCase {
    var categoryListViewModel: CategoryListViewModel!

    func testgetGroupsInViewModelNotEmpty() {
        let promise = expectation(description: "Groups is not empty")
        
        self.categoryListViewModel = CategoryListViewModel({
            if self.categoryListViewModel.groupViewModels.count > 0 {
                promise.fulfill()
            } else {
                XCTFail("Groups is empty")
            }
        })
        
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testgetCategoriesInViewModelNotEmpty() {
        let promise = expectation(description: "Categories is not empty")
        
        self.categoryListViewModel = CategoryListViewModel({
            if self.categoryListViewModel.groupViewModels.count > 0 {
                promise.fulfill()
            } else {
                XCTFail("Categories is empty")
            }
        })
        
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
