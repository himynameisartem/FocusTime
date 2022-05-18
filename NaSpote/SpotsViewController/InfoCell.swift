//
//  InfoCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 07.05.2022.
//

import UIKit

class InfoCell: UITableViewCell {
    
    var leftLabel = UILabel()
    var rightLabel = UILabel()
    
//    var weekdayTitle = UILabel()
//    var weekdayContent = UILabel()
//    var weekendTitle = UILabel()
//    var weekendContent = UILabel()
//    var setDurationTitle = UILabel()
//    var setDurationContent = UILabel()
//    var workHoursTitle = UILabel()
//    var workHoursContent = UILabel()
//
//    var leftStack = UIStackView()
//    var rightStack = UIStackView()
//    var mainStack = UIStackView()
//
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leftLabel.numberOfLines = 0
        rightLabel.numberOfLines = 0
//
//        weekdayTitle.translatesAutoresizingMaskIntoConstraints = false
//        weekdayContent.translatesAutoresizingMaskIntoConstraints = false
//        weekendTitle.translatesAutoresizingMaskIntoConstraints = false
//        weekendContent.translatesAutoresizingMaskIntoConstraints = false
//        setDurationTitle.translatesAutoresizingMaskIntoConstraints = false
//        setDurationContent.translatesAutoresizingMaskIntoConstraints = false
//        workHoursTitle.translatesAutoresizingMaskIntoConstraints = false
//        workHoursContent.translatesAutoresizingMaskIntoConstraints = false
//
//        weekdayContent.textAlignment = .right
//        weekendContent.textAlignment = .right
//        setDurationContent.textAlignment = .right
//        workHoursContent.textAlignment = .right
//
//        weekdayTitle.contentMode = .center
//        weekendTitle.contentMode = .center
//        setDurationTitle.contentMode = .center
//        workHoursTitle.contentMode = .center
//
//        weekdayContent.contentMode = .center
//        weekendContent.contentMode = .center
//        setDurationContent.contentMode = .center
//        workHoursContent.contentMode = .center
//
//        workHoursContent.numberOfLines = 0
//
//        leftStack.translatesAutoresizingMaskIntoConstraints = false
//        rightStack.translatesAutoresizingMaskIntoConstraints = false
//        mainStack.translatesAutoresizingMaskIntoConstraints = false
//
//        leftStack.spacing = 10
//        leftStack.alignment = .fill
//        leftStack.distribution = .fillEqually
//        leftStack.axis = .vertical
//        leftStack.contentMode = .scaleAspectFill
//
//        rightStack.spacing = 10
//        rightStack.alignment = .fill
//        rightStack.distribution = .fillEqually
//        rightStack.axis = .vertical
//        rightStack.contentMode = .scaleAspectFill
//
//        mainStack.spacing = 0
//        mainStack.alignment = .fill
//        mainStack.distribution = .fillEqually
//        mainStack.axis = .horizontal
//        mainStack.contentMode = .scaleAspectFill
//
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//
//    }
//
    func UIfontLabel(label: UILabel, font: String, viewHeight: Double, size: CGFloat) {
        switch viewHeight {
        case 548.0...568.0:
            label.font = UIFont(name:  font, size: size + 2)//iPhone 5S,SE
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

