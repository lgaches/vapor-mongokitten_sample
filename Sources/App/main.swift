import Vapor
import MongoKitten


let server: Server

do {
    server = try Server(mongoURL: "mongodb://localhost:27017/")
    let databases = try server.getDatabases()
    let _ = databases.map{ print ($0.name) }
} catch let error {
    fatalError("MongoDB is not available on the given host and port")
}

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.resource("posts", PostController())

drop.run()
