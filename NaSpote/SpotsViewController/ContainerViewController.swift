//
//  ContainerViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 15.04.2022.
//

import UIKit

class ContainerViewController: UIViewController {
    
    let callButton = UIButton()
    let reserveButton = UIButton()
    let networksButton = UIButton()
    let instagramButton = UIButton()
    let vkButton = UIButton()
    let webButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCallButton()
        addReserveButton()
        addExitButton()
        addNetworksButton()
        addInstagrammButton()
        addVkButton()
        addWebButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showButtons), name: Notification.Name("true"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideButtons), name: Notification.Name("false"), object: nil)
    }
    
    func addCallButton() {
        
        callButton.frame = CGRect(x: 30, y: 900, width: 160, height: 50)
        callButton.setTitle("Позвонить", for: .normal)
        callButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        callButton.titleLabel?.textColor = .white
        callButton.backgroundColor = .systemGreen
        callButton.layer.cornerRadius = 7
        
        view.addSubview(callButton)
    }
    
    func addReserveButton() {
        
        reserveButton.frame = CGRect(x: 414 - 190, y: 900, width: 160, height: 50)
        reserveButton.setTitle("Забронировать", for: .normal)
        reserveButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        reserveButton.titleLabel?.textColor = .white
        reserveButton.backgroundColor = .systemBlue
        reserveButton.layer.cornerRadius = 7
        
        view.addSubview(reserveButton)
    }
    
    func addExitButton() {
        
        let exitButton = UIButton(frame: CGRect(x: 414 - 70, y: 80, width: 40, height: 40))
        
        view.addSubview(exitButton)
        exitButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        exitButton.tintColor = .black
        exitButton.backgroundColor = .systemGray6
        exitButton.layer.cornerRadius = exitButton.frame.height / 2
    }
    
    func addNetworksButton() {
        
        
        
        switch view.frame.height {
            
        case 896:
            networksButton.frame = CGRect(x: 414 - 80, y: 810, width: 50, height: 50)
            
        case 568:
            networksButton.frame = CGRect(x: 320 - 100, y: 50, width: 40, height: 40)
            
        default:
            networksButton.frame = CGRect(x: 414 - 300, y: 80, width: 40, height: 40)
            
        }
        
        view.addSubview(networksButton)
        
        networksButton.backgroundColor = .black
        networksButton.alpha = 0.3
        networksButton.layer.cornerRadius = networksButton.frame.height / 2
        networksButton.setImage(UIImage(systemName: "network"), for: .normal)
        networksButton.tintColor = .white

        
        networksButton.addTarget(self, action: #selector(openNetworks), for: .touchUpInside)
        
    }
    
    func addInstagrammButton() {
        
        instagramButton.frame = CGRect(x: 414 - 80, y: 740, width: 50, height: 50)
        instagramButton.layer.cornerRadius = instagramButton.frame.height / 2
        instagramButton.backgroundColor = .black
        instagramButton.isHidden = true
        view.addSubview(instagramButton)
        
    }
    
    func addVkButton() {
        
        vkButton.frame = CGRect(x: 414 - 80, y: 740, width: 50, height: 50)
        vkButton.layer.cornerRadius = instagramButton.frame.height / 2
        vkButton.backgroundColor = .black
        vkButton.isHidden = true
        view.addSubview(vkButton)
        
    }
    
    func addWebButton() {
        
        webButton.frame = CGRect(x: 414 - 80, y: 740, width: 50, height: 50)
        webButton.layer.cornerRadius = instagramButton.frame.height / 2
        webButton.backgroundColor = .black
        webButton.isHidden = true
        view.addSubview(webButton)
        
    }
    
    
    
    @objc func openNetworks() {
        
        if instagramButton.isHidden {
            
            if networksButton.frame == CGRect(x: 414 - 80, y: 810, width: 50, height: 50) {
                
                instagramButton.frame = CGRect(x: 414 - 80, y: 810, width: 50, height: 50)
                vkButton.frame = CGRect(x: 414 - 80, y: 810, width: 50, height: 50)
                webButton.frame = CGRect(x: 414 - 80, y: 810, width: 50, height: 50)
                
                UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn) {
                    self.instagramButton.frame = CGRect(x: 414 - 80, y: 740, width: 50, height: 50)
                }
                UIView.animate(withDuration: 0.1, delay: 0.05, options: .curveEaseIn) {
                    self.vkButton.frame = CGRect(x: 414 - 80, y: 670, width: 50, height: 50)
                }
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
                    self.webButton.frame = CGRect(x: 414 - 80, y: 600, width: 50, height: 50)
                }
                
                instagramButton.isHidden = false
                vkButton.isHidden = false
                webButton.isHidden = false
            } else {
                
                    self.instagramButton.frame = CGRect(x: 414 - 80, y: 740, width: 50, height: 50)
                    self.vkButton.frame = CGRect(x: 414 - 80, y: 740, width: 50, height: 50)
                    self.webButton.frame = CGRect(x: 414 - 80, y: 740, width: 50, height: 50)
                
                UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn) {
                    self.instagramButton.frame = CGRect(x: 414 - 80, y: 670, width: 50, height: 50)
                }
                UIView.animate(withDuration: 0.1, delay: 0.05, options: .curveEaseIn) {
                    self.vkButton.frame = CGRect(x: 414 - 80, y: 600, width: 50, height: 50)
                }
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
                    self.webButton.frame = CGRect(x: 414 - 80, y: 530, width: 50, height: 50)
                }
                
                instagramButton.isHidden = false
                vkButton.isHidden = false
                webButton.isHidden = false
            }
            
        } else {
            instagramButton.isHidden = true
            vkButton.isHidden = true
            webButton.isHidden = true
        }
    }
    
    @objc func showButtons() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.callButton.frame = CGRect(x: 30, y: 810, width: 160, height: 50)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.reserveButton.frame = CGRect(x: 414 - 190, y: 810, width: 160, height: 50)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.networksButton.frame = CGRect(x: 414 - 80, y: 740, width: 50, height: 50)
        }
        
        if instagramButton.isHidden == false {
            if networksButton.frame == CGRect(x: 414 - 80, y: 740, width: 50, height: 50) {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                    self.instagramButton.frame = CGRect(x: 414 - 80, y: 670, width: 50, height: 50)
                }
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                    self.vkButton.frame = CGRect(x: 414 - 80, y: 600, width: 50, height: 50)
                }
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                    self.webButton.frame = CGRect(x: 414 - 80, y: 530, width: 50, height: 50)
                }
                
            }
        }
    }
    
    @objc func hideButtons() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.callButton.frame = CGRect(x: 30, y: 900, width: 160, height: 50)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.reserveButton.frame = CGRect(x: 414 - 190, y: 900, width: 160, height: 50)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.networksButton.frame = CGRect(x: 414 - 80, y: 810, width: 50, height: 50)
            
        }
        if instagramButton.isHidden == false {
            if networksButton.frame == CGRect(x: 414 - 80, y: 810, width: 50, height: 50) {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                    self.instagramButton.frame = CGRect(x: 414 - 80, y: 740, width: 50, height: 50)
                }
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                    self.vkButton.frame = CGRect(x: 414 - 80, y: 670, width: 50, height: 50)
                }
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                    self.webButton.frame = CGRect(x: 414 - 80, y: 600, width: 50, height: 50)
                }
            }
        }
    }

}


