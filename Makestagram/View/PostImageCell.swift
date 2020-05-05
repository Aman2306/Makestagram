//
//  PostImageCell.swift
//  Makestagram
//
//  Created by Aman Meena on 05/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import UIKit

class PostImageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK:- IBOutlets
    
    @IBOutlet weak var postImageView: UIImageView!
    
}
