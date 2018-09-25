//
//  ViewController.swift
//  Mobiapps
//
//  Created by Chedi Baccari on 25/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Attributes
    
    private var categoryListViewModel: CategoryListViewModel!
    private var groups = [Group]()
    private let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    //MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startLoading()
        self.categoryListViewModel = CategoryListViewModel({
            self.title = "Categories by group"
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.stopLoading()
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetails" {
            if let destinationVC = segue.destination as? DetailsViewController {
                destinationVC.selectedCategoryViewModel = self.categoryListViewModel.getCategories(ByGroup: self.categoryListViewModel.groupViewModels[(self.tableView.indexPathForSelectedRow?.section)!])[(self.tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
    // Private methods
    
    func startLoading() {
        self.tableView.separatorStyle = .none
        self.activityIndicator.center = self.tableView.center;
        self.activityIndicator.hidesWhenStopped = true;
        self.activityIndicator.style = UIActivityIndicatorView.Style.gray;
        self.tableView.addSubview(self.activityIndicator);
        
        self.activityIndicator.startAnimating();
        UIApplication.shared.beginIgnoringInteractionEvents();
        
    }
    
    func stopLoading(){
        self.tableView.separatorStyle = .singleLine
        self.activityIndicator.stopAnimating();
        UIApplication.shared.endIgnoringInteractionEvents();
        
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoryListViewModel.groupViewModels.count 
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.categoryListViewModel.groupAtIndex(index: section).name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryListViewModel.groupAtIndex(index: section).categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        let group = self.categoryListViewModel.groupAtIndex(index: indexPath.section)
        let categories = self.categoryListViewModel.getCategories(ByGroup: group)
        
        cell.categoryName.text = categories[indexPath.row].name
        cell.categoryIcon.sd_setImage(with: categories[indexPath.row].iconUrl())
        
        return cell
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
