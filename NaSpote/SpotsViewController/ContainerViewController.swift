//
//  ContainerViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 15.04.2022.
//

import UIKit

class ContainerViewController: UIViewController {
    
    let exitButton = UIButton()
    let callButton = UIButton()
    let reserveButton = UIButton()
    let networksButton = UIButton()
    let instagramButton = UIButton()
    let vkButton = UIButton()
    let webButton = UIButton()
    
    var callButtonConstraint: NSLayoutConstraint!
    var reserveButtonConstraint: NSLayoutConstraint!
    var networkButtonConstraint: NSLayoutConstraint!
    var instagramButtonConstraint: NSLayoutConstraint!
    var vkButtonConstraint: NSLayoutConstraint!
    var webButtonConstraint: NSLayoutConstraint!

    var logo = String()
    var link = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCallButton()
        addReserveButton()
        addExitButton()
        addNetworksButton()
        addInstagrammButton()
        addVkButton()
        addWebButton()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(showButtons), name: Notification.Name("true"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideButtons), name: Notification.Name("false"), object: nil)
    }
    
    // MARK: - Call And Reserve Button
    
    func addCallButton() {
        
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.setTitle("Позвонить", for: .normal)
        callButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        callButton.titleLabel?.textColor = .white
        callButton.backgroundColor = .systemGreen
        callButton.layer.cornerRadius = 7
        view.addSubview(callButton)
        
        
        let constraints = [
            callButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            callButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
            callButton.heightAnchor.constraint(equalToConstant: 50),
            callButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        callButtonConstraint = NSLayoutConstraint(item: callButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 50)
        view.addConstraint(callButtonConstraint)
    }
    
    func addReserveButton() {
        
        let buttonWidth = view.frame.width / 2.5
        
        reserveButton.translatesAutoresizingMaskIntoConstraints = false
        reserveButton.setTitle("Забронировать", for: .normal)
        reserveButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        reserveButton.titleLabel?.textColor = .white
        reserveButton.backgroundColor = .systemBlue
        reserveButton.layer.cornerRadius = 7
        view.addSubview(reserveButton)
        
        let constraints = [
            reserveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.frame.width - buttonWidth - 20),
            reserveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
            reserveButton.heightAnchor.constraint(equalToConstant: 50),
            reserveButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        reserveButtonConstraint = NSLayoutConstraint(item: reserveButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 50)
        view.addConstraint(reserveButtonConstraint)
    }
    
    // MARK: Exit Button
    
    func addExitButton() {
        
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setBackgroundImage(UIImage(systemName: "multiply"), for: .normal)
        exitButton.tintColor = .black
        exitButton.layer.cornerRadius = 20
        exitButton.alpha = 0.5
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
        
    }
    
    // MARK: Networks Buttons
    
    func addNetworksButton() {
    
        networksButton.translatesAutoresizingMaskIntoConstraints = false
        networksButton.backgroundColor = .clear
        networksButton.alpha = 0.5
        networksButton.layer.cornerRadius = 50 / 2
        networksButton.setBackgroundImage(UIImage(systemName: "plus.circle"), for: .normal)
        networksButton.tintColor = .black
        view.addSubview(networksButton)
        
        let constraints = [
            networksButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.frame.width - 70),
            networksButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            networksButton.heightAnchor.constraint(equalToConstant: 50),
            networksButton.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        networkButtonConstraint = NSLayoutConstraint(item: networksButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -20)
        view.addConstraint(networkButtonConstraint)
        
        networksButton.addTarget(self, action: #selector(openNetworks), for: .touchUpInside)
        
    }
    
    func addInstagrammButton() {
        
        instagramButton.translatesAutoresizingMaskIntoConstraints = false
        instagramButton.layer.cornerRadius = 25
        instagramButton.setBackgroundImage(UIImage(named: "instagram"), for: .normal)
        instagramButton.isHidden = true
        view.addSubview(instagramButton)
        
        let constraints = [
            instagramButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.frame.width - 70),
            instagramButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            instagramButton.heightAnchor.constraint(equalToConstant: 50),
            instagramButton.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        instagramButtonConstraint = NSLayoutConstraint(item: instagramButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -20)
        view.addConstraint(instagramButtonConstraint)
        
    }
    
    func addVkButton() {
        
        vkButton.translatesAutoresizingMaskIntoConstraints = false
        vkButton.frame = CGRect(x: 414 - 80, y: 740, width: 50, height: 50)
        vkButton.layer.cornerRadius = 25
        vkButton.setBackgroundImage(UIImage(named: "vk"), for: .normal)
        vkButton.isHidden = true
        view.addSubview(vkButton)
        
        let constraints = [
            vkButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.frame.width - 70),
            vkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            vkButton.heightAnchor.constraint(equalToConstant: 50),
            vkButton.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        vkButtonConstraint = NSLayoutConstraint(item: vkButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -20)
        view.addConstraint(vkButtonConstraint)
        
    }
    
    func addWebButton() {
        
        webButton.translatesAutoresizingMaskIntoConstraints = false
        webButton.layer.cornerRadius = 25
        webButton.setBackgroundImage(UIImage(named: "safari"), for: .normal)
        webButton.isHidden = true
        view.addSubview(webButton)
        
        let constraints = [
            webButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.frame.width - 70),
            webButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            webButton.heightAnchor.constraint(equalToConstant: 50),
            webButton.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        webButtonConstraint = NSLayoutConstraint(item: webButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -20)
        view.addConstraint(webButtonConstraint)
        
    }
    
    
    
    @objc func openNetworks() {


        if instagramButton.isHidden {
            
            networksButton.alpha = 1

            if self.instagramButtonConstraint.constant > -90 {

                UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn) {
                    self.webButtonConstraint.constant -= 70
                    self.view.layoutIfNeeded()
                }
                
                UIView.animate(withDuration: 0.1, delay: 0.05, options: .curveEaseIn) {
                    self.instagramButtonConstraint.constant -= 140
                    self.view.layoutIfNeeded()
                }
                
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
                    self.vkButtonConstraint.constant -= 210
                    self.view.layoutIfNeeded()
                }
                
                instagramButton.isHidden = false
                vkButton.isHidden = false
                webButton.isHidden = false
                
            } else if self.instagramButtonConstraint.constant > -160  {
                
                UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn) {
                    self.webButtonConstraint.constant -= 70
                    self.view.layoutIfNeeded()
                }
                
                UIView.animate(withDuration: 0.1, delay: 0.05, options: .curveEaseIn) {
                    self.instagramButtonConstraint.constant -= 140
                    self.view.layoutIfNeeded()
                }
                
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
                    self.vkButtonConstraint.constant -= 210
                    self.view.layoutIfNeeded()
                }

                instagramButton.isHidden = false
                vkButton.isHidden = false
                webButton.isHidden = false
            }

        } else {
            
            self.webButtonConstraint.constant += 70
            self.instagramButtonConstraint.constant += 140
            self.vkButtonConstraint.constant += 210
            
            instagramButton.isHidden = true
            vkButton.isHidden = true
            webButton.isHidden = true

            networksButton.alpha = 0.2

        }
    }
    
    // MARK: - Animated
    
    @objc func showButtons() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            if self.callButtonConstraint.constant > -20 {
                self.callButtonConstraint.constant -= 70
                self.reserveButtonConstraint.constant -= 70
                self.networkButtonConstraint.constant -= 70
                self.instagramButtonConstraint.constant -= 70
                self.vkButtonConstraint.constant -= 70
                self.webButtonConstraint.constant -= 70

                self.view.layoutIfNeeded()
            }
        }

    }
    
    @objc func hideButtons() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            if self.callButtonConstraint.constant == -20 {
                self.callButtonConstraint.constant += 70
                self.reserveButtonConstraint.constant += 70
                self.networkButtonConstraint.constant += 70
                self.instagramButtonConstraint.constant += 70
                self.vkButtonConstraint.constant += 70
                self.webButtonConstraint.constant += 70

                self.view.layoutIfNeeded()
            }
        }
    }
    
}


extension ContainerViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContainerToTable" {
            let detailSpoVC = segue.destination as! DetailSpotViewController
            detailSpoVC.logoString = logo
            detailSpoVC.link = link
        }
    }
    
}
