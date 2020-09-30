import Fluent
import Vapor

func routes(_ app: Application) throws {
    // You should need to replace "name" variable inside the first route.
    app.get([.anything, "name", "health"]) { req in
        return "Healthy!"
    }
}
