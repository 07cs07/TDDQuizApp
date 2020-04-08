//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by Mahalingam, Balachander on 07/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_ViewDidLoad_HeaderLabel() {
        let sut = makeSUT(question: "Q1")
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_ViewDidLoad_rendersOption() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
        
    func test_ViewDidLoad_withOptions_rendersOptionaText() {
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
    }
    
    func test_selectedOptions_notifiesDelegate() {
        var selectedOption = ""
        let sut = makeSUT(options: ["A1"]) {
            selectedOption = $0
        }
        let indexPath = IndexPath(row: 0, section: 0)
        
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
        XCTAssertEqual(selectedOption, "A1")
    }
    
    // MARK:- Helpers
    private func makeSUT(question: String = "",
                         options: [String] = [],
                         selection: @escaping (String) -> Void = {_ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        let _ = sut.view
        return sut
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return self.dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
}
