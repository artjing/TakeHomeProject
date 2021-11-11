//
//  MarsNewsHomeViewController.swift
//  Mars
//
//  Created by 董静 on 11/3/21.
//

import UIKit

class MarsNewsHomeViewController: UIViewController {
    
    // language siwth button
    var martianButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.setTitle("Martian", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(languageSwitch), for:.touchUpInside)
        return button
    }()
    
    var tableview = UITableView(frame: .zero)
    var dataSource = [MarsNews]()
    var newsDataSource = [MarsNews]()
    var martianDataSource = [MarsNews]() /* for switch to martian */
    var isMartianMode = false /* control language version, martian or english */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mars"
        isMartianMode = getLanguageMode()
        tableview.tableFooterView = UIView() /* remove seperate line*/
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(MarsNewsListTableViewCell.self, forCellReuseIdentifier:MarsNewsListTableViewCell.identifier)
        view.addSubview(tableview)
        view.addSubview(martianButton)
        
        MarsNewsService.shared.fetchMarsNews {[weak self] result in
            switch result {
            case .success(let news) :
                self?.newsDataSource = news
                self?.prepareMartian() /* prepare data */
                DispatchQueue.main.async {
                    self?.tableview.reloadData()
                }
            case .failure(let error) :
                print("fetch new falied with error", error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        martianButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableview.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        NSLayoutConstraint.activate([
            martianButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            martianButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            martianButton.heightAnchor.constraint(equalToConstant: 42),
            martianButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
        ])
        
    }
}

// MARK: - Private functions
extension MarsNewsHomeViewController {
    
    @objc func languageSwitch() {
        isMartianMode.toggle()
        changeButtonMode()
        saveLanguageMode(isMartianMode)
        prepareMartian()
    }
    
    func prepareMartian() {
        if isMartianMode {
            martianDataSource.removeAll()
            for model in newsDataSource {
                if newsDataSource.count > 0 {
                    let convertedModel = model.convertModelLanguage(true)
                    martianDataSource.append(convertedModel)
                    dataSource = martianDataSource
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }
            }
        } else {
            dataSource = newsDataSource
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    func changeButtonMode() {
        if isMartianMode {
            martianButton.setTitle("English", for: .normal)
            martianButton.backgroundColor = .lightGray
            martianButton.setTitleColor(.black, for: .normal)
        } else{
            martianButton.setTitle("Martian", for: .normal)
            martianButton.backgroundColor = .black
            martianButton.setTitleColor(.white, for: .normal)
        }
    }
}

// MARK: -  Save and retrieve setting data from userdefault
extension MarsNewsHomeViewController {
    
    func saveLanguageMode(_ isMartian: Bool) {
        UserDefaults.standard.setValue(isMartian, forKey: "showMartian")
    }
    func getLanguageMode() -> Bool {
        let isMartian = UserDefaults.standard.bool(forKey: "showMartian")
        return isMartian
    }
}

// MARK: - Tableview delegate
extension MarsNewsHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: MarsNewsListTableViewCell.identifier) as! MarsNewsListTableViewCell
        cell.config(dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let marsDetailVC = MarsNewDetailViewController()
        let newsModel = dataSource[indexPath.row]
        let cell = tableview.cellForRow(at: indexPath) as! MarsNewsListTableViewCell
        marsDetailVC.config(with: newsModel, image: cell.topImageSource)
        navigationController?.pushViewController(marsDetailVC, animated: true)
    }
}
