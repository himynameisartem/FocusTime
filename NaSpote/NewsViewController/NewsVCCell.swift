//
//  TestNewsVCCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 01.05.2022.
//

import UIKit

class NewsVCCell: UITableViewCell {
    
    var shadowView = UIView()
    var newsImage = UIImageView()
    var newsLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.cornerRadius = 10
        shadowView.layer.borderWidth = 0.5
        shadowView.backgroundColor = .white
        
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.numberOfLines = 0
        newsImage.contentMode = .scaleAspectFill
        
        DispatchQueue.main.async {
            self.imageCornerRadius()
        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func imageCornerRadius() {
        let path = UIBezierPath(roundedRect: newsImage.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 10, height:  10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        newsImage.layer.mask = maskLayer
    }
    
}

extension UILabel {
    func UIfontLabel(viewHeight: Double) {
        switch viewHeight {
        case 548.0...568.0:
            self.font = UIFont(name:  "Helvetica", size: 11)//iPhone 5S,SE
        case 647.0...667.0:
            self.font = UIFont(name:  "Helvetica", size: 14)//iPhone 6,7,8
        case 716.0...736.0:
            self.font = UIFont(name:  "Helvetica", size: 16)//iPhone 6+,7+,8+
        case 792...812.0:
            self.font = UIFont(name:  "Helvetica", size: 16)//iPhone X,XS,XR
        case 876.0...896.0:
            self.font = UIFont(name:  "Helvetica", size: 18)//iPhone XS_Max
        default: print("_____")
        }
    }
}

extension UIView {
    func makeShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 7
    }
}
