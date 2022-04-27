//
//  TableViewCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 04.12.2021.
//

import UIKit
import Hero

class NewsCell: UITableViewCell {
    
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var newsLabel: UILabel!
    @IBOutlet var blur: UIVisualEffectView!
    @IBOutlet var shadowView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        shadowView.makeShadow()
        
        newsImage.heroID = "imageNews"
        newsLabel.heroID = "txtNews"
        blur.heroID = "imageNews"
        
        newsLabel.textColor = .white
        newsImage.layer.cornerRadius = 10
        newsImage.layer.shadowOpacity = 1
        newsImage.layer.shadowRadius = 10
        
        DispatchQueue.main.async {
            self.imageCornerRadius()
        }
        
        
    }
    
    func imageCornerRadius() {
        let path = UIBezierPath(roundedRect: blur.bounds,
                                byRoundingCorners:[.bottomRight, .bottomLeft],
                                cornerRadii: CGSize(width: 10, height:  10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        blur.layer.mask = maskLayer
    }
}

extension UIView {
    func makeShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
    }
}
