//
//  Joke.swift
//  Jokes
//
//  Created by Eric Davenport on 12/3/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import Foundation

struct Joke: Decodable {
  let id: Int
  let type: String
  let setup: String
  let punchline: String
  
  // id type setup punchline
}
