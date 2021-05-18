import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: "localhost", username: "mac", password: "",database: "RentCar"
    ), as: .psql)

    app.migrations.add(User.Table())
    app.migrations.add(UserToken.Table())

    // register routes
    try routes(app)
}
