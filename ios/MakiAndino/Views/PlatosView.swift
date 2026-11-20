import SwiftUI

// Punto 4 · Pantalla 2: platos de la categoría elegida.
// Se envía el parámetro URL  platos.php?categoria_id=<id>
struct PlatosView: View {
    let categoriaId: Int
    let nombre: String
    private let columnas = [GridItem(.adaptive(minimum: 160), spacing: 16)]

    var body: some View {
        RemoteView("platos.php", query: ["categoria_id": String(categoriaId)]) { (platos: [Plato]) in
            ScrollView {
                LazyVGrid(columns: columnas, spacing: 16) {
                    ForEach(platos) { plato in
                        NavigationLink(value: Route.detalle(platoId: plato.id)) {
                            PlatoCard(plato: plato)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(20)
            }
        }
        .titulo(nombre)
    }
}

private struct PlatoCard: View {
    let plato: Plato

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ImagenRemota(url: plato.imagen)
                .frame(height: 120)
            VStack(alignment: .leading, spacing: 8) {
                Text(plato.nombre)
                    .font(Theme.fuente(14, .semibold))
                    .foregroundStyle(Theme.oscuro)
                    .lineLimit(2, reservesSpace: true)
                    .multilineTextAlignment(.leading)
                Text(String(format: "S/ %.2f", plato.precio))
                    .font(Theme.fuente(13, .bold))
                    .foregroundStyle(Theme.primario)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .tarjeta()
    }
}
