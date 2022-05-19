//
//  CampCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 19.05.2022.
//

import UIKit

class CampCell: UITableViewCell {
    
    var shadowView = UIView()
    var poster = UIImageView()
    var title = UILabel()
    var date = UILabel()
    var type = UILabel()
    var location = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        poster.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        type.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        
        shadowView.makeShadow()
        poster.contentMode = .scaleAspectFill
        poster.clipsToBounds = true
        
        DispatchQueue.main.async {
            self.shadowView.layer.cornerRadius = 10
            self.shadowView.layer.borderWidth = 0.5
            self.shadowView.backgroundColor = .white
        }
    }

}
