//
//  ContentView.swift
//  Game
//
//  Created by Alia on 28.09.2023.
//

import SwiftUI

struct StartView: View {
    
    @State var bigWord = ""
    @State var firstPlayer = ""
    @State var secondPlayer = ""
    
    @State var isshowedGame = false
    @State var isAlertPresented = false
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            _TitleText(text: "Гра Слів")
            
            WordsTexxtField(word: $bigWord, placeholder: "Введіть слово...", color: Color ("seaColor"))
                .font(.title3)
                .background(Color ("seaColor"))
                .cornerRadius(12)
                .padding(20)
                .padding(.bottom, 20)
                .padding(.top, 30)
            
            WordsTexxtField(word: $firstPlayer, placeholder: "Гравець 1", color: Color ("seaColor"))
                .font(.title3)
                .background(Color ("seaColor"))
                .cornerRadius(12)
                .padding(20)
                .padding(.bottom, -18)
                 
            
            WordsTexxtField(word: $secondPlayer, placeholder: "Гравець 2", color: Color ("seaColor"))
                .font(.title3)
                .background(Color ("seaColor"))
                .cornerRadius(12)
                .padding(.bottom, 110)
                .padding(.horizontal, 20)
                 
            Button {
                
                if bigWord.count > 6 {
                    isshowedGame.toggle()
                } else {
                    isAlertPresented.toggle()
                }
                
            } label: {
                Text("Почати гру")
                    .font(.custom("AvenirNext-Bold", size: 36))
                    .padding(.horizontal, 64)
                    .background(Color ("seaColor"))
                    .cornerRadius(40)
                    .padding(.top, 209)
                    .foregroundColor(Color ("deepSee"))
                  
            }

            
        }.background(Image ("sleepyCat")
            .alert("Слово має складатись мінімум з 7 літер", isPresented: $isAlertPresented, actions: {
                    Text("Ок")
                })
            .fullScreenCover(isPresented: $isshowedGame, content: {
                
                let name1 = firstPlayer == "" ? "Гравець 1" : firstPlayer
                let name2 = secondPlayer == "" ? "Гравець 2" : secondPlayer
                
                let player1 = Player(name: name1)
                let player2 = Player(name: name2)
                
                let gameViewModel = GameViewModel(player1: player1,
                                                  player2: player2,
                                                   word: bigWord)
                
                GameView(viewModel: gameViewModel)
            }) 
    
            )
           
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
