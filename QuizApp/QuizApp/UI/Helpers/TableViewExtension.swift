//
//  TableViewExtension.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 10/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        self.register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        let cell = self.dequeueReusableCell(withIdentifier: className) as? T
        return cell
    }
}

