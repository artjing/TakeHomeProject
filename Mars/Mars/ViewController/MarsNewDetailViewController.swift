//
//  MarsNewDetailViewController.swift
//  Mars
//
//  Created by 董静 on 11/9/21.
//

import UIKit

class MarsNewDetailViewController: UIViewController {

    var textHeight : CGFloat = 0
    var imageSize : (CGFloat, CGFloat) = (0.0, 0.0)
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let newsImage : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let newsTitle : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    private let newsText : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        view.addSubview(scrollView)
        scrollView.addSubview(newsTitle)
        scrollView.addSubview(newsImage)
        scrollView.addSubview(newsText)
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        custmizeBackButton()
    }
    
    func custmizeBackButton() {
        let backImage = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action:  #selector(didClickBack))
        leftButton.tintColor = .black
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.backBarButtonItem = leftButton
    }
    
    @objc func didClickBack() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // calculate image size
        var imageW : CGFloat = 0
        var imageH : CGFloat = 0
        if imageSize.0 >= imageSize.1 {
            imageW = 0.8
            imageH = imageSize.1/imageSize.0 * 0.8
        }else{
            imageH = 0.8
            imageW = 0.8 * imageSize.0/imageSize.1
        }
        
        // calculae scrollview content size
        textHeight += CGFloat(view.frame.width * imageH) + 110
        scrollView.contentSize = CGSize(width: view.frame.width, height: textHeight)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newsTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            newsTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            newsTitle.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
            newsTitle.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
            newsImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            newsImage.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 20),
            newsImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: imageW),
            newsImage.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: imageH),
        ])
        
        NSLayoutConstraint.activate([
            newsText.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            newsText.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20),
            newsText.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
        ])
    }
    
    func config(with model: MarsNews?, image: UIImage?) {
        guard let model = model, let image = image else {
            return
        }
        newsTitle.text = model.title
        newsText.text = model.body
        newsImage.image = image
        imageSize = (CGFloat(model.images[0].width), CGFloat(model.images[0].height))
        textHeight = utilities().textHeight(text: model.body, fontSize: 16, width: view.frame.width * 0.8)
        scrollView.contentSize = CGSize(width: view.frame.width, height: textHeight)
    }
}
