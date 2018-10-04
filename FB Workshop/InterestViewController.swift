//
//  InterestViewController.swift
//  FB Workshop
//
//  Created by Adithya Narasinghe on 10/4/18.
//  Copyright © 2018 DevCColombo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialChips


class InterestViewController: UIViewController {
    
    let interests = ["Technology", "Business", "Politics", "Entertainement", "Bitcoin", "AI", "Music", "Hollywood", "Bollywood", "F1", "Venom", "Jon Snow", "Australia", "Apple", "Android", "Facebook", "Developers"]
    
    @IBOutlet weak var cvInterestContainer: UICollectionView!
    var selectedInterest = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cvInterestContainer.delegate = self
        self.cvInterestContainer.dataSource = self
        self.cvInterestContainer.register(MDCChipCollectionViewCell.self, forCellWithReuseIdentifier: "interestChip")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNews" {
            if let viewController = segue.destination as? NewsViewController {
                viewController.setup(interest: self.selectedInterest)
            }
        }
    }
    
    
}

extension InterestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: MDCChipCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "interestChip", for: indexPath) as? MDCChipCollectionViewCell
        if cell == nil {
            cell = MDCChipCollectionViewCell.init()
        }
        let chip = cell?.chipView
        chip?.setTitleColor(UIColor.white, for: .normal)
        chip?.setBackgroundColor(UIColor(red:0.00, green:0.52, blue:1.00, alpha:1.0), for: .normal)
        chip?.titleLabel.text = interests[indexPath.row]
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        self.selectedInterest = interests[indexPath.row]
        performSegue(withIdentifier: "showNews", sender: nil)
    }
    
}
