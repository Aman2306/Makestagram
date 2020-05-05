//
//  HomeViewController.swift
//  Makestagram
//
//  Created by Aman Meena on 04/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    // MARK:- Properties
    
    var posts = [Post]()
    
    
    // MARK:- IBOutlets
    
    @IBOutlet var tableView: UITableView!
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableView.reuseID, for: indexPath)
        
        cell.backgroundColor = .cyan
        
        return cell
    }
    
    
}
