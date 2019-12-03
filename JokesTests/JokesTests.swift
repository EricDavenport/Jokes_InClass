//
//  JokesTests.swift
//  JokesTests
//
//  Created by Eric Davenport on 12/3/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import XCTest
@testable import Jokes

class JokesTests: XCTestCase {
  
  func testJokesModel() {
    // arrange
    let jsonData = """
    [
    {
    "id": 380,
    "type": "programming",
    "setup": "There are 10 kinds of people in this world.",
    "punchline": "Those who understand binary, those who don't, and those who weren't expecting a base 3 joke."
    },
    {
    "id": 26,
    "type": "programming",
    "setup": "If you put a million monkeys at a million keyboards, one of them will eventually write a Java program",
    "punchline": "the rest of them will write Perl"
    }]
    """.data(using: .utf8)!
    
    let expectedJokesCount = 2
    
    // act
    do {
      let jokes = try JSONDecoder().decode([Joke].self, from: jsonData)
      XCTAssertEqual(jokes.count, expectedJokesCount, "There should be \(expectedJokesCount) created.")
    } catch {
      XCTFail("decoding error \(error)")
    }
  }
  
}
