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
