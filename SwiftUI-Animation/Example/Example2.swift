//
//  Example2.swift
//  SwiftUI-Animation
//
//  Created by huluobo on 2019/12/30.
//  Copyright © 2019 huluobo. All rights reserved.
//

import SwiftUI

struct Example2: View {
    @State private var sides: Int = 2
    @State private var scale: Double = 1.0
    
    var body: some View {
        VStack {
            Example2PolygonShape(sides: sides, scale: scale)
                .stroke(Color.purple, lineWidth: 3)
                .padding(20)
                .animation(.easeInOut(duration: 1))
                .layoutPriority(1)
            
            HStack(spacing: 10) {
                MyButton(label: "1") {
                    self.sides = 1
                    self.scale = 1.0
                }
                MyButton(label: "3") {
                    self.sides = 3
                    self.scale = 0.7
                }
                MyButton(label: "7") {
                    self.sides = 7
                    self.scale = 0.4
                }
                MyButton(label: "30") {
                    self.sides = 30
                    self.scale = 1.0
                }
            }
            
        }.navigationBarTitle("Example 2").padding(.bottom, 50)
    }
}

struct Example2PolygonShape: Shape {
    var sides: Int
    var scale: Double
    
    private var doubleSides: Double
    
    init(sides: Int, scale: Double) {
        self.sides = sides
        self.scale = scale
        doubleSides = Double(sides)
    }
    
    var animatableData: AnimatablePair<Double, Double> {
        get { return AnimatablePair(doubleSides, scale) }
        set {
            doubleSides = newValue.first
            scale = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        // hypotenuse
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0 * scale
        
        // center
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
                
        let extra: Int = doubleSides != Double(Int(doubleSides)) ? 1 : 0
        
        for i in 0..<Int(doubleSides) + extra {
            let angle = (Double(i) * (360.0 / doubleSides)) * Double.pi / 180
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            
            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }
        path.closeSubpath()
        return path
    }
}

struct Example2_Previews: PreviewProvider {
    static var previews: some View {
        Example2()
    }
}
