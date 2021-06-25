//
//  LoadingView.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 6/25/21.
//

import SwiftUI

struct LoadingView: View {
    @State var isLoading: Bool = false
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: 100, height: 100)
            
            Circle()
                .trim(from: 0, to: 0.3)
                .stroke(Color.blue.opacity(0.4), lineWidth: 5)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1.1).repeatForever(autoreverses: false))
                .onAppear {
                    self.isLoading = true
                }
                .onDisappear {
                    self.isLoading = false
                }
        }
    
    }
}

struct LoadingView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoadingView()
    }
}
