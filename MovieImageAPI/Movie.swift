import Foundation

struct Movie: Decodable {
    let posters: [Information]
    
    struct Information: Decodable {
        let file_path: String?
        let height: Int?
        let width: Int?
    }
}
