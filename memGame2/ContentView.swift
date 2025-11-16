//  ContentView.swift
//  WK 13 
// Dave Norvall
//
//  Created by David Norvall on 11/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlowerMemoryGame()

    private let columns = [GridItem(.adaptive(minimum: 80), spacing: 16)]

    var body: some View {
        VStack(spacing: 12) {
            Text("Flips: \(viewModel.flipCount)")
                .font(.headline)
                .foregroundColor(.black)
                .padding()
            // Progress
            let percent = Int(viewModel.progress.rounded())
            ProgressView(value: viewModel.progress, total: 100.0)
                .frame(height: 12)
                .padding(.horizontal)
            Text("Progress: \(percent) %")
                .font(.caption)
            Button(action: {
                viewModel.resetGame()
            }) {
                Text("Reset Game")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(40)
            }
            .padding(.bottom, 10)


            Text("Memory Game")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .bold()
                .padding(.top, 8)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.cards) { card in
                        FlowerCard(card: card)
                            .aspectRatio(1, contentMode: .fit)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.45)) {
                                    viewModel.choose(card)
                                }
                            }
                    }
                }
                .padding()
            }

            HStack {
                
                Button("Reset") {
                    withAnimation {
                        viewModel.resetGame()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

struct FlowerCard: View {
    let card: MemoryGame.Card

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10.0)

            // Front (content)
            if card.isFaceUp || card.isMatched {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 2).foregroundColor(.blue)
                if let uiImageName = Optional(card.content) {
                    Image(uiImageName)
                        .resizable()
                        .scaledToFit()
                        .padding(8)
                }
            } else {
                // Back
                shape.fill(Color.blue)
            }
        }
        .rotation3DEffect(.degrees(card.isFaceUp ? 0 : 180), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.9), value: card.isFaceUp)
        .padding(4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
