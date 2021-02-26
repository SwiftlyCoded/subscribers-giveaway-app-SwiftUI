//
//  ContentView.swift
//  results
//
//  Created by Alex on 11/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var start = false
    
    var body: some View {
        ZStack {
            
            Color(#colorLiteral(red: 0.001361070666, green: 0.2501289248, blue: 0.4535972476, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            IntroScreen(start: $start)
                .fullScreenCover(isPresented: $start){
                    Raffle()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct IntroScreen: View{
    
    @Binding var start: Bool
    
    var body: some View{
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 250, height: 250)
            
            Text("Swiftly Coded")
            Text("Giveaway")
            
            
            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    start.toggle()
                }
            }){
                Text("Pick a winner")
                    .font(.system(size: 20, weight: .bold))
            }
            .padding()
            .background(Color(#colorLiteral(red: 0.9508441091, green: 0.3494752049, blue: 0.2117037177, alpha: 1)))
            .cornerRadius(20)
            .padding(.top, 30)
        }
        .foregroundColor(.white)
        .font(.system(size: 45, weight: .bold))
    }
}

struct Raffle: View{
    
    @State var subs: [String.SubSequence] = []
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @State private var winner: String = ""
    @State private var winnerIsPicked = false
    @State private var animation = false
    @State private var winnerAnimation = false
    @State private var countdown = 6
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View{
        
        ZStack {
            
            Color(#colorLiteral(red: 0.001361070666, green: 0.2501289248, blue: 0.4535972476, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                if !winnerIsPicked {
                    ForEach(0..<subs.count, id: \.self){ i in
                        Text(subs[i])
                            .offset(x: animation ? CGFloat.random(in: -width / 2...width / 2) : 0, y: animation ? CGFloat.random(in: -height / 2...height / 2) : 0)
                            .scaleEffect(animation ? 3 : 0)
                            .opacity(animation ? 1 : 0)
                            .animation(Animation.easeInOut(duration: Double.random(in: 0.5...2)).repeatForever())
                            
                            .foregroundColor(Color.random)
                            .font(.system(size: 35, weight: .bold))
                    }
                }
                
                else if winner.isEmpty{
                    Text("\(countdown)")
                        .font(.system(size: 150, weight: .bold))
                        .foregroundColor(countdown < 4 ? .red : .white)
                        .onReceive(timer) { time in
                            if self.countdown > 0 {
                                self.countdown -= 1
                            }
                        }
                }
                
                else {
                    Text(winner)
                        .font(.system(size: 55, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .onAppear{
                subs = readFile()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    animation.toggle()
                }
            }
            
        }
        
        .onTapGesture {
            play(sound: "winnerSound", type: "mp3")
            winnerIsPicked = true            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6){
                winner = String(subs.randomElement()!)
            }
        }
        
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

