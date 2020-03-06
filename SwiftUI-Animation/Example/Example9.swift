//
//  Example9.swift
//  SwiftUI-Animation
//
//  Created by huluobo on 2020/1/13.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI

struct Example9: View {
    @State private var percent: CGFloat = 0
    
    var body: some View {
        VStack {
            Spacer()
            Indicator(pct: percent)
            
            Spacer()
            HStack(spacing: 10) {
                MyButton(label: "0%", font: .headline) {
                    withAnimation(.easeInOut(duration: 1.0)) { self.percent = 0 }
                }
                
                MyButton(label: "27%", font: .headline) {
                    withAnimation(.easeInOut(duration: 1.0)) { self.percent = 0.27 }
                }
                
                MyButton(label: "100%", font: .headline) {
                    withAnimation(.easeInOut(duration: 1.0)) { self.percent = 1.0 }
                }
            }
        }.padding().navigationBarTitle("Example 9")
    }
}

struct Indicator: View {
    var pct: CGFloat
    
    var body: some View {
        Circle()
            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 150, height: 150)
            .modifier(PercentageIndicator(pct: pct))
    }
}

struct PercentageIndicator: AnimatableModifier {    
    var pct: CGFloat = 0
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(ArcShape(pct: pct).foregroundColor(Color.red))
            .overlay(LabelView(pct: pct))
    }
    
    struct ArcShape: Shape {
        let pct: CGFloat
        
        func path(in rect: CGRect) -> Path {
            var p = Path()
            
            p.addArc(center: CGPoint(x: rect.width / 2, y: rect.height / 2),
                     radius: rect.height / 2 + 5,
                     startAngle: .degrees(0),
                     endAngle: .degrees(360 * Double(pct)),
                     clockwise: false)
            
            return p.strokedPath(.init(lineWidth: 10, dash: [6, 3], dashPhase: 10))
        }
    }
    
    struct LabelView: View {
        let pct: CGFloat
        
        var body: some View {
            Text("\(Int(pct * 100)) %")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct Example9_Previews: PreviewProvider {
    static var previews: some View {
        Example9()
    }
}
