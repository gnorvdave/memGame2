//
//  FlowerMemoryGame.swift
//  Wk 13
//
//  Created by David Norvall on 11/10/25.
//

//
import Foundation
import SwiftUI

final class FlowerMemoryGame: ObservableObject {
    @Published private var model: MemoryGame

    init(pairs: Int = 6) {
        self.model = FlowerMemoryGame.createMemoryGame(pairs: pairs)
    }

    private static func createMemoryGame(pairs: Int) -> MemoryGame {
        return MemoryGame(numberOfPairsOfCards: pairs) { index in
            let images = [
                "flower1","flower2","flower3","flower4","flower5","flower6",
                "flower7","flower8","flower9","flower10","flower11","flower12"
            ]
            return images[index % images.count]
        }
    }

    var cards: [MemoryGame.Card] {
        model.cards
    }

    var progress: Double {
        model.progress
    }

    var flipCount: Int {
        model.flipCount
    }

    func choose(_ card: MemoryGame.Card) {
        
        guard Thread.isMainThread else {
            DispatchQueue.main.async { self.choose(card) }
            return
        }

        if let mismatchPair = model.choose(card: card) {
            // We have a mismatch pair returned; schedule flipping them back after a short delay
            let ids = (mismatchPair.firstId, mismatchPair.secondId)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
                guard let self = self else { return }
                // Flip back if they are still unmatched/faceUp
                self.model.flipBack(ids: ids)
            }
        }
    }

    func resetGame() {
        model.reset()
    }
}
