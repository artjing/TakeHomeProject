//
//  MarsNews.swift
//  Mars
//
//  Created by 董静 on 11/2/21.
//

import Foundation

struct MarsNews :Codable {
    var title: String
    var images: [image]
    var body: String
    
    // switch language
    func convertModelLanguage(_ mar: Bool) -> MarsNews {
        let title = convertAlg(self.title)
        let body = convertAlg(self.body)
        let martianMode = MarsNews(title: title, images: self.images, body: body)
        return martianMode
    }
    
    // switch algrithm
    func convertAlg(_ humanLan: String) -> String{
        // title
        let origins = humanLan.components(separatedBy: " ")
        var converted = [String]()
        for word in origins {
            if word.count > 3 {
                // first letter is capital
                let first = word[word.startIndex]
                if first > "A" && first < "Z" {
                    converted.append("Boinga")
                }else {
                    converted.append("boinga")
                }
            }else{
                converted.append(word)
            }
        }
        let result = converted.joined(separator: " ")
        return result
    }
}

struct image: Codable {
    var top_image: Bool
    var url: String
    var width: Int
    var height: Int
}
