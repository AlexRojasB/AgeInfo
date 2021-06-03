//
//  ContentView.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeModel = CarouselViewModel()
    var body: some View {
        Home()
            .environmentObject(homeModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
