//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Richa Bavadekar on 12/27/22.
//

import SwiftUI

struct ContentView: View {
    let choices = ["🪨", "📄", "✂️"]
    let winAnswers = ["📄", "✂️", "🪨"]
    let loseAnswers = ["✂️", "🪨", "📄"]

    @State private var myChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var numRounds = 0
    @State private var resetGameFlag = false
    
    var correctAnswer: String {
        if(shouldWin) {
            return winAnswers[myChoice]
        } else {
            return loseAnswers[myChoice]
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .purple, location: 0.3),
                .init(color: .indigo, location: 0.7),
                .init(color: .blue, location: 1.0)], center: .top, startRadius: 0, endRadius: 1000)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Score: \(score)")
                
                Spacer()
                
                Text("I picked \(choices[myChoice]).")
                
                Spacer()
                
                Text("Try to \(shouldWin ? "win!" : "lose!")")
                
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Make a move:")
                    
                    HStack(spacing: 20) {
                        ForEach(0..<3) { index in
                            Button(choices[index]) {
                                playerChoiceMade(choices[index])
                            }
                            .font(.system(size: 80))
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.largeTitle.bold())
            .foregroundColor(.white)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
        .alert("Game over! You scored \(score)/10.", isPresented: $resetGameFlag) {
            Button("Continue", action: resetGame)
        }
    }
    
    func playerChoiceMade(_ choice: String) {
        if(choice == correctAnswer) {
            score += 1
            scoreTitle = "Correct!"
        } else {
            score -= 1
            scoreTitle = "Wrong! I picked \(choices[myChoice]) and you were trying to \(shouldWin ? "win" : "lose"), so you should have picked \(correctAnswer)."
        }
        
        showingScore = true
        
        if(numRounds == 9) {
            resetGameFlag = true
        }
        else {
            numRounds += 1
        }
    }
    
    func askQuestion() {
        myChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func resetGame() {
        numRounds = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

