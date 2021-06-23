import Fluent
import Vapor

func routes(_ app: Application) throws {

    try app.register(collection: CombustibleTypeController())
    try app.register(collection: VehicleMarkController())
    try app.register(collection: VehicleModelController())
    try app.register(collection: VehicleTypeController())
    try app.register(collection: CustomerController())
    try app.register(collection: UserController())
    try app.register(collection: EmployeeController())
    try app.register(collection: VehicleController())
    try app.register(collection: InspectionController())
    try app.register(collection: RentController())
    try app.register(collection: DevolutionController())
}
