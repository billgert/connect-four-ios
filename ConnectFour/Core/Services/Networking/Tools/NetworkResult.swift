import Foundation

extension NetworkService {
  enum Result<Model> {
    case success(Model)
    case failure(Error)
  }
}
