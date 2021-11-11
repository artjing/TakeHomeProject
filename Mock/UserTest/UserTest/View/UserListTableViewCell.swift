//
//  UserListTableViewCell.swift
//  UserTest
//
//  Created by 董静 on 11/5/21.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    static let identifer = "UserListTableViewCell"
    
    private let userName : UILabel = {
        let userName = UILabel()
        userName.textAlignment = .left
        userName.numberOfLines = 1
        userName.textColor = .black
        userName.font = UIFont.systemFont(ofSize: 16)
        return userName
    }()
    
    private let userAvatar : UIImageView = {
        let userAvatar = UIImageView()
        return userAvatar
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userName)
        contentView.addSubview(userAvatar)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userName.frame = CGRect(x: 80, y: 30, width: contentView.frame.width - 100, height: 20)
        userAvatar.frame = CGRect(x: 10, y: 5, width: 50, height: 50)
    }
    
    func config(_ user: User) {
        userName.text = user.name
        if let url = URL(string: user.avatar) {
            do {
                let data = try Data(contentsOf: url)
                userAvatar.image = UIImage(data: data)
            }
            catch {
                
            }
        }
    }
}
