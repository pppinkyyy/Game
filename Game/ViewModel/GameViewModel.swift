//
//  GameViewModel.swift
//  Game
//
//  Created by Alia on 04.10.2023.
//

import Foundation

enum WordError : Error {
    case sameWord
    case littleWord
    case beforeWord
    case wrongWord
    case undefinedError
}

class GameViewModel: ObservableObject {
   
    @Published var player1: Player
    @Published var player2: Player
    @Published var words = [String]()
    let word: String
    var isFirst = true
    
    init (player1: Player, player2: Player, word: String) {
        self.player1 = player1
        self.player2 = player2
        self.word = word.uppercased()
    }
    
    func validate(word: String) throws {
      
        
        guard word != self.word else {
            print("Не можна повторювати головне слово")
            throw WordError.sameWord
        }
        
        guard !(words.contains(word)) else {
            print("Це слово вже було")
            throw WordError.beforeWord
        }
        
        guard word.count > 1 else {
            print("Слово не може складатися з однієї літери")
            throw WordError.littleWord
        }
        
        return
    }
    
    func wordToChars(word: String) -> [Character] {
        var chars = [Character]()
        
        for char in word.uppercased() {
            chars.append(char)
        }
        
        return chars
    }
    
    func check(word: String) throws -> Int {
       
        let word = word.uppercased()
        
        do {
            try self.validate(word: word)
        } catch {
            throw error
        }
        
        
        var bigWordArray = wordToChars(word: self.word)
        let smallWordArray = wordToChars(word: word)
        var result = ""
        
        for char in smallWordArray {
            if bigWordArray.contains(char) {
                result.append(char)
                var i = 0
                while bigWordArray[i] != char {
                    i += 1
                }
                bigWordArray.remove(at: i)
            } else {
                throw WordError.wrongWord
            }
        }
        
        guard result == word.uppercased() else {
            print("Невідома помилка")
            return 0
        }
        
        words.append(result)
        
        if isFirst {
            player1.score += result.count
        } else {
            player2.score += result.count
        }
        
        isFirst.toggle()
        
        return  result.count
    }
}
