//
//  DetailNewsVC.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 04.12.2021.
//

import UIKit
import Kingfisher
import Hero

class DetailNewsViewController: UIViewController {
    
    var detailNewsManager = DetailNewsManager()
    
    var exitButton = UIButton()
    
    var newsString = String()
    var txt = ""
    var img = ""
    
    @IBOutlet var newsTxt: UITextView!
    @IBOutlet var newsImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addExitButton()
        
        newsImg.heroID = "imageNews"
        newsTxt.heroID = "txtNews"
        self.hero.isEnabled = true
        
        detailNewsManager.delegate = self
        
        loadImage()
        newsTxt.showsVerticalScrollIndicator = false
        
        DispatchQueue.global(qos: .background).async {
            self.detailNewsManager.fetchNews(self.txt)
            
            DispatchQueue.main.async {
                self.newsTxt.text = self.newsString
            }
        }
    }
    
// MARK: - ExitButton
    
    func addExitButton() {
        
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        exitButton.tintColor = .black
//        exitButton.backgroundColor = .systemGray5
        exitButton.layer.cornerRadius = 15
        exitButton.alpha = 1
        view.addSubview(exitButton)
        
        let constraints = [
            exitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant:  view.frame.width - 50),
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.widthAnchor.constraint(equalToConstant: 30)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    @objc func exitButtonTapped() {
        hero.dismissViewController()
    }
    
    func loadImage() {
        let image = self.img
        let downloadUrl = URL(string: image)
        let resourse = ImageResource(downloadURL: downloadUrl!)
        let processor = DownsamplingImageProcessor(size: self.newsImg.bounds.size)
        
        self.newsImg.kf.indicatorType = .activity
        self.newsImg.kf.setImage(with: resourse, options: [.processor(processor)])
    }
}

// MARK: - Delegate

extension DetailNewsViewController: DetailNewsManagerDelegate {
    func didUpdateNews(teams: DetailNewsModel) {
        self.newsString = teams.textNews
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
