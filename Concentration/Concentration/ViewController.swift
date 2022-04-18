//
//  ViewController.swift
//  Concentration
//
//  Created by Олег Попов on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    private(set) var touches = 0 {
        didSet{
            touchLabel.text = "Ходов сделано: \(touches)"
        }
    }
    
    
    private var emojiCollection = ["👹", "🐤", "❤️", "👺", "💩", "👾", "🤖", "👻", "☠️", "💀", "👽", "🤡", "🐝", "🐢", "🦖", "🐙", "🦋", "🦟", "🙈", "🙉", "🐒", "🐞", "🦐", "🦑", "🦧", "🦛",]
    
    private var emojiDictionary = [Int:String]()
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            emojiDictionary[card.identifier] = emojiCollection.remove(at: emojiCollection.count.arc4randomExtension)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        for index in buttonCollection.indices{
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.4787095785, blue: 0.9999938607, alpha: 1)
            }
        }
    }
    
    @IBOutlet private weak var touchLabel: UILabel!
    @IBOutlet private var buttonCollection: [UIButton]!
    
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
}

extension Int {
    var arc4randomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
