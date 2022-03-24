//
//  ViewController.swift
//  SocialCellUI
//
//  Created by 김정민 on 2022/03/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureNavigationBar()
        addTable()
        configureTable()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("NeedsupdateLayout"), object: nil, queue: nil) { [weak self] notification in

            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
        
    }
    
    private func addTable() {
        tableView = UITableView()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
    }

    private func configureTable() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        
        let searchBar: UISearchBar = UISearchBar()
        searchBar.placeholder = "검색"
        searchBar.searchTextField.backgroundColor = .white
        
        navigationItem.titleView = searchBar
        
        let cameraButton = UIBarButtonItem(systemItem: .camera)
        let shareButton = UIBarButtonItem(systemItem: .action)
        
        navigationItem.leftBarButtonItem = cameraButton
        navigationItem.rightBarButtonItem = shareButton
        
    }

}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FeedTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }
        cell.feed = Feed.feeds[Int.random(in: 0...9)]
        return cell
    }
    
    
}
