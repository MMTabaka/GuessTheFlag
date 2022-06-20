//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Milosz Tabaka on 21/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Group {
            Spacer()
            Text("1")
            Text("1")
            Text("1")
            Text("1")
                Text("1")
                Text("1")
                Text("1")
            }
            Group {
            Text("1")
            Text("1")
            Text("1")
            Text("1")
            Text("1")
                Text("1")
                Text("1")
                Text("1")
            }
            Text("1")
            Text("1")
            Text("1")
            
            Spacer()
            Spacer()
            Spacer()
        }
        .border(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
