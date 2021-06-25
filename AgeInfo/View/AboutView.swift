//
//  AboutView.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/26/21.
//

import SwiftUI
import AppCenterAnalytics

struct AboutView: View {
    @EnvironmentObject var model: AboutViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 5) {
                Image("AgeInfo")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                VStack(alignment: .leading, spacing: 5){
                    Text("Developed by: Alexander Rojas")
                        .font(.title3)
                        .bold()
                    Text("Thanks to:")
                        .font(.title2)
                    if model.peopleToThanks.count > 0 {
                        ForEach(model.peopleToThanks.indices.reversed(), id: \.self) { index in
                            HStack {
                                Text(model.peopleToThanks[index].descr)
                                    .italic()
                                Link(model.peopleToThanks[index].name, destination: URL(string: model.peopleToThanks[index].website)!)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Report a")
                            .font(.subheadline)
                            .bold()
                        Link("bug", destination: URL(string: "https://github.com/AlexRojasB/AgeInfo/issues")!)
                    }
                    .padding(.top, 30)
                    .onAppear {
                        Analytics.trackEvent("Show About Page")
                    }
                    HStack {
                        Text("Follow me on: ")
                        Image("twitter")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .trailing)
                            .onTapGesture {
                                model.OpenBrowser(website: "https://twitter.com/alexrrojasb")
                            }
                        Image("github")
                            .resizable()
                            .frame(width: 35, height: 35, alignment: .trailing)
                            .onTapGesture {
                                model.OpenBrowser(website: "https://github.com/AlexRojasB/")
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                Spacer()
                Button (action: {
                    model.OpenBrowser(website: "https://www.questionpro.com/t/AS3hpZmvkT")
                }, label: {
                    Text("Give us Feedback")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                }).frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(UIColor.init(hex: "#14C9F4")))
                .cornerRadius(28)
                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                
                Link("Privacy Policy", destination: URL(string: "https://sites.google.com/view/ageinfo-privacypolicies/inicio")!)
                Text("Version \(Bundle.main.release)")
            }.padding()
        }
        .navigationTitle("About Age Info")
    }
}

struct AboutView_Previews: PreviewProvider {
    @StateObject static var aboutModel = AboutViewModel()
    static var previews: some View {
        
        AboutView().environmentObject(aboutModel)
    }
}
