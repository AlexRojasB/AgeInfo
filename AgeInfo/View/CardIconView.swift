//
//  CardIconView.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//

import SwiftUI

struct CardIconView: View {
    @EnvironmentObject var model: CarouselViewModel
    var card: Card
    var animation: Namespace.ID
    var body: some View {
        VStack(spacing: 0) {
            Text(card.subtitle)
                .font(.system(size: 22) )
                .foregroundColor(Color.white.opacity(0.85))
                .padding()
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                .matchedGeometryEffect(id: "Date-\(card.id)", in: animation)
            HStack {
                VStack(alignment: .leading, spacing: 0){
                Text(card.optionalText)
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: Color.init(red: 0, green: 0, blue: 0, opacity: 0.40), radius: 8, x: 3, y: 3)
                    .matchedGeometryEffect(id: "OptionalText-\(card.id)", in: animation)
                Text(card.title)
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: Color.init(red: 0, green: 0, blue: 0, opacity: 0.40), radius: 8, x: 3, y: 3)
                    .matchedGeometryEffect(id: "Title-\(card.id)", in: animation)
          
         
                }
                Spacer()
            }.padding(.leading, 20)
            HStack {
                Spacer()
                Image(card.title)
                    .resizable()
                    .frame(width: 98, height: 90)
                    .padding(.trailing, 20)
            }
            HStack {
                Spacer()
                Text("Read more")
                Image(systemName: "arrow.right")
                
            }.foregroundColor(Color.white.opacity(0.9))
            .padding(30)
        }
        .frame(maxWidth: 360, maxHeight: 360)
        .background(card.cardColor
                        .cornerRadius(25)
                        .matchedGeometryEffect(id: "bgColor-\(card.id)", in: animation))
        .onTapGesture {
            withAnimation(.spring()){
                
                if card.offset >= 0 {
                    model.showContent = true
                    model.selectedCard = card
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeIn){
                            model.showInfo = true
                        }
                    }
                
                }
                
            }
        }
    }
}

struct CardIconView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
