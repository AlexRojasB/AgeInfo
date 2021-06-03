//
//  CarouselViewModel.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//


import SwiftUI

class CarouselViewModel: ObservableObject {
    var chineseAnimal: LocalInformation = LocalInformation(title: "", detail: "")
    var generation: LocalInformation = LocalInformation(title: "", detail: "")
    var date: DateFormatter = DateFormatter()
    var bday = Date()
    @Published var cards: [Card] = []
    
    func CalculateAge(date: Date) -> String {
      
        
        let calender = Calendar.current
        
        let dateComponent = calender.dateComponents([.year, .month, .day], from:
                                                        date, to: Date())
        
        return "\(dateComponent.year!)"
    }
    
    func CreateCards(dateOfBirth: Date) {
        cards.removeAll()
        swipedCard = 0
        showInfo = false
        showContent = false
        bday = dateOfBirth
        let index = GetChineseAnimalIndex(year: Int(dateOfBirth.year)!)
        chineseAnimal = GetLocalInformation(index: index, fileName: "ChineseHoroscope")
        generation = GetLocalInformation(index: dateOfBirth.GenerationIndex, fileName: "Generations")
        let ageCard =  Card(cardColor: Color(UIColor.init(hex:"#2AC0D3")), title: CalculateAge(date: dateOfBirth), subtitle: "Your age is:", optionalText: CalculateAge(date: dateOfBirth), underText: "years" , cardType: .JustText)
        let zodiacCard = Card(cardColor: Color(UIColor.init(hex: "#C42D9C")), title: dateOfBirth.zodiacSign.rawValue.lowercased(), subtitle: "In the greek zodiac:", optionalText: "You are")
        let chineseCard =  Card(cardColor: Color(UIColor.init(hex:"#5E67D8")), title: chineseAnimal.title, subtitle: "In the chinese zodiac:", optionalText: "You are the", detail: chineseAnimal.detail)
        let generationCard = Card(cardColor: Color(UIColor.init(hex: "#F86B6B")), title: generation.title, subtitle: "Your generation is:", optionalText: "Generation", detail: generation.detail)
        let yearCard = Card(cardColor: Color(UIColor.init(hex: "#59B96B")), title: dateOfBirth.year, subtitle: "When you were born:", cardType: .JustText, textSize: 100, textOffset: -30)
        
        cards.append(ageCard)
        cards.append(zodiacCard)
        cards.append(chineseCard)
        cards.append(generationCard)
        cards.append(yearCard)
        
        GetNumberContent(numberValue: CalculateAge(date: dateOfBirth), category: "math", index: 0)
        GetZodiacContent(sign: dateOfBirth.zodiacSign.rawValue)
        GetNumberContent(numberValue: dateOfBirth.year, category: "year", index: 4)
    }
    
    func GetChineseAnimalIndex(year: Int) -> Int {
        let modifiedYears = year - 4
        let reduceYear = modifiedYears / 12
        let rebuildYear = reduceYear * 12
        let animalIndex = abs( modifiedYears - rebuildYear)
        return animalIndex
    }
    
    func ParseAnimals(jsonData: Data) -> [LocalInformation]? {
        do {
            let decodedData = try JSONDecoder().decode([LocalInformation].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func GetLocalInformation(index: Int, fileName: String) -> LocalInformation {
        let jsonData = readLocalJSONFile(forName: fileName)
        if let data = jsonData {
            if let sampleRecordObj = ParseAnimals(jsonData: data) {
                return sampleRecordObj[index]
            }
        }
        return LocalInformation(title: "", detail: "")
    }
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    private func GetZodiacContent(sign: String) {
        let urlString = API.getNSUrlForZodiac(sign: sign)
        
        NetworkManager<DecodableZodiacSign>.fetch(for: urlString) {
            (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.cards[1].detail = response.Sign.Daily
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func GetNumberContent(numberValue: String, category: String, index: Int) {
        let urlString = API.getNSUrlForNumbers(value: numberValue, category: category)
        
        NetworkManager<MathFact>.fetch(for: urlString) {
            (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.cards[index].detail = response.text
                    if let someDate = response.date {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMMM dd"
                        if let date2 = dateFormatter.date(from: someDate)
                        {
                            dateFormatter.dateFormat = "dd MMM"
                            let convertedDate =  dateFormatter.string(from: date2)
                            self.cards[index].optionalText = convertedDate
                            self.cards[index].underText = convertedDate
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    @Published var swipedCard = 0
    @Published var showContent = false
    @Published var selectedCard = Card(cardColor: .clear, title: "", subtitle: "")
    @Published var showInfo = false
}
