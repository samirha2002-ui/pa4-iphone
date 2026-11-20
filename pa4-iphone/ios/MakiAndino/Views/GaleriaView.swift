import SwiftUI

// Punto 3: galería de imágenes remotas con datos de un servicio web (equipo.php)
struct GaleriaView: View {
    private let columnas = [GridItem(.adaptive(minimum: 150), spacing: 16)]

    var body: some View {
        RemoteView("equipo.php") { (equipo: [Miembro]) in
            ScrollView {
                LazyVGrid(columns: columnas, spacing: 16) {
                    ForEach(equipo) { miembro in
                        MiembroCard(miembro: miembro)
                    }
                }
                .padding(20)
            }
        }
        .titulo("Nuestro equipo")
    }
}

private struct MiembroCard: View {
    let miembro: Miembro

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ImagenRemota(url: miembro.foto)
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            Text(miembro.nombre)
                .font(Theme.fuente(15, .semibold))
                .foregroundStyle(Theme.oscuro)
                .lineLimit(1)
            Text(miembro.cargo)
                .font(Theme.fuente(12))
                .foregroundStyle(Theme.secundario)
                .lineLimit(1)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .tarjeta()
    }
}
