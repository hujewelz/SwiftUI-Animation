//
//  Example3.swift
//  SwiftUI-Animation
//
//  Created by huluobo on 2019/12/30.
//  Copyright © 2019 huluobo. All rights reserved.
//

import SwiftUI

struct Example3: View {
    @State private var sides: Int = 2
    @State private var scale: Double = 1.0
    
    var body: some View {
        VStack {
            Example3PolygonShape(sides: sides, scale: scale)
                .stroke(Color.blue, lineWidth: (sides < 3) ? 10 : ( sides < 7 ? 5 : 2))
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
                    self.scale = 1.0
                }
                MyButton(label: "7") {
                    self.sides = 7
                    self.scale = 1.0
                }
                MyButton(label: "30") {
                    self.sides = 30
                    self.scale = 1.0
                }
            }
            
        }.navigationBarTitle("Example 3").padding(.bottom, 50)
    }
}

struct Example3PolygonShape: Shape {
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
        
        var vertex: [CGPoint] = []
        
        for i in 0..<Int(doubleSides) + extra {
            let angle = (Double(i) * (360.0 / doubleSides)) * Double.pi / 180
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            
            vertex.append(pt)
            
            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }
        path.closeSubpath()
        
        // Draw vertex-to-vertex lines
        drawVertexLines(path: &path, vertex: vertex, n: 0)
        
        return path
    }
    
    func drawVertexLines(path: inout Path, vertex: [CGPoint], n: Int) {
        if vertex.count - n < 3 { return }
        
        for i in (n+2)..<min(n + (vertex.count-1), vertex.count) {
            path.move(to: vertex[n])
            path.addLine(to: vertex[i])
        }
        
        drawVertexLines(path: &path, vertex: vertex, n: n+1)
    }
}

struct Example3_Previews: PreviewProvider {
    static var previews: some View {
        Example3()
    }
}
