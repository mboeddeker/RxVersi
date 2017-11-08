//
//  TrendingFeedVc.swift
//  RxVersi
//
//  Created by Marvin Böddeker on 07.11.17.
//  Copyright © 2017 Marvin Böddeker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingFeedVc: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var dataSource = PublishSubject<[Repo]>()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRefreshControl()
        fetchData()
        initTableView()
        
    }
    
    @objc func fetchData() {
        DownloadService.instance.downloadTrendingRepos { (trendingReposArray) in
            self.dataSource.onNext(trendingReposArray)
            self.refreshControl.endRefreshing()
        }
    }
    
    func initTableView(){
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "trendingRepoCell")){ (row ,repo: Repo, cell: TrendingRepoCell) in
            cell.configureCell(repo: repo)
        }.disposed(by: disposeBag)
    }
    
    func addRefreshControl(){
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = #colorLiteral(red: 0.2579534675, green: 0.4541416886, blue: 1, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Hot Github Repos 🔥", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2579534675, green: 0.4541416886, blue: 1, alpha: 1), NSAttributedStringKey.font: UIFont(name: "AvenirNext-Demibold", size: 16.0)!])
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
    }
    
}

