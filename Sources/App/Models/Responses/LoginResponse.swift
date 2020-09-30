import Vapor

struct LoginResponse: Content {
    let userId: Int
    let email: String
    let firstname: String?
    let lastname: String?
    let accessToken: String
    let refreshToken: String
}
