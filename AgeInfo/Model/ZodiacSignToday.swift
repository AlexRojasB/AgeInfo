//
//  ZodiacSignToday.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//
import Foundation

struct DecodableZodiacSign: Decodable, Encodable {
    let Sign: ZodiacSignToday
    
    private struct DynamicCodingKeys: CodingKey {
        
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var obj = ZodiacSignToday(Icon: "", Daily: "", Health: "", Love: "", Carrer: "")
        for key in container.allKeys {
            if key.stringValue == "Desc" || key.stringValue == "Date" {
                continue
            }
           obj = try container.decode(ZodiacSignToday.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            
        }
        Sign = obj
    }
    
}

struct ZodiacSignToday: Decodable, Encodable {
    let Icon : String
    let Daily: String
    let Health: String
    let Love: String
    let Carrer: String?
}

