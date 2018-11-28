import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
}

protocol EndPoint {
  var baseURL: URL { get }
  var path: String { get }
  var httpMethod: HTTPMethod { get }
}

enum BlinkistEndPoint {
  case getConfiguration
}

extension BlinkistEndPoint: EndPoint {
  var baseURL: URL {
    guard let url = URL(string: "https://private-75c7a5-blinkist.apiary-mock.com/connectFour") else {
      fatalError("baseURL could not be configured.")
    }
    return url
  }
  
  var path: String {
    switch self {
    case .getConfiguration:
      return "/configuration"
    }
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .getConfiguration:
      return .get
    }
  }
}

