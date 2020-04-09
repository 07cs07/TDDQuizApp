//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 09/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import UIKit

struct PresantableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    
}

class WrongAnswerCell: UITableViewCell {
    
}

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var summary: String = ""
    var answers = [PresantableAnswer]()
    
    convenience init(summary: String, answers: [PresantableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = summary
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        return answer.isCorrect ? CorrectAnswerCell() : WrongAnswerCell()
    }
}
