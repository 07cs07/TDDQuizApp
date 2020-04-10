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
    
    func test_selectedOptions_withTwoOptions_notifiesDelegateWhenSelectionChanges() {
        var selectedOption = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { selectedOption = $0 }
        
        sut.tableView.select(at: 0)
        XCTAssertEqual(selectedOption, ["A1"])
        
        sut.tableView.select(at: 1)
        XCTAssertEqual(selectedOption, ["A2"])
    }
    
    func test_selectedOptions_withMultipleOptionsEnabled_notifiesDelegateWhenSelectionChanges() {
        var selectedOption = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { selectedOption = $0 }
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(at: 0)
        XCTAssertEqual(selectedOption, ["A1"])

        sut.tableView.select(at: 1)
        XCTAssertEqual(selectedOption, ["A1", "A2"])
    }
    
    func test_deselecteOptions_withMultipleOptionsEnabled_notifiesDelegateWhenSelectionChanges() {
        var selectedOption = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { selectedOption = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(at: 0)
        XCTAssertEqual(selectedOption, ["A1"])

        sut.tableView.deselect(at: 0)
        XCTAssertEqual(selectedOption, [])
    }
    
    func test_selecteOptions_withMoreOptions_doesNotNotifiesDelegateWhenSelectionChange() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"]) { _ in callbackCount += 1 }
        
        sut.tableView.select(at: 0)
        XCTAssertEqual(callbackCount, 1)

        sut.tableView.deselect(at: 0)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_selectedOptions_withMultipleOptionsEnabled_doNotNotifyDelegateWhenNoSelectionHappens() {
        var selectedOption = [String]()
        _ = makeSUT(options: ["A1", "A2"]) { selectedOption = $0 }
        XCTAssertEqual(selectedOption, [])
    }
    
    // MARK:- Helpers
    private func makeSUT(question: String = "",
                         options: [String] = [],
                         selection: @escaping ([String]) -> Void = {_ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        let _ = sut.view
        return sut
    }
}
