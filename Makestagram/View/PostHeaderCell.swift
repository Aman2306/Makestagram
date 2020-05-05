//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Aman Meena on 05/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Properties
    
    static let cellHeight: CGFloat = 54
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    // MARK:- IBActions
    
    @IBAction func optionsButtonTapped(_ sender: UIButton) {
        print("options button tapped")
    }
    
    
}
