//
//  DetailsViewController.swift
//  Mobiapps
//
//  Created by Chedi Baccari on 25/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    //MARK: - IBOutlet
 
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var caegoryImageView: UIImageView!
    
    //MARK: - Attributes
    
    var selectedCategoryViewModel: CategoryViewModel!
    
    //MARK: - DetailsViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.descriptionLabel.transform = .identity
            self.orderLabel.transform = .identity
            self.caegoryImageView.transform = .identity
        })
    }
    //MARK: - Private methods
    
    private func initViews() {
        self.title = self.selectedCategoryViewModel.name
        if self.selectedCategoryViewModel.description.isEmpty {
            self.descriptionLabel.text = "Description: No description"
        } else {
            self.descriptionLabel.text = "Description: \(self.selectedCategoryViewModel.description)"
        }
        self.descriptionLabel.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        self.orderLabel.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        self.orderLabel.text = "Order: \(String(self.selectedCategoryViewModel.order))"
        
        self.caegoryImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        self.caegoryImageView.sd_setImage(with: self.selectedCategoryViewModel.iconUrl())
        
        // Add share button to navigation bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share))
    }
    
    @objc func share() {
        let text = "Description: \(self.selectedCategoryViewModel.description) \n Order: \(self.selectedCategoryViewModel.order)"
        let image = self.caegoryImageView.image
        let shareAll = [text , image!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
