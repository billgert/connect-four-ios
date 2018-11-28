import Foundation

class NetworkService<Route: EndPoint> {
  private let router = NetworkRouter<Route>()
  
  public func request<Model: Decodable>(endpoint: Route,
                                        modelType: Model.Type,
                                        completion: @escaping (Model?, Error?) -> Void) {
    
    self.router.request(endpoint) { data, response, error in
      if let error = error {
        completion(nil, error)
        return
      }
      if let data = data {
        do {
          let model = try JSONDecoder().decode(modelType, from: data)
          completion(model, nil)
        } catch {
          completion(nil, error)
        }
      }
    }
  }
}
