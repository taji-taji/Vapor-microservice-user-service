import Fluent
import FluentMySQLDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(CORSMiddleware())

    guard let jwksString = Environment.process.JWKS else {
        fatalError("No value was found at the given public key environment 'JWKS'")
    }

    guard let mysqlUrlString = Environment.process.MYSQL_CRED else {
        fatalError("No value was found at the given public key environment 'MYSQL_CRED'")
    }
    guard let url = URL(string: mysqlUrlString) else {
        fatalError("Cannot parse: \(mysqlUrlString) correctly")
    }
    app.databases.use(try DatabaseConfigurationFactory.mysql(url: url), as: .mysql)

    try app.jwt.signers.use(jwksJSON: jwksString)

    app.migrations.add(CreateTodo())

    // register routes
    try routes(app)
}
