//
//  CardView.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//


import SwiftUI
import AppCenterAnalytics

struct CardView: View {
    @EnvironmentObject var model: CarouselViewModel
    var card: Card
    var animation: Namespace.ID
    var body: some View {
        VStack {
            Text(card.subtitle)
                .font(.system(size: 22) )
                .foregroundColor(Color.white.opacity(0.85))
                .padding()
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                .matchedGeometryEffect(id: "subtitle-\(card.id)", in: animation)
            ZStack(alignment: .bottom){
                Text(String(repeating: "\(card.optionalText) ", count: 12))
                    .font(.system(size: 54))
                    .foregroundColor(.white)
                    .opacity(0.12)
                    .zIndex(2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                Text(card.title)
                    .font(.system(size: card.textSize))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .shadow(color: Color.init(red: 0, green: 0, blue: 0, opacity: 0.40), radius: 8, x: 3, y: 3)
                    
                Text(card.underText)
                    .font(.system(size: 50))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .shadow(color: Color.init(red: 0, green: 0, blue: 0, opacity: 0.40), radius: 8, x: 3, y: 3)
                    .offset(CGSize(width: 0.0, height: card.textOffset))
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
                    Analytics.trackEvent("Show Detail", withProperties: ["subtitle" : card.subtitle, "title" : card.title])
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
