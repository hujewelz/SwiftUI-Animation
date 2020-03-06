//
//  ContentView.swift
//  SwiftUI-Animation
//
//  Created by huluobo on 2019/12/30.
//  Copyright © 2019 huluobo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Part 1: Path Animations")) {
                    NavigationLink(destination: Example1()) {
                        Text("Example 1 (sides)")
                    }
                    NavigationLink(destination: Example2()) {
                        Text("Example 2 (sides, scale)")
                    }
                    NavigationLink(destination: Example3()) {
                        Text("Example 3 (sides, vertex)")
                    }
                    NavigationLink(destination: Example4()) {
                        Text("Example 4 (ClockTime)")
                    }
                    NavigationLink(destination: Example5()) {
                        Text("Example 5 (Flower)")
                    }
                }
                
                Section(header: Text("Part 2: GeometryEffect")) {
                    NavigationLink(destination: Example6()) {
                        Text("Example 6 (skew)")
                    }
                    NavigationLink(destination: Example7()) {
                        Text("Example 7 (card)")
                    }
                }
                
                Section(header: Text("Part 3: AnimatableModifier")) {
                    NavigationLink(destination: Example9()) {
                        Text("Example 9 (indicator)")
                    }
                    NavigationLink(destination: Example10()) {
                        Text("Example 10 (wavetext)")
                    }
                }

            }.navigationBarTitle("SwiftUI Animations")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
