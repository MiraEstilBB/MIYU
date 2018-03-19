//
//  BaseViewController.swift
//  Simi
//
//  Created by Mira Estil on 1/30/18.
//  Copyright © 2018 ME. All rights reserved.
//

import UIKit

internal class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        gradientBackground()
        keyboardFunctionality()
    }
    
    private func design() {
        //let pinkColor = UIColor(red:0.96, green:0.81, blue:0.76, alpha:1.0)
        //view.backgroundColor = pinkColor
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //view.addSubview(blurEffectView)
        view.insertSubview(blurEffectView, at: 1)
    }
    
    private func gradientBackground() {
        
        let pinkColor = UIColor(red:0.96, green:0.81, blue:0.76, alpha:1.0)
        let darkPink = UIColor(red:0.93, green:0.60, blue:0.57, alpha:1.0)
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [pinkColor.cgColor, darkPink.cgColor]
        
        gradientLayer.locations = [0.0, 0.72]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    private func keyboardFunctionality() {
        self.hideKeyboardWhenTap()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
}

extension BaseViewController {
    
    func saveData(_ posts: [Post], store: DataStore) {
        let url = store.filePath
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(posts)
            try data.write(to: url, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func loadData(_ store: DataStore) -> [Post] {
        let url = store.filePath
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url, options: [])
            let posts = try decoder.decode([Post].self, from: data)
            return posts
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
