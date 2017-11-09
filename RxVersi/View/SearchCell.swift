//
//  SearchCell.swift
//  RxVersi
//
//  Created by Marvin Böddeker on 09.11.17.
//  Copyright © 2017 Marvin Böddeker. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoDescLbl: UILabel!
    @IBOutlet weak var forksCountLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    
    public private(set) var repoUrl: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
    }

    func configureCell(repo: Repo){
        repoNameLbl.text = repo.name
        repoDescLbl.text = repo.description
        forksCountLbl.text = String(describing: repo.numberOfForks)
        languageLbl.text = repo.language
        repoUrl = repo.repoUrl
    }
}
