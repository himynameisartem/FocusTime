//
//  SlideMenuController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 25.11.2021.
//

import UIKit
import SlideMenuControllerSwift

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    // create viewController code...

    let slideMenuController = SlideMenuController(mainViewController: CollectionViewController, leftMenuViewController: ViewController)
    
    self.window?.rootViewController = slideMenuController
    self.window?.makeKeyAndVisible()

    return true
}
