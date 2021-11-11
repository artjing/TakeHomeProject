//
//  ViewController.swift
//  UserTest
//
//  Created by 董静 on 11/5/21.
//

import UIKit

class ViewController: UIViewController {

    var dataSource = [User]()
    
    private var tableView =  UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier:UserListTableViewCell.identifer)
        
        let url = "https://60ff4d65257411001707892a.mockapi.io/users"
        APIClient.shared.basicRequest(with: url, method: APIClient.HTTPMethod.get) {[weak self] result in
            switch result {
            case .failure(let error) :
                print(error)
            case .success(let json) :
                self?.dataSource = json
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.identifer, for: indexPath) as! UserListTableViewCell
        cell.config(dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = UserDetailViewController()
        detail.config(dataSource[indexPath.row])
        navigationController?.pushViewController(detail, animated: true)
    }
}
