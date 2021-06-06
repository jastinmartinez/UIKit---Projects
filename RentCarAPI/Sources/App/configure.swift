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
    
    app.migrations.add(User.Migration())
    app.migrations.add(UserToken.Migration())
    app.migrations.add(CombustibleType.Migration())
    app.migrations.add(VehicleType.Migration())
    app.migrations.add(VehicleMark.Migration())
    app.migrations.add(VehicleModel.Migration())
    app.migrations.add(Employee.Migration())
    app.migrations.add(Customer.Migration())
    
    try routes(app)
}
