//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Milosz Tabaka on 21/06/2022.
//

import SwiftUI

struct FlagImage: View {
    let image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingEnd = false
    
    @State private var scoreTitle = ""
    @State private var score = 0
    let numOfQuestions = 3
    @State private var currentQuestion = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland",  "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var rotationDegree: Double = 0
    @State private var pickedFlag: Int = 0
    @State private var tapped = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.1),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.9),
            ], center: .top, startRadius: 200, endRadius: 1000)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.heavy))
                            .foregroundStyle(.primary)
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation() {
                            flagTapped(number)
                            pickedFlag = number
                            rotationDegree += 360
                            tapped.toggle()
                            }
                            rotationDegree = 0
                        } label: {
                            FlagImage(image: countries[number])
                                .rotation3DEffect(.degrees(number == pickedFlag ? rotationDegree : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(tapped && (number != pickedFlag) ? 0.25 : 1)
                                .scaleEffect(tapped ? 0.6 : 1)
                                .animation(.easeIn, value: tapped)
                                .transition(.scale)
                                
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                
                Spacer()
                Spacer()
                
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert("Game over", isPresented: $showingEnd) {
            Button("Play again") {
                score = 0
                currentQuestion = 0
                askQuestion()
            }
        } message: {
            Text("Your score is \(score)/\(numOfQuestions)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        
        currentQuestion += 1
        
        if currentQuestion == numOfQuestions {
            showingEnd = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        tapped.toggle()
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
