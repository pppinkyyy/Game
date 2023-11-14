//
//  WordsTexxtField.swift
//  Game
//
//  Created by Alia on 03.10.2023.
//

import SwiftUI

struct WordsTexxtField: View {
    
    @State var word: Binding<String>
    
    var placeholder: String
    
    var color: Color
    
    var body: some View {
        TextField(placeholder, text: word)
            .font(.title3)
            .padding()
//            .background(Color ("seaColor"))
            .cornerRadius(12)
    }
    
    
}


 
