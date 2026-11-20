import SwiftUI

// Punto 4 · Pantalla 1 del maestro-detalle: categorías (categorias.php)
struct CategoriasView: View {
    var body: some View {
        RemoteView("categorias.php") { (categorias: [Categoria]) in
            ScrollView {
                LazyVStack(spacing: 18) {
                    ForEach(categorias) { categoria in
                        NavigationLink(value: Route.platos(categoriaId: categoria.id, nombre: categoria.nombre)) {
                            CategoriaCard(categoria: categoria)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(20)
            }
        }
        .titulo("Menú")
    }
}

private struct CategoriaCard: View {
    let categoria: Categoria

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ImagenRemota(url: categoria.imagen)
            LinearGradient(colors: [.clear, Theme.oscuro.opacity(0.85)],
                           startPoint: .center, endPoint: .bottom)
            Text(categoria.descripcion)
                .font(Theme.fuente(13))
                .foregroundStyle(.white.opacity(0.9))
                .padding(18)
        }
        .overlay(alignment: .topLeading) {
            HStack(spacing: 8) {
                Image(systemName: categoria.icono)
                    .foregroundStyle(Theme.primario)
                Text(categoria.nombre)
                    .font(Theme.fuente(18, .semibold))
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 14).padding(.vertical, 8)
            .background(Theme.oscuro.opacity(0.6), in: Capsule())
            .background(.ultraThinMaterial, in: Capsule())
            .padding(14)
        }
        .frame(height: 170)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: Theme.oscuro.opacity(0.18), radius: 16, x: 0, y: 8)
    }
}
