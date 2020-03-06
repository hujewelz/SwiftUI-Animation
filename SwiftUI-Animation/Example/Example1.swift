//
//  Example1.swift
//  SwiftUI-Animation
//
//  Created by huluobo on 2019/12/30.
//  Copyright © 2019 huluobo. All rights reserved.
//

import SwiftUI

struct Example1: View {
    @State private var sides: Int = 2
    
    var body: some View {
        VStack {
            Example1PolygonShape(sides: sides)
                .stroke(Color.purple, lineWidth: 3)
                .padding(20)
                .animation(.easeInOut(duration: 1))
            
            HStack(spacing: 10) {
                MyButton(label: "1") {
                    self.sides = 1
                }
                MyButton(label: "3") {
                    self.sides = 3
                }
                MyButton(label: "7") {
                    self.sides = 7
                }
                MyButton(label: "30") {
                    self.sides = 30
                }
            }
            
        }.navigationBarTitle("Example 1").padding(.bottom, 50)
    }
}

struct Example1PolygonShape: Shape {
    var sides: Int
    
    private var doubleSides: Double
    
    init(sides: Int) {
        self.sides = sides
        doubleSides = Double(sides)
    }
    
    var animatableData: Double {
        get { return doubleSides }
        set { doubleSides = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        // hypotenuse
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        
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

struct Example1_Previews: PreviewProvider {
    static var previews: some View {
        Example1()
    }
}
