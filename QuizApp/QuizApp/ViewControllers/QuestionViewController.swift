//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 07/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let reuseIndentifier = "Cell"
    private(set) var question: String = ""
    private(set) var options: [String] = []
    private(set) var allowsMultipleSelection: Bool = false
    private var selection: (([String]) -> Void)?
    
    convenience init(question: String, options: [String], allowsMultipleSelection: Bool, selection: @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.allowsMultipleSelection = allowsMultipleSelection
        self.selection = selection
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = question
        tableView.allowsMultipleSelection = allowsMultipleSelection
    }
}

extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell()
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    private func dequeueCell() -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIndentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: reuseIndentifier)
        }
    }
}

extension QuestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions())
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if allowsMultipleSelection {
            selection?(selectedOptions())
        }
    }
    
    private func selectedOptions() -> [String] {
        guard let indexPaths = tableView.indexPathsForSelectedRows else { return [] }
        return indexPaths.map { return options[$0.row] }
    }
}
