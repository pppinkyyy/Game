//
//   TitleText.swift
//  Game
//
//  Created by Alia on 03.10.2023.
//

import SwiftUI

struct _TitleText: View {
    
    @State var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .font(.custom("AvenirNext-Bold", size: 42))
            .frame(maxWidth: .infinity)
            .background(Color ("seaColor"))
            .foregroundColor(Color(.black))
    }
}

struct _TitleText_Previews: PreviewProvider {
    static var previews: some View {
        _TitleText(text: "")
    }
}
