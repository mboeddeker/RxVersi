//
//  DownloadService.swift
//  RxVersi
//
//  Created by Marvin Böddeker on 07.11.17.
//  Copyright © 2017 Marvin Böddeker. All rights reserved.
//

import Foundation
import Alamofire

class DownloadService {
    static let instance = DownloadService()
    
    func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray: [Dictionary<String,Any>]) -> ()) {
        var trendingReposArray = [Dictionary<String,Any>]()
        Alamofire.request(trendingRepoUrl).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, Any> else { return }
            guard let repoDictionaryArray = json["items"] as? [Dictionary<String, Any>] else { return }
            for repoDict in repoDictionaryArray {
                if trendingReposArray.count <= 10 {
                    trendingReposArray.append(repoDict)
                } else { break }
            }
            completion(trendingReposArray)
        }
    }
}
