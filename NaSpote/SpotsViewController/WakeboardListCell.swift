//
//  WakeboardListCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 03.05.2022.
//

import UIKit
import Cosmos

class WakeboardListCell: UITableViewCell {

    var shadowView = UIView()
    var logo = UIImageView()
    var title = UILabel()
    var location = UILabel()
    var locationImage = UIImageView()
    var rating = CosmosView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        rating.translatesAutoresizingMaskIntoConstraints = false
        
        
        shadowView.backgroundColor = .white
        rating.settings.updateOnTouch = false
        location.numberOfLines = 0
        
        shadowView.makeShadow()
        
        logo.contentMode = .scaleAspectFill
        
        DispatchQueue.main.async {
            self.logo.layer.borderWidth = 0.5
            self.logo.layer.cornerRadius = self.logo.frame.height / 2
            self.logo.clipsToBounds = true
        }
        
       
    }
    
    func UIfontLabel(label: UILabel, font: String, viewHeight: Double, size: CGFloat) {
        switch viewHeight {
        case 548.0...568.0:
            label.font = UIFont(name:  font, size: size)//iPhone 5S,SE
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
