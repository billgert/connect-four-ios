import Foundation

class NetworkRouter<Route: EndPoint> {
  private let session = URLSession.shared

  public func request(_ route: Route, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    let request = self.buildRequest(from: route)
    let task = self.session.dataTask(with: request) { (data, response, error) in
      completion(data, response, error)
    }
    task.resume()
  }
  
  private func buildRequest(from route: Route) -> URLRequest {
    var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                             timeoutInterval: 10.0)
    
    request.httpMethod = route.httpMethod.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    return request
  }
}
