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
        spotShadow.layer.cornerRadius = 5
        spotImage.layer.cornerRadius = spotImage.frame.size.width / 2
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension UIView {
    func makeSnowShadows() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 7, height: 7)
        self.layer.shadowRadius = 10
        
    }
}
