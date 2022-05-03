//
//  TestViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 30.04.2022.
//

import UIKit

class NewsDetailVC: UIViewController {
    
    var scroll = UIScrollView()
    var imageNews = UIImageView()
    var labelNews = UILabel()
    var exitButton = UIButton()
    
    var detailNewsManager = NewsDetailManager()
    
    var link = ""
    var detailNewsModel: NewsDetailModel!

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.contentInsetAdjustmentBehavior = .never
        
        detailNewsManager.delegate = self

        self.createObjects()
        self.addConstraints()
        

        DispatchQueue.global(qos: .background).async {
            self.detailNewsManager.fetchNews(self.link)
            DispatchQueue.main.async {
                self.labelNews.text = self.detailNewsModel.textNews
            }
        }
        
    }
    
    func createObjects() {
        
        

        imageNews.contentMode = .scaleAspectFill
        labelNews.numberOfLines = 0
        
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.backgroundColor = .systemGray3
        exitButton.alpha = 0.6
        exitButton.layer.cornerRadius = 20
        exitButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        exitButton.tintColor = .black
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        
        view.addSubview(scroll)
        view.addSubview(exitButton)
        scroll.addSubview(imageNews)
        scroll.addSubview(labelNews)
        
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        imageNews.translatesAutoresizingMaskIntoConstraints = false
        labelNews.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        scroll.insetsLayoutMarginsFromSafeArea = false
        imageNews.insetsLayoutMarginsFromSafeArea = false
        
    }
    
    var viewHieght: Double {
        var height = Double()
        if view.frame.height > 800 {
            height = -50
        }
        return height
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
        
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.widthAnchor.constraint(equalToConstant: view.frame.width),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageNews.topAnchor.constraint(equalTo: scroll.topAnchor),
            imageNews.widthAnchor.constraint(equalToConstant: view.frame.width),
            imageNews.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            
            labelNews.topAnchor.constraint(greaterThanOrEqualTo: imageNews.bottomAnchor, constant: 20),
            labelNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelNews.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -20),

            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            exitButton.widthAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    @objc func exitButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
        
    }
}

extension NewsDetailVC: DetailNewsManagerDelegate {
    func didUpdateNews(teams: NewsDetailModel) {
        self.detailNewsModel = teams
    }
    
    func didFailWithError(error: Error) {
        print("Error in Deatail News \(error)")
    }
    
    
}
