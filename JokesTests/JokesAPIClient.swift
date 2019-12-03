//
//  JokesAPIClient.swift
//  Jokes
//
//  Created by Eric Davenport on 12/3/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import Foundation

enum NetworkingError: Error {  // need top conform to error protocol
  case badURL(String)  // associted value
  case newtworkClientError(Error)
  case noResponse
  case noData
  case badStatusCode(Int)
  case decodingError(Error)

}

struct JokesAPIClient {
  
  // introducing topics
  // URL Session// escaping closures
  //Result type new in swodft%
  
  static func fetchJokes(completion: @escaping (Result<[Joke],NetworkingError>) -> ()) {
    
    let endpointURLString = "https://official-joke-api.appspot.com/jokes/programming/ten"
    
    guard let url = URL(string: endpointURLString) else {
      completion(.failure(.badURL("\(endpointURLString)")))
      return
    }
    
    // make use of URLSession to get back JSON (GET request) from the Jokes web API
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
    // check for errros
      if let error = error {   // if error is not nil
        completion(.failure(.newtworkClientError(error)))
      }
      // downcast to HTTPURLResponse to get access to the statusCode
      guard let urlResponse = response as? HTTPURLResponse else {
        completion(.failure(.noResponse))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      // find out whats the status code
      switch urlResponse.statusCode {
      case 200...299: break
      default:
        completion(.failure(.badStatusCode(urlResponse.statusCode)))
      }
      // used to create jokes model
      do {
        let jokes = try JSONDecoder().decode([Joke].self, from: data)
        completion(.success(jokes))
      } catch {
        completion(.failure(.decodingError(error)))
        
      }
    
  }
    dataTask.resume()
    
}

}
