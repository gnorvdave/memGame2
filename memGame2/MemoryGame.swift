//
//  MemoryGame.swift
//  Wk13
//
//  Created by David Norvall on 11/10/25.
//

import Foundation

struct MemoryGame {
    struct Card: Identifiable, Equatable {
        let id: Int
        let content: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
    }
    
    private(set) var cards: [Card]
    private(set) var numberOfPairs: Int
    private(set) var flipCount: Int = 0
    private(set) var progress: Double = 0.0
    private(set) var matchedPairs: Int = 0

    private mutating func incrementProgressForMatch() {
        
        if progress > 100 { progress = 100 }
        if progress < 100.0 {
            progress += 100.0 / Double(numberOfPairs)
        }
    }
    // Helper: the index of the only face-up card (if exactly one)
    private var indexOfOnlyFaceUpCard: Int? {
        get {
            let faceUpIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpIndices.count == 1 ? faceUpIndices.first : nil
        }
        set {
            for idx in cards.indices {
                cards[idx].isFaceUp = (idx == newValue)
            }
        }
    }
    
    // Create game initializer
    init(numberOfPairsOfCards: Int, contentFactory: (Int) -> String) {
        self.numberOfPairs = numberOfPairsOfCards
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = contentFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    
    /// Choose a card in the model.
    /// - Returns: If a mismatch occurred (two non-matching face-up cards), returns the pair of IDs that should be flipped back after a delay.
    mutating func choose(card: Card) -> (firstId: Int, secondId: Int)? {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched
        else {
            return nil
        }
        flipCount += 1
        if let firstFaceUpIndex = indexOfOnlyFaceUpCard {
            // One card already face up → turn this one face up too.
            cards[chosenIndex].isFaceUp = true

            let first = cards[firstFaceUpIndex]
            let second = cards[chosenIndex]

            if first.content == second.content {
                // MATCH
                cards[firstFaceUpIndex].isMatched = true
                cards[chosenIndex].isMatched = true
                matchedPairs += 1
                incrementProgressForMatch()
                return nil               // <-- MATCH RETURN
            } else {
                // MISMATCH
                return (first.id, second.id)   // <-- MISMATCH RETURN
            }
        } else {
            // Zero or two cards face up → flip all down and make this the only face-up card
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            cards[chosenIndex].isFaceUp = true
            indexOfOnlyFaceUpCard = chosenIndex
            return nil                  // <-- SINGLE-FLIP RETURN
        }
    }
            
    mutating func flipBack(ids: (Int, Int)) {
                // Flip cards with these ids back face-down if they are still unmatched
                if let i1 = cards.firstIndex(where: { $0.id == ids.0 }),
                   let i2 = cards.firstIndex(where: { $0.id == ids.1 }) {
                    if !cards[i1].isMatched {
                        cards[i1].isFaceUp = false
                    }
                    if !cards[i2].isMatched {
                        cards[i2].isFaceUp = false
                    }
                }
            }
            
    mutating func reset() {
                flipCount = 0
                progress = 0.0
                for idx in cards.indices {
                    cards[idx].isFaceUp = false
                    cards[idx].isMatched = false
                }
                cards.shuffle()
            }
        }
    


