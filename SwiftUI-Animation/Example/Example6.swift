//
//  Example6.swift
//  SwiftUI-Animation
//
//  Created by huluobo on 2019/12/30.
//  Copyright © 2019 huluobo. All rights reserved.
//

import SwiftUI

struct Example6: View {
    @State private var moveIt = false
    
    var body: some View {
        let animation = Animation.easeInOut(duration: 1.0)
        
        return VStack(spacing: 8) {
            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .red)
                .animation(animation)

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .orange)
                .animation(animation.delay(0.1))

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .yellow)
                .animation(animation.delay(0.2))

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .green)
                .animation(animation.delay(0.3))

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .blue)
                .animation(animation.delay(0.4))

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .purple)
                .animation(animation.delay(0.5))

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .pink)
                .animation(animation.delay(0.6))

            Button(action: { self.moveIt.toggle() }) { Text("Animate") }.padding(.top, 50)
        }
         .navigationBarTitle("Example 6")
        
    }
}

struct LabelView: View {
    let text: String
    var offset: CGFloat
    var pct: CGFloat
    let backgroundColor: Color

    var body: some View {
        Text("The SwiftUI Lab")
            .font(.headline)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(backgroundColor))
            .foregroundColor(Color.black)
            .modifier(SkewedOffset(offset: offset, pct: pct, goingRight: offset > 0))

    }
}

struct SkewedOffset: GeometryEffect {
    var offset: CGFloat
    var pct: CGFloat
    let goingRight: Bool
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(offset, pct) }
        set {
            offset = newValue.first
            pct = newValue.second
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        var skew: CGFloat

        if pct < 0.2 {
            skew = (pct * 5) * 0.5 * (goingRight ? -1 : 1)
        } else if pct > 0.8 {
            skew = ((1 - pct) * 5) * 0.5 * (goingRight ? -1 : 1)
        } else {
            skew = 0.5 * (goingRight ? -1 : 1)
        }
        return ProjectionTransform(CGAffineTransform(a: 1, b: 0, c: skew, d: 1, tx: offset, ty: 0))
    }
}

struct Example6_Previews: PreviewProvider {
    static var previews: some View {
        Example6()
    }
}
