//
//  PostActionsCell.swift
//  Makestagram
//
//  Created by Aman Meena on 05/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import UIKit

class PostActionCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Properties
    
    static let cellHeight: CGFloat = 46
    

    // MARK:- IBOutlets
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    
    // MARK:- IBActions
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        print("like button tapped")
    }
}
