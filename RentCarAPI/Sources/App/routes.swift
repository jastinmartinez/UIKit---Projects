import Fluent
import Vapor

func routes(_ app: Application) throws {

    try app.register(collection: CombustibleTypeController())
    try app.register(collection: VehicleMarkController())
    try app.register(collection: VehicleModelController())
    try app.register(collection: VehicleTypeController())
    try app.register(collection: UserController())
}
