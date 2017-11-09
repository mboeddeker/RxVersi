//
//  SearchVC.swift
//  RxVersi
//
//  Created by Marvin Böddeker on 07.11.17.
//  Copyright © 2017 Marvin Böddeker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: RoundedBorderTextfield!
    
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func bindElements() {
        
        let searchResultsOberservable = searchField.rx.text
            .orEmpty.debounce(0.5, scheduler: MainScheduler.instance)
            .map {
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            }
            .flatMap { (query) -> Observable<[Repo]> in
                if query == "" {
                    return Observable<[Repo]>.just([])
                } else {
                    let url = searchUrl + query + starsDescendingSegment
                    var searchRepos = [Repo]()
                    return URLSession.shared.rx.json(url: URL(string:url)!).map {
                        let results = $0 as AnyObject
                        let items = results.object(forKey: "items") as? [Dictionary<String,Any>] ?? []
                        
                        for item in items {
                            guard
                                let name = item["name"] as? String,
                                let description = item["description"] as? String,
                                let language = item["language"] as? String,
                                let forksCount = item["forks_count"] as? Int,
                                let repoUrl = item["html_url"] as? String
                                else { break }
                            let repo = Repo(image: #imageLiteral(resourceName: "searchIconLarge"), name: name, description: description, numberOfForks: forksCount, language: language, numberOfContributors: 0, repoUrl: repoUrl)
                            
                            searchRepos.append(repo)
                        }
                        return searchRepos
                    }
                }
            }.observeOn(MainScheduler.instance)
        
        searchResultsOberservable.bind(to: tableView.rx.items(cellIdentifier: "searchCell")){ (row, repo:Repo, cell: SearchCell) in
                cell.configureCell(repo: repo)
        }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchCell else {return}
        let url = cell.repoUrl!
        self.presentSFSafariVCFor(url: url)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
