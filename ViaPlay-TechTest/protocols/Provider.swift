import Foundation

protocol Cache {
    func cachedSession(url: URL) -> Session?
}
