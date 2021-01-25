//
//  CharacterDataWrapper.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 16/1/21.
//

import Foundation

struct CharacterDataWrapper: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: CharacterDataContainer?
    let etag: String?
}

struct CharacterDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: Date?
    let resourceURI: String?
    let urls: [Url]?
    let thumbnail: Image?
    let comics: ComicList?
    let stories: StoryList?
    let events: EventList?
    let series: SeriesList?
}

struct Url: Codable {
    let type: String?
    let url: String?
}

struct Image: Codable {
    let path: String?
    let imageExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}

struct ComicList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [ComicSummary]?
    
    struct ComicSummary: Codable {
        let resourceURI: String?
        let name: String?
    }
}

struct StoryList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [StorySummary]?
    
    struct StorySummary: Codable {
        let resourceURI: String?
        let name: String?
        let type: String?
    }
}

struct EventList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [EventSummary]?
    
    struct EventSummary: Codable {
        let resourceURI: String?
        let name: String?
    }
}

struct SeriesList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [SeriesSummary]?
    
    struct SeriesSummary: Codable {
        let resourceURI: String?
        let name: String?
    }
}

struct CharacterDataError: Codable {
    let code: String?
    let message: String?
}
