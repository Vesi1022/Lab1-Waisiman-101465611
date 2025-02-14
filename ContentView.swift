//
//  ContentView.swift
//  Lab1- Waisiman Maimaiti -101465611

import SwiftUI

struct ContentView: View {
    @State private var number = Int.random(in: 1...100)
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var attempts = 0
    @State private var showResultDialog = false
    @State private var feedback: Bool? = nil
    @State private var timer: Timer? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("Is this number prime?").font(.title).bold()
            Text("\(number)").font(.system(size: 80, weight: .bold))
           
            HStack(spacing: 30) {
                answerButton(title: "Prime", isPrime: true)
                answerButton(title: "Not Prime", isPrime: false)
            }
           
            if let feedback = feedback {
                Image(systemName: feedback ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .resizable().frame(width: 50, height: 50)
                    .foregroundColor(feedback ? .green : .red)
            }
        }
        .padding()
        .onAppear(perform: startTimer)
        .alert("Game Summary", isPresented: $showResultDialog, actions: {
            Button("OK", action: resetGame)
        }, message: {
            Text("Correct: \(correctAnswers)\nWrong: \(wrongAnswers)")
        })
    }

    private func isPrime(_ n: Int) -> Bool {
        guard n > 1 else { return false }
        if n == 2 { return true }
        if n % 2 == 0 { return false }
        return !stride(from: 3, through: Int(Double(n).squareRoot()), by: 2).contains { n % $0 == 0 }
    }

    private func answerButton(title: String, isPrime: Bool) -> some View {
        Button(action: { checkAnswer(isPrime) }) {
            Text(title).font(.title).padding().frame(width: 120)
                .background(Color.blue.opacity(0.8)).foregroundColor(.white).cornerRadius(12)
        }
    }

    private func checkAnswer(_ isPrimeChoice: Bool) {
        let isCorrect = isPrimeChoice == isPrime(number)
        feedback = isCorrect
        isCorrect ? (correctAnswers += 1) : (wrongAnswers += 1)
        attempts += 1
        if attempts % 10 == 0 { showResultDialog = true }
        number = Int.random(in: 1...100)
        resetTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { feedback = nil }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            wrongAnswers += 1
            attempts += 1
            number = Int.random(in: 1...100)
            if attempts % 10 == 0 { showResultDialog = true }
        }
    }

    private func resetTimer() {
        timer?.invalidate()
        startTimer()
    }

    private func resetGame() {
        correctAnswers = 0
        wrongAnswers = 0
        attempts = 0
        number = Int.random(in: 1...100)
        startTimer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
