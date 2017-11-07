//
//  TrendingFeedVc.swift
//  RxVersi
//
//  Created by Marvin Böddeker on 07.11.17.
//  Copyright © 2017 Marvin Böddeker. All rights reserved.
//

import UIKit

class TrendingFeedVc: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendingRepoCell", for: indexPath) as? TrendingRepoCell
            else { return UITableViewCell() }
        let repo = Repo(image: #imageLiteral(resourceName: "searchIconLarge"), name: "Swift", description: "Apples Programming language", numberOfForks: 356, language: "Swift", numberOfContributors: 265, repoUrl: "www.google.de")
        cell.configureCell(repo: repo)
        
        return cell
    }

}

