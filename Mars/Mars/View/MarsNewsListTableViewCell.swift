//
//  MarsNewsListTableViewCell.swift
//  Mars
//
//  Created by 董静 on 11/5/21.
//

import UIKit

// MARK: - Delegate
protocol MarsNewsListTableViewCellDelegate: AnyObject{
    func newsDidTaped()
}

// MARK: - UITableViewCell
class MarsNewsListTableViewCell: UITableViewCell {
    
    static let identifier = "MarsNewsListTableViewCell"
    
    // delegate
    weak var delegate: MarsNewsListTableViewCellDelegate?
    
    // model
    var model: MarsNews?
    
    // image for reuse
    var topImageSource: UIImage?
    
    private let newsImage : UIImageView = {
        let newsImage = UIImageView()
        newsImage.contentMode = .scaleAspectFill
        newsImage.clipsToBounds = true
        return newsImage
    }()
    
    private let newsLabel : UILabel = {
        let newsLabel = UILabel()
        newsLabel.numberOfLines = 2
        newsLabel.textAlignment = .left
        newsLabel.textColor = .black
        newsLabel.font = UIFont.systemFont(ofSize: 16)
        return newsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsLabel)
        contentView.addSubview(newsImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // clear old data
        newsLabel.text = ""
        newsImage.image = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsImage.heightAnchor.constraint(equalToConstant: 80),
            newsImage.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            newsLabel.leftAnchor.constraint(equalTo: newsImage.rightAnchor, constant: 10),
            newsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            newsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
        ])

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func config(_ model: MarsNews) {
        
        newsLabel.text = model.title
        
        // getting top image
        var topImage = ""
        for image in model.images {
            if image.top_image {
                topImage = image.url
            }
        }
        
        // check it is a url
        let imageUrlString = topImage
        guard URL(string: imageUrlString) != nil else {
            return
        }
        
        MarsRequestManager.shared.requestImage(url: imageUrlString) {[weak self] result in
            switch result {
            case .success(let data) :
                DispatchQueue.main.async { [self] in
                    let image = UIImage(data: data)
                    self?.newsImage.image = image
                    self?.topImageSource = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
