//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Milosz Tabaka on 21/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(role: .destructive) {
            print("Now deleting")
        } label: {
            Label("Edit", systemImage: "pencil")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
