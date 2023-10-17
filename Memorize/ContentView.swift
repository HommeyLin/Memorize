//
//  ContentView.swift
//  Memorize
//
//  Created by saruttaya attramongkol on 10/10/2566 BE.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["🎃", "👻", "💀", "☠️", "💩", "🤡", "👹", "😈", "👺", "👾"] + ["🎃", "👻", "💀", "☠️", "💩", "🤡", "👹", "😈", "👺", "👾"]
    @State var cardCount = 4
    var body: some View {
        Text("Memorize")
        VStack{
            ScrollView{
                cards
            }
            cardAdjuster
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardAdjuster:some View {
        HStack {
            cardRemove
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }) {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemove: some View{
        cardCountAdjuster(by: -1, symbol:
                "rectangle.stack.fill.badge.minus")
    }
    var cardAdder:some View{
        cardCountAdjuster(by: 1, symbol:
                "rectangle.stack.fill.badge.plus")
    }
}



struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
            
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
