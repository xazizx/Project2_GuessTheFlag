//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Aziz Baubaid on 24.06.23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingReset = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria",
                     "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)  //wanna show three flags randomly, one is correct answer. this generate an index for list
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.27, green: 0.5, blue: 0.65), location: 0.3),
                .init(color: Color(red: 0.87, green: 0.6, blue: 0.18), location: 0.3),
            ], center: .top, startRadius: 700, endRadius: 800)
            .ignoresSafeArea()
            
            Spacer()
            
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 25) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.headline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .shadow(radius: 10)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Button("New game") {
                        showingReset = true
                    }
                    .buttonStyle(.borderedProminent)
                    .alert("Reset score", isPresented: $showingReset) {
                        Button("Reset", role: .destructive, action: resetScore)
                        Button("Cancel", role: .cancel, action: {})
                    } message: {
                        Text("Are you sure, you want to reset your score?")
                        
                        Spacer()
                        
                    }
                }
            }
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {  //to ask next question
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetScore() {
        self.score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
