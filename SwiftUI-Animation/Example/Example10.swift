//
//  Example10.swift
//  SwiftUI-Animation
//
//  Created by huluobo on 2020/1/13.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI

struct Example10: View {
    @State private var flag = false
    
    var body: some View {
        VStack {
            Color.clear
                .overlay(
                    WaveText(text: "The SwiftUI Lab", pct: flag ? 1.0 : 0.0, waveWidth: 6, size: 34).foregroundColor(.green)
                )
                .frame(height: 40)
        }.onAppear {
            withAnimation(Animation.easeIn(duration: 2).repeatForever()) {
                self.flag.toggle()
            }
        }.navigationBarTitle("Example 10")
    }
}

struct WaveText: View {
    let text: String
    let pct: Double
    let waveWidth: Int
    var size: CGFloat
    
    var body: some View {
        Text(text).foregroundColor(Color.clear).modifier(WaveTextModifier(text: text, waveWidth: waveWidth, pct: pct, size: size))
    }
    
    struct WaveTextModifier: AnimatableModifier {
        let text: String
        let waveWidth: Int
        var pct: Double
        var size: CGFloat
        
        var animatableData: Double {
            get { pct }
            set { pct = newValue }
        }
        
        func body(content: Content) -> some View {
            HStack {
                ForEach(Array(text.enumerated()), id: \.0) { n, ch in
                    Text(String(ch))
                        .font(Font.custom("Menlo", size: self.size).bold())
                        .scaleEffect(self.effect(self.pct, n, self.text.count, Double(self.waveWidth)))
                }
            }
        }
        
        func effect(_ pct: Double, _ n: Int, _ total: Int, _ waveWidth: Double) -> CGFloat {
            let n = Double(n)
            let total = Double(total)
            
            return CGFloat(1 + valueInCurve(pct: pct, total: total, x: n/total, waveWidth: waveWidth))
        }
        
        func valueInCurve(pct: Double, total: Double, x: Double, waveWidth: Double) -> Double {
            let chunk = waveWidth / total
            let m = 1 / chunk
            let offset = (chunk - (1 / total)) * pct
            let lowerLimit = (pct - chunk) + offset
            let upperLimit = (pct) + offset

            guard x >= lowerLimit && x < upperLimit else { return 0 }
            
            let angle = ((x - pct - offset) * m)*360-90
            
            return (sin(angle.rad) + 1) / 2
        }
    }
}

extension Double {
    var rad: Double { return self * .pi / 180 }
    var deg: Double { return self * 180 / .pi }
}

struct Example10_Previews: PreviewProvider {
    static var previews: some View {
        Example10()
    }
}
