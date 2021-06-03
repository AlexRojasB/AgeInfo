//
//  AboutViewModel.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/26/21.
//

import Foundation
import UIKit
import AppCenterAnalytics

class AboutViewModel: ObservableObject {
    @Published var peopleToThanks: [PeopleHelp] = []
    
    init() {
        peopleToThanks = GetLocalInformation(fileName: "PeopleToThanks")
    }
    
    public func OpenBrowser(website: String) {
        if let url = URL(string: website) {
            UIApplication.shared.open(url)
        }
    }
    
    func ParseData(jsonData: Data) -> [PeopleHelp]? {
        do {
            let decodedData = try JSONDecoder().decode([PeopleHelp].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func GetLocalInformation(fileName: String) -> [PeopleHelp] {
        let jsonData = readLocalJSONFile(forName: fileName)
        if let data = jsonData {
            if let sampleRecordObj = ParseData(jsonData: data) {
                return sampleRecordObj
            }
        }
        return Array<PeopleHelp>()
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
}
