import Foundation

enum APIError: LocalizedError {
    case urlInvalida
    case servidor(Int)

    var errorDescription: String? {
        switch self {
        case .urlInvalida: return "La URL del servicio web no es válida."
        case .servidor(let codigo): return "El servidor respondió con el código \(codigo)."
        }
    }
}

struct APIClient {
    /// GET genérico. `query` son los parámetros URL (por ejemplo ["categoria_id": "2"]).
    static func get<T: Decodable>(_ endpoint: String, query: [String: String] = [:]) async throws -> T {
        guard var componentes = URLComponents(string: "\(Config.baseURL)/\(endpoint)") else {
            throw APIError.urlInvalida
        }
        if !query.isEmpty {
            componentes.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = componentes.url else { throw APIError.urlInvalida }

        let (datos, respuesta) = try await URLSession.shared.data(from: url)
        if let http = respuesta as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
            throw APIError.servidor(http.statusCode)
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase   // categoria_id -> categoriaId
        return try decoder.decode(T.self, from: datos)
    }
}
