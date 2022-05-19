//
//  InfoCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 07.05.2022.
//

import UIKit

class InfoCell: UITableViewCell {
    
    var leftLabel = UILabel()
    var rightLabel = UILabel()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
            self.leftLabel.numberOfLines = 0
            self.rightLabel.numberOfLines = 0

    }
    
    
    func UIfontLabel(label: UILabel, font: String, viewHeight: Double, size: CGFloat) {
        switch viewHeight {
        case 548.0...568.0:
            label.font = UIFont(name:  font, size: size + 2)//iPhone 5S,SE
        case 647.0...667.0:
            label.font = UIFont(name:  font, size: size + 2)//iPhone 6,7,8
        case 716.0...736.0:
            label.font = UIFont(name:  font, size: size + 4)//iPhone 6+,7+,8+
        case 792...812.0:
            label.font = UIFont(name:  font, size: size + 4)//iPhone X,XS,XR
        case 876.0...896.0:
            label.font = UIFont(name:  font, size: size + 6)//iPhone XS_Max
        default: print("_____")
        }
    }

    
}

