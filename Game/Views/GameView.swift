//
//  GameView.swift
//  Game
//
//  Created by Alia on 03.10.2023.
//

import SwiftUI

struct GameView: View {
    
    @State private var word = ""
    var viewModel: GameViewModel
    @State private var confirmPresent = false
    @State private var isAlertPresent = false
    @State var alertText = ""
    
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            HStack {
                Button {
                    confirmPresent.toggle()
                } label: {
                    Text("Вихід")
                        .padding(6)
                        .padding(.horizontal)
                        .cornerRadius(10)
                        .padding(6)
                        .foregroundColor(.black)
                        .font(.custom("AvenirNext-Bold", size: 18))
                }
                Spacer()
            }
            
            Text(viewModel.word)
                .font(.custom("AvenirNext-Bold", size: 25))
            
            HStack(spacing: 12) {
                
                VStack {
                    Text("\(viewModel.player1.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                    
                    Text(viewModel.player1.name)
                        .font(.custom("AvenirNext-Bold", size: 22 ))
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color ("cheekColor"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ? .black : .clear, radius: 8)
                
                VStack {
                    Text("\(viewModel.player2.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                    
                    Text(viewModel.player2.name)
                        .font(.custom("AvenirNext-Bold", size: 22))
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color ("cheekColor2"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ? .clear : .black, radius: 8)
            }
            
            WordsTexxtField(word: $word, placeholder: "Ваше слово...", color: Color("grayCasper"))
                .font(.title3)
                .background(Color("grayCasper"))
                .cornerRadius(16)
                .padding()
            
            Button {
                
                var score = 0
                
                do {
                    try score = viewModel.check(word: word)
                } catch WordError.beforeWord {
                    alertText = "Це слово вже було"
                    isAlertPresent.toggle()
                } catch WordError.littleWord {
                    alertText = "Cлово не може складатись з однієї літери"
                    isAlertPresent.toggle()
                } catch WordError.sameWord {
                    alertText = "Не можна повторювати головне слово"
                    isAlertPresent.toggle()
                } catch WordError.wrongWord {
                    alertText = "Неможливо додати таке слово"
                    isAlertPresent.toggle()
                } catch {
                    alertText = "Невідома помилка"
                    isAlertPresent.toggle()
                }
                
                
                if score > 1 {
                    self.word = ""
                }
                
            } label: {
                Text("Готово")
                    .padding(12)
                    .foregroundColor(.black)
                    .font(.custom("AvenirNext-Bold", size: 26))
                    .frame(maxWidth: .infinity)
                    .background(Color ("grayCasper"))
                    .cornerRadius(16)
                    .padding(.horizontal)
                   
                
            }
            
            List {
                ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                    WordSell(word: self.viewModel.words [item])
                        .background(item % 2 == 0 ? Color("cheekColor") : Color("cheekColor2"))
                        .listRowInsets(EdgeInsets())
                }
            }

            
                .listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)




            
        }
            .background(Image("duckBoom"))
            .confirmationDialog("Ви впевнені, що хочете покинути гру?",
                                isPresented: $confirmPresent,
                                titleVisibility: .visible) {
                
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("Закінчити гру")
                }
                
                Button(role: .cancel) { } label: {
                    Text("Залишитись у грі")
                }

            }
               .alert(alertText,
                    isPresented: $isAlertPresent) {
                    Text("Oк")
                }

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Саша"),
                                          player2: Player(name: "Даша"),
                                          word: "Інсулінорезистентність"))
    }
}
