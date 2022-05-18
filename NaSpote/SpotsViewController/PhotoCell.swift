//
//  photoCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 11.05.2022.
//

import UIKit
import Kingfisher

class PhotoCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var array = [String]()
    var viewHewight = Int()
    
    var photoCollection: UICollectionView = {
        
        let layuot = UICollectionViewFlowLayout()
        layuot.scrollDirection = .horizontal
        layuot.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layuot)
        return cv
        
    }()
    
    let photoCellID = "photoCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        photoCollection.delegate = self
        photoCollection.dataSource = self
        photoCollection.showsHorizontalScrollIndicator = false
        photoCollection.register(ImageCell.self, forCellWithReuseIdentifier: photoCellID)
                
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellID, for: indexPath) as! ImageCell
        
        cell.addSubview(cell.gallery)
        
        let processor = DownsamplingImageProcessor(size: cell.bounds.size)
        
        cell.gallery.kf.indicatorType = .activity
        cell.gallery.kf.setImage(with: URL(string: array[indexPath.row]), placeholder: UIImage(named: "NotFound"), options: [.processor(processor)])
        
        NSLayoutConstraint.activate([
        
            cell.gallery.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0),
            cell.gallery.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 10),
            cell.gallery.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0),
            cell.gallery.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0),
            
        ])
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(Double(viewHewight) * 1.6), height: viewHewight)
    }
    
    class ImageCell: UICollectionViewCell {
        
        var gallery: UIImageView = {
            
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.layer.cornerRadius = 7
            iv.clipsToBounds = true
            iv.backgroundColor = .white
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
            
        }()
        
        
        override init(frame: CGRect){
        super.init(frame: frame)
            addSubview(gallery)
            
            layer.cornerRadius = 5
        }
        
        required init?(coder: NSCoder) {
            fatalError("error")
        }
    }

}
