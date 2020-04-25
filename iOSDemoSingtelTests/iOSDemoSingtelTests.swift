//
//  iOSDemoSingtelTests.swift
//  iOSDemoSingtelTests
//
//  Created by Sonu on 24/04/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import XCTest
@testable import iOSDemoSingtel
class iOSDemoSingtelTests: XCTestCase {
    
    var viewModel = CardMainViewModel()
    var viewController: CardMainViewController!
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func wait(timeout: TimeInterval) {
        let expectation = XCTestExpectation(description: "Waiting for \(timeout) seconds")
        XCTWaiter().wait(for: [expectation], timeout: timeout)
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_grid_card() {
        // When start fetch
        
        viewModel.initGridData()
        // Assert
        XCTAssertNotNil(viewModel.dataArray)
        XCTAssertNotNil(viewModel.stackedCards)
        XCTAssertNotNil(viewModel.dataArray)
        var card = Card.init(value: "2")
        //let card = Card.init(value: "2")
        XCTAssertEqual(card.value, "2")
        XCTAssertEqual(card.flipped, false)
        XCTAssertNotNil(card.cardIndexpath)
        
        card = Card.init(value: "3", indexpath: IndexPath(row: 1, section: 0))
        XCTAssertEqual(card.value, "3")
        XCTAssertEqual(card.cardIndexpath?.row, 1)
        viewModel.stackedCards.append(card)
        XCTAssertTrue(viewModel.checkState(cardValue: card.value))
        
        XCTAssertNotNil((viewModel.addValidStack(selectedCard: card)))
        XCTAssertNotNil((viewModel.addValidStack(selectedCard: card)))
        card = Card.init(value: "4", indexpath: IndexPath(row: 2, section: 0))
        XCTAssertNotNil((viewModel.addValidStack(selectedCard: card)))
        card = Card.init(value: "9", indexpath: IndexPath(row: 5, section: 0))
        
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        viewController = navigationController.topViewController as? CardMainViewController
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        // The One Weird Trick!
        let _ = navigationController.view
        let _ = viewController.view
        
        viewModel.delegate = viewController
        XCTAssertNotNil(viewModel.delegate?.flipUnmatchedCard)
        XCTAssertNotNil((viewModel.addValidStack(selectedCard: card)))
        
        
        let cell = viewController.deckCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
        
        XCTAssertNotNil(cell.setData(text: card.value ))
        XCTAssertNotNil(cell.awakeFromNib())
        XCTAssertEqual(cell.textLabel.text, "9")
        XCTAssertEqual(cell.flipped, false)
        cell.setFlip(isFlipped: true)
        XCTAssertEqual(cell.flipped, true)
        
        
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(cell.flip)
            XCTAssertNotNil(cell.forceFlip)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
