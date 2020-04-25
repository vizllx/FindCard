//
//  CardMainViewController.swift
//  iOSDemoSingtel
//
//  Created by Sandeep Mukherjee on 24/04/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class CardMainViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var deckCollectionView: UICollectionView!
    @IBOutlet weak var countLabel: UILabel!
    
    fileprivate var viewModel: CardMainViewModel? = CardMainViewModel.init()
    
    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cells
        self.deckCollectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        viewModel?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: - Internal Methods
    @IBAction func resetAction(_ sender: Any) {
        self.viewModel?.reset()
    }
}

// MARK: - CollectionViewDataSource
extension CardMainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.dataArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let card = self.viewModel?.dataArray[indexPath.row]
        cell.setData(text: card?.value ?? "" )        
        return cell
        
    }
}
// MARK: - CollectionViewDelegate
extension CardMainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ItemCell, let matchedCards = self.viewModel?.matchedCards, let card = self.viewModel?.dataArray[indexPath.row] else {
            return
        }
        if !matchedCards.contains(where: {$0.value == card.value}) {
            cell.flip()
            self.view.isUserInteractionEnabled = false
            let newCard = Card.init(value: card.value, indexpath: indexPath)
            viewModel?.addValidStack(selectedCard:newCard)
            self.view.isUserInteractionEnabled = true
        }
    }

}

extension CardMainViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let width = view.frame.size.width / 3
        return CGSize(width: width - 15 , height: 160)
        
       }
}

// MARK: - ViewModel Delegate
extension CardMainViewController: CardMainViewModelDelegate {
    func reloadCells() {
        self.deckCollectionView.reloadData()
    }
    
    func updateCount() {
        self.countLabel.text = "\(self.viewModel?.countCellTap ?? 0 )"
    }
    
    func resetFlipAllCards() {
        guard let matchedCards = self.viewModel?.matchedCards, let unmatchedCards = self.viewModel?.stackedCards else {
            return
        }
        for card  in matchedCards  {
            guard let cell = self.deckCollectionView.cellForItem(at: card.cardIndexpath ?? IndexPath()) as? ItemCell else {
                return
            }
            cell.forceFlip()
            cell.setFlip(isFlipped: false)
        }
        
        for card  in unmatchedCards  {
            guard let cell = self.deckCollectionView.cellForItem(at: card.cardIndexpath ?? IndexPath()) as? ItemCell else {
                return
            }
            cell.forceFlip()
            cell.setFlip(isFlipped: false)
        }
        self.countLabel.text = "\(0)"
    }
    
    func flipUnmatchedCard()
    {
        guard let stackedCards = self.viewModel?.stackedCards, let matchedCards = self.viewModel?.matchedCards else {
            return
        }
        for card  in stackedCards  {
            guard let cell = self.deckCollectionView.cellForItem(at: card.cardIndexpath ?? IndexPath()) as? ItemCell else {
                return
            }
            if !matchedCards.contains(where: {$0.value == card.value}) {
                cell.setFlip(isFlipped: true)
                cell.flip()
            }
        }
        self.viewModel?.stackedCards.removeAll()
    }
    
}

