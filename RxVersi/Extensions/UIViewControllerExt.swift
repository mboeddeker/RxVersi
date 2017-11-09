//
//  UIViewControllerExt.swift
//  RxVersi
//
//  Created by Marvin Böddeker on 09.11.17.
//  Copyright © 2017 Marvin Böddeker. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentSFSafariVCFor(url: String){
        let readmeUrl = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: readmeUrl!)
        present(safariVC, animated: true, completion: nil)
    }
    
}
