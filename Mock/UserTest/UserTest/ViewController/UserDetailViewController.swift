//
//  UserDetailViewController.swift
//  UserTest
//
//  Created by 董静 on 11/5/21.
//

import UIKit

class UserDetailViewController: UIViewController {

    private var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var content : UILabel = {
        let content = UILabel()
        content.textAlignment = .left
        return content
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(content)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .white
        imageView.frame = CGRect(x: view.frame.width * 0.2, y: view.safeAreaInsets.bottom + 50, width: view.frame.width * 0.6, height: view.frame.width * 0.6)
        content.frame = CGRect(x: view.frame.width * 0.2, y: 30 + view.frame.width * 0.6 + 20, width: view.frame.width * 0.6, height: 100)
    }
    
    func config(_ user: User) {
        
        if let url = URL(string: user.avatar) {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                    self.content.text = user.name
                }
            }
            catch {
                
            }
        }
    }
}
