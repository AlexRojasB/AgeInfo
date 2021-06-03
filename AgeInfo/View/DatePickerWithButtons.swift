//
//  DatePickerWithButtons.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//
import SwiftUI

struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date
    @State var selectedDate: Date = Date()
    
    var body: some View {
            VStack {
            
                DatePicker("Birthday", selection: $selectedDate, in: closedRanges(), displayedComponents: [.date]).datePickerStyle(GraphicalDatePickerStyle())
                Divider()
                HStack {
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("Cancel")
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text("Save".uppercased())
                            .bold()
                    })
                    
                }
                .padding(.horizontal)

            }
            .padding()
            .background(
                Color.white
                    .cornerRadius(30)
            )

            
        }
    
    func closedRanges() -> ClosedRange<Date> {
        let max = Date.from(year: (Int(Date().year) ?? 2020) - 10, month: 01, day: 01)!
         let min = Date.from(year: 1940, month: 01, day: 01)!
         return min...max
    }
}

struct DatePickerWithButtons_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
