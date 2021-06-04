//
//  DetailView.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//


import SwiftUI
import GoogleMobileAds
import AppCenterAnalytics

struct DetailView: View {
    @EnvironmentObject var model: CarouselViewModel
    var animation: Namespace.ID
    let reviewService = ReviewService.shared
   
    var body: some View {
        VStack {
            Text(model.bday, style: .date)
                .font(.caption)
                .foregroundColor(Color.white.opacity(0.85))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top, 10)
                .matchedGeometryEffect(id: "Date-\(model.selectedCard.id)", in: animation)
            HStack{
                Text("\(model.selectedCard.subtitle) \(model.selectedCard.title)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 250, alignment: .leading)
                    .padding()
                    .matchedGeometryEffect(id: "Subtitle-\(model.selectedCard.id)", in: animation)
                Spacer()
            }
            if model.showInfo {
                ScrollView(.vertical, showsIndicators: false, content: {
                    Text(model.selectedCard.detail)
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                })
            }
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
        }.onAppear {
            if model.swipedCard == 2 {
                reviewService.requestReview()
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
