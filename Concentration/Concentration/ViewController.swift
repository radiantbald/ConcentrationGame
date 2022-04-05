//
//  ViewController.swift
//  Concentration
//
//  Created by Олег Попов on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = ConcentrationGame(numberOfPairsOfCards: (buttonCollection.count + 1) / 2)

    var touches = 0 {
        didSet{
        touchLabel.text = "Ходов сделано: \(touches)"
        }
    }
    

    var emojiCollection = ["👹", "🐤", "❤️", "👺", "💩", "👾", "🤖", "👻", "☠️", "💀", "👽", "🤡", "🐝", "🐢", "🦖", "🐙", "🦋", "🦟", "🙈", "🙉", "🐒", "🐞", "🦐", "🦑", "🦧", "🦛",]
    
    var emojiDictionary = [Int:String]()
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
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
    
    @IBOutlet weak var touchLabel: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
}

