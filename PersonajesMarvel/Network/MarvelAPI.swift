//
//  MarvelAPI.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 17/1/21.
//

import UIKit

enum MarvelAPIError: Error {
    case emptyData
    case httpError(CharacterDataError)
    case wrongThumbnailURL
    case emptyThumbnailURL
}

final class MarvelAPI {
    private var urlApikey:String?
    private var urlHash:String?
    private var urlTs:String?
    private let apiURL = "https://gateway.marvel.com:443/v1/public/characters"
    
    init() {
        getKeys()
    }
    
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> ()) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let queryItems = [URLQueryItem(name: "ts", value: urlTs), URLQueryItem(name: "apikey", value: urlApikey), URLQueryItem(name: "hash", value: urlHash)]
        var urlComps = URLComponents(string: apiURL)
        urlComps?.queryItems = queryItems
        
        guard let url = urlComps?.url else { return }
            
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 {
                if let data = data {
                    do {
                        let characterDataError = try decoder.decode(CharacterDataError.self, from: data)
                        DispatchQueue.main.async {
                            completion(.failure(MarvelAPIError.httpError(characterDataError)))
                        }
                        
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data{
                    do {
                        let characterDataWrapper = try decoder.decode(CharacterDataWrapper.self, from: data)
                        guard let characters = characterDataWrapper.data?.results else {
                            DispatchQueue.main.async {
                                completion(.failure(MarvelAPIError.emptyData))
                            }
                            return
                            
                        }
                        DispatchQueue.main.async {
                            completion(.success(characters))
                        }
                    } catch {
                        fatalError("\(error)")
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func fetchImage(for character: Character, completion: @escaping (Result<UIImage, Error>) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                guard let photoPath = character.thumbnail?.path else { return }
                guard  let photoExtension = character.thumbnail?.imageExtension else { return }
                let photo = "\(photoPath).\(photoExtension)"
                guard let photoUrl = URL(string: photo) else {
                    //Por si la URL de thumbnail esta vacia
                    DispatchQueue.main.async {
                        completion(.failure(MarvelAPIError.emptyThumbnailURL))
                    }
                    return
                }
                let data = try Data(contentsOf: photoUrl)
                if let thumbnail = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(thumbnail))
                    }
                }
            } catch  {
                //Por si la URL de thumbnail esta mal formada o es incorrecta
                DispatchQueue.main.async {
                    completion(.failure(MarvelAPIError.wrongThumbnailURL))
                }
            }
        }
    }
    
    func fetchCharacter(characterId: Int, completion: @escaping (Result<Character, Error>) -> ()) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let urlWithPath = apiURL.appending("/\(characterId)")
        //let urlWithPath = baseURL.appendingPathComponent("/\(characterId)")
        let queryItems = [URLQueryItem(name: "ts", value: urlTs), URLQueryItem(name: "apikey", value: urlApikey), URLQueryItem(name: "hash", value: urlHash)]
        var urlComps = URLComponents(string: urlWithPath)
        urlComps?.queryItems = queryItems
        
        guard let url = urlComps?.url else { return }
            
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 {
                if let data = data {
                    do {
                        let characterDataError = try decoder.decode(CharacterDataError.self, from: data)
                        DispatchQueue.main.async {
                            completion(.failure(MarvelAPIError.httpError(characterDataError)))
                        }
                        
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data{
                    do {
                        let characterDataWrapper = try decoder.decode(CharacterDataWrapper.self, from: data)
                        guard let characters = characterDataWrapper.data?.results else {
                            DispatchQueue.main.async {
                                completion(.failure(MarvelAPIError.emptyData))
                            }
                            return
                            
                        }
                        DispatchQueue.main.async {
                            guard let character = characters.first else {
                                DispatchQueue.main.async {
                                    completion(.failure(MarvelAPIError.emptyData))
                                }
                                return
                            }
                            
                            completion(.success(character))
                        }
                    } catch {
                        fatalError("\(error)")
                    }
                }
            }
        }
        
        task.resume()
    }
    
}

extension MarvelAPI {
    private func getKeys() {
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "apikey", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            urlApikey = dict["urlApikey"] as? String
            urlHash = dict["urlHash"] as? String
            urlTs = dict["urlTs"] as? String
        }
    }
    
    private var baseURL: URL {
        guard let baseURL = URL(string: apiURL) else {
            fatalError("URL not valid")
        }
        return baseURL
    }

}
