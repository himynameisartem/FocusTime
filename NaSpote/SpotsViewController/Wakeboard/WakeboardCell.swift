//
//  SpotCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.12.2021.
//

import UIKit
import Hero

class WakeboardCell: UITableViewCell {
    
    @IBOutlet var spotTitle: UILabel!
    @IBOutlet var spotShadow: UIView!
    @IBOutlet var mapButton: UIButton!
    @IBOutlet var spotImage: UIImageView!
    @IBOutlet var spotPhone: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        spotShadow.heroID = "spot"
        
        spotShadow.makeSnowShadows()
        spotShadow.layer.cornerRadius = 10
        spotShadow.layer.borderWidth = 0.3
        
        DispatchQueue.main.async {
        self.spotImage.layer.cornerRadius = 5
        self.spotImage.layer.cornerRadius = self.spotImage.frame.size.width / 2
        self.spotImage.layer.borderWidth = 0.5
        }
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension UIView {
    func makeSnowShadows() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2

    }
}
