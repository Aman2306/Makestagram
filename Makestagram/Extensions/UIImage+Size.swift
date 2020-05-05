//
//  UIImage+Size.swift
//  Makestagram
//
//  Created by Aman Meena on 05/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import UIKit

extension UIImage {
    var aspectHeight: CGFloat {
        let heightRatio = size.height / 736 // it calculates aspect ratio from 7 plus perspective
        let widthRatio = size.width / 414
        let aspectRatio = fmax(heightRatio, widthRatio)

        return size.height / aspectRatio
    }
}
