//
//  WordSell.swift
//  Game
//
//  Created by Alia on 31.10.2023.
//

import SwiftUI

struct WordSell: View {
    
    var word: String
    
    var body: some View {
        
        HStack {
            Text(word)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
                .font(.custom ("AvenirNext-Bold", size: 22))
            
            Text("\(word.count)")
                .padding()
                .font(.custom ("AvenirNext-Bold", size: 22))
        }
        
    }
}

struct WordSell_Previews: PreviewProvider {
    static var previews: some View {
        WordSell(word: "Magnit")
    }
}
