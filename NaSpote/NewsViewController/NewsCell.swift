//
//  TableViewCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 04.12.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var newsLabel: UILabel!
    @IBOutlet var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        shadowView.layer.cornerRadius = 5
        shadowView.makeShadow()
        imageCornerRadius()
    }

    func imageCornerRadius() {
        let path = UIBezierPath(roundedRect:newsImage.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 5, height:  5))

        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        newsImage.layer.mask = maskLayer

    }
}

extension UIView {
    func makeShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 7, height: 7)
        self.layer.shadowRadius = 10
    }
}
