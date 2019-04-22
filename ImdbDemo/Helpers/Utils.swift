//
//  Utils.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 23.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import UIKit

final class Utils {
    
    private init() {}
        
    class func showGlobalError(target viewController: UIViewController, message: String? = nil, title: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title ?? "Uyarı", message: message ?? "Bir sorun oluştu", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: handler))
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
