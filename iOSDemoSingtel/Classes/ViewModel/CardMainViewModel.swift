//
//  CardMainViewModel.swift
//  iOSDemoSingtel
//
//  Created by Sandeep Mukherjee on 24/04/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import Foundation

// MARK: - Protocol declaration
protocol CardMainViewModelProtocol: class {
    func  isExist(num: String) -> String
    func  checkState(cardValue: String) -> Bool
    func  addValidStack(selectedCard: Card)
    func  reset()
    func  initGridData()
}

// MARK: - Delegate declaration
protocol CardMainViewModelDelegate: class {
    func flipUnmatchedCard()
    func resetFlipAllCards()
    func updateCount()
    func reloadCells()
}

class CardMainViewModel:CardMainViewModelProtocol {
    // MARK: - Properties
    internal var stackedCards:[Card] = []
    internal var matchedCards:[Card] = []
    internal var dataArray:[Card] = []
    internal var countCellTap = 0
    internal weak var delegate:CardMainViewModelDelegate?
    
    // MARK: - Init methods
    init() {
        initGridData()
    }
    
    func initGridData(){
        var i = 0
        while i < Main_Constants.maxCards/2 {
            let randomNumber = Helper.random(digits: 2)
            let card = Card.init(value: (self.isExist(num: randomNumber)))
            self.dataArray.append(card)
            i = i + 1
        }
        i = 0
        while i < Main_Constants.maxCards/2 {
            self.dataArray.append((self.dataArray[i]))
            i = i + 1
        }
        self.dataArray.shuffle()
    }
    
    // MARK: - Protocol definition
    func isExist(num: String) -> String {
        for cards  in self.dataArray {
            if (cards.value == num) {
                return Helper.random(digits: 2)
            }
        }
        return num
        
    }
    
    func checkState(cardValue: String) -> Bool {
        var isFlipped = false
        for card  in self.stackedCards {
            let value = card.value
            if(value == cardValue) {
                isFlipped = true
                break
            }
        }
        return isFlipped
        
    }
    
    func addValidStack(selectedCard: Card) {
        countCellTap = countCellTap + 1
        self.delegate?.updateCount()
        if(self.stackedCards.isEmpty) {
            self.stackedCards.append(selectedCard)
        }
        else {
            var isMatch = false
            for card  in self.stackedCards {
                let value = card.value
                
                if ( value ==  selectedCard.value) {
                    isMatch = true
                    self.stackedCards.append(selectedCard)
                    for index  in self.stackedCards
                    {
                        self.matchedCards.append(index)
                    }
                    self.stackedCards.removeAll()
                    return
                }
            }
            if ( !isMatch) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { 
                    self.stackedCards.append(selectedCard)
                    self.delegate?.flipUnmatchedCard()
                }
            }
        }
    }
    
    func reset() {
        self.delegate?.resetFlipAllCards()
        stackedCards.removeAll()
        matchedCards.removeAll()
        dataArray.removeAll()
        countCellTap = 0
        initGridData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.delegate?.reloadCells()
        }
    }
}
