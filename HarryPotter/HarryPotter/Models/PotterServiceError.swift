//
//  HouseError.swift
//  HarryPotter
//
//  Created by Jordan Bryant on 9/23/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation

enum PotterServiceError: LocalizedError {
  case invalidURL
  case thrownError(Error)
  case noData
  case unableToDecode

  var errorDescription: String? {
      switch self {
      case .invalidURL:
          return "Internal error. Please update or contact support."
      case .thrownError(let error):
          return error.localizedDescription
      case .noData:
          return "The server responded with no data."
      case .unableToDecode:
          return "The server responded with bad data."
      }
  }
}
