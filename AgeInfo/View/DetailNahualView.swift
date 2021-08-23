//
//  DetailNahualView.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 8/22/21.
//


import SwiftUI
import GoogleMobileAds

struct DetailNahualView: View {
    @EnvironmentObject var model: CarouselViewModel
    var animation: Namespace.ID
   
    var body: some View {
        VStack {
            Text(model.bday, style: .date)
                .font(.caption)
                .foregroundColor(Color.white.opacity(0.85))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top, 10)
                .matchedGeometryEffect(id: "subtitle-\(model.selectedCard.id)", in: animation)
            HStack{
                Text("\(model.selectedCard.subtitle) \(model.selectedCard.title)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 250, alignment: .leading)
                    .padding()
               
                Spacer()
            }
            if model.showInfo {
                ScrollView(.vertical, showsIndicators: false, content: {
                    HStack {
                        Text("Definition")
                        Text(model.nahual.definition)
                    }
                    
                    HStack {
                        Text("Color")
                        Text(model.nahual.color)
                    }
                    HStack {
                        Text("Day")
                        Text(model.nahual.day)
                    }
                    Text(model.selectedCard.detail)
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                    
                    VStack {
                        Text("Strengths")
                        Text(model.nahual.positiveVibes)
                    }
                    
                    VStack {
                        Text("Weaknesses")
                        Text(model.nahual.negativeVibes)
                    }
                })
            }
            Button(action: {
                withAnimation(.spring()){
                    model.showContent = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeIn){
                            model.showInfo = false
                        }
                    }
                }
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.white)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 3)
                
            }).padding(.top, 50)
            Spacer()
            GADBannerViewController()
                .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            model.selectedCard.cardColor
                .cornerRadius(25)
                .matchedGeometryEffect(id: "bgColor-\(model.selectedCard.id)", in: animation)
                .ignoresSafeArea(.all, edges: .bottom)
        ).onTapGesture {
            withAnimation(.spring()){
                model.showContent = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeIn){
                        model.showInfo = false
                    }
                }
            }
        }
    }
}

struct DetailNahualView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
