//
//  NetworkingService.swift
//  Mobiapps
//
//  Created by Chedi Baccari on 25/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation

private let urlGroupsString = "https://api.guildwars2.com/v2/achievements/groups"
private let urlCategoriesString = "https://api.guildwars2.com/v2/achievements/categories"

class NetworkingService {
    
    //MARK: - Shared instance of NetworkingService
    
    static let shared = NetworkingService()
    
    //MARK: - Public methods
    
    func getAllGroupsFromCloud(completion: @escaping ([Group]) -> ()) {
        getAllGroupsId { (ids) in
            var groups = [Group]()
            
            for (index, id) in ids.enumerated() {
                self.getGroup(byId: id, completion: { (group) in
                    groups.append(group)
                    
                    if index == ids.count - 1 {
                        DispatchQueue.main.async {
                            completion(groups)
                        }
                    }
                })
            }
        }
    }
    
    func getAllCategoriesFromCloud(completion: @escaping ([Category]) -> ()) {
        getAllCategoriesIds { (ids) in
            var categories = [Category]()
            
            for (index, id) in ids.enumerated() {
                self.getCategory(byId: id, completion: { (category) in
                    categories.append(category)
                    
                    if index == ids.count - 1 {
                        DispatchQueue.main.async {
                            completion(categories)
                        }
                    }
                })
            }
        }
    }
    
    //MARK: - Private methods
    
    // Get all groups ids
    private func getAllGroupsId(completion: @escaping ([String]) -> ()) {
        
        URLSession.shared.dataTask(with: URL(string: urlGroupsString)!) { (data, urlResponse, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: invalid HTTP response code")
                return
            }
            guard let dataContent = data else {
                print("Error: missing data")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: dataContent, options: [])
                let dictionaries = json as! [String]
                DispatchQueue.main.async {
                    completion(dictionaries)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    //get group by id
    private func getGroup(byId id: String, completion: @escaping (Group) -> ()) {
        URLSession.shared.dataTask(with: URL(string: urlGroupsString + "/\(id)")!) { (data, urlResponse, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: invalid HTTP response code")
                return
            }
            guard let dataContent = data else {
                print("Error: missing data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let group = try decoder.decode(Group.self, from: dataContent)
                DispatchQueue.main.async {
                    completion(group)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    // Get all categories ids
    private func getAllCategoriesIds(completion: @escaping ([Int]) -> ()) {
        
        URLSession.shared.dataTask(with: URL(string: urlCategoriesString)!) { (data, urlResponse, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: invalid HTTP response code")
                return
            }
            guard let dataContent = data else {
                print("Error: missing data")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: dataContent, options: [])
                let dictionaries = json as! [Int]
                DispatchQueue.main.async {
                    completion(dictionaries)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
            }.resume()
    }
    
    //Get category by id
    private func getCategory(byId id: Int, completion: @escaping (Category) -> ()) {
        URLSession.shared.dataTask(with: URL(string: urlCategoriesString + "/\(id)")!) { (data, urlResponse, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: invalid HTTP response code")
                return
            }
            guard let dataContent = data else {
                print("Error: missing data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let category = try decoder.decode(Category.self, from: dataContent)
                DispatchQueue.main.async {
                    completion(category)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
            }.resume()
    }
}
