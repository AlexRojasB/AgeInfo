//
//  Home.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//

import SwiftUI

import SwiftUI
import GoogleMobileAds
var heigth = UIScreen.main.bounds.height

struct Home: View {
    @EnvironmentObject var model: CarouselViewModel
    @StateObject var aboutModel = AboutViewModel()
    @Namespace var animation
    @State var date: Date = Date(timeIntervalSinceReferenceDate: -123456789.0)
    @State var showDatePicker: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("Select your birthdate:")
                        Button(action: {
                            showDatePicker.toggle()
                        }, label: {
                            Text(date, style: .date)
                        }) .onChange(of: date, perform: { value in
                            print(value)
                            model.CreateCards(dateOfBirth: value)
                        })
                        .padding(.leading, 10)
                        Spacer()
                    }.padding(.leading, 20)
                    
                    ZStack {
                        
                        if model.cards.count > 0 {
                            ForEach(model.cards.indices.reversed(), id: \.self) {index in
                                HStack {
                                    if model.cards[index].cardType == .JustText {
                                        
                                        
                                        CardView(card: model.cards[index], animation: animation)
                                            .frame(width: getCardWidth(index: index), height: getCardHeight(index: index))
                                            .offset(y: getCardOffset(index: index))
                                            .rotationEffect(.init(degrees: getCardRotation(index: index)))
                                    } else {
                                        CardIconView(card: model.cards[index], animation: animation)
                                            .frame(width: getCardWidth(index: index), height: getCardHeight(index: index))
                                            .offset(y: getCardOffset(index: index))
                                            .rotationEffect(.init(degrees: getCardRotation(index: index)))
                                    }
                                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                }
                                .frame(height: 400)
                                .contentShape(Rectangle())
                                .offset(y: model.cards[index].offset)
                                .gesture(DragGesture(minimumDistance: 0).onChanged({ value in onChanged(value: value, index: index)}).onEnded({ value in
                                    onEnd(value: value, index: index)
                                }))
                            }
                        }
                        
                        
                        
                        if showDatePicker {
                            DatePickerWithButtons(showDatePicker: $showDatePicker, savedDate: $date, selectedDate: date)
                        }
                    }
                    .padding(.top, 25)
                    .padding(.horizontal, 30)
                    if model.cards.count > 0 {
                        Button(action: resetViews, label: {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.blue)
                                .padding()
                                .background(Color.white)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .shadow(radius: 3)
                            
                        }).padding(.top, 50)
                    }
                    Spacer()
                    
                    GADBannerViewController()
                        .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
                }
                if model.showContent {
                    DetailView(animation: animation)
                }
            }
            .navigationTitle("Age Info")
            .navigationBarItems(trailing: NavigationLink(destination: AboutView().environmentObject(aboutModel), label: { Image(systemName: "info.circle") }))
        }
    }
    
    func resetViews() {
        for index in model.cards.indices {
            withAnimation{
                model.cards[index].offset = 0
                model.swipedCard = 0
            }
        }
    }
    
    func getCardRotation(index: Int) -> Double {
        let boxWidth = Double(heigth / 3)
        let offset = Double(model.cards[index].offset)
        let angle: Double = 5
        return (offset / boxWidth) * angle
        
    }
    
    func onChanged(value: DragGesture.Value, index: Int) {
        if value.translation.height < 0  {
            print(value.translation.height)
            model.cards[index].offset = value.translation.height
        }
    }
    
    func onEnd(value: DragGesture.Value, index: Int) {
        withAnimation{
            if -value.translation.height > heigth / 3 {
                model.cards[index].offset = -heigth / 2
                model.swipedCard += 1
                print(model.cards[index].offset)
            } else if model.cards[index].offset !=  (-heigth / 2)  {
                model.cards[index].offset = 0
            }
        }
    }
    
    func getCardHeight(index: Int) -> CGFloat {
        let height: CGFloat = 400
        let cardHeight = index - model.swipedCard <= 2 ? CGFloat(index - model.swipedCard) * 35 : 70
        return height - cardHeight
    }
    
    func getCardWidth(index: Int) -> CGFloat {
        let boxWidth = UIScreen.main.bounds.width - 60 - 60
        
        return boxWidth
    }
    
    func getCardOffset(index: Int) -> CGFloat {
        return  index - model.swipedCard <= 2 ? CGFloat(index - model.swipedCard) * 30 : 60
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro Max")
    }
}
