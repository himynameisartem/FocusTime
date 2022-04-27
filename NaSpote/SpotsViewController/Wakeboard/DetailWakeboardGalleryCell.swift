//
//  DetailSpotGalleryCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 06.01.2022.
//

import UIKit

class DetailWakeboardGalleryCell: UICollectionViewCell {
    
    @IBOutlet var galleryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        galleryImageView.layer.borderWidth = 0.3
    }
    
}

