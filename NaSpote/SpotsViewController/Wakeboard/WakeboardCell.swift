//
//  SpotCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.12.2021.
//

import UIKit

class WakeboardCell: UITableViewCell {
    
    @IBOutlet var spotTitle: UILabel!
    @IBOutlet var spotShadow: UIView!
    @IBOutlet var mapButton: UIButton!
    @IBOutlet var spotImage: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        spotShadow.makeShadows()
        spotShadow.layer.cornerRadius = 10
        spotImage.layer.cornerRadius = spotImage.frame.size.width / 2
        spotImage.layer.borderWidth = 0.5
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension UIView {
    func makeSnowShadows() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10
        
    }
}
