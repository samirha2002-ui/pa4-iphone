import SwiftUI

// Punto 4 · Pantalla 3: detalle del plato.  Parámetro URL  plato.php?id=<id>
struct DetalleView: View {
    let platoId: Int

    var body: some View {
        RemoteView("plato.php", query: ["id": String(platoId)]) { (plato: Plato) in
            DetalleContenido(plato: plato)
        }
        .titulo("Detalle")
    }
}

private struct DetalleContenido: View {
    let plato: Plato
    @State private var cantidad = 1
    @State private var agregado = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ImagenRemota(url: plato.imagen)
                    .frame(height: 280)
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    .shadow(color: Theme.oscuro.opacity(0.2), radius: 18, x: 0, y: 10)

                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top) {
                        Text(plato.nombre)
                            .font(Theme.fuente(22, .semibold))
                            .foregroundStyle(Theme.oscuro)
                        Spacer()
                        Text(String(format: "S/ %.2f", plato.precio))
                            .font(Theme.fuente(14, .bold))
                            .foregroundStyle(Theme.primario)
                            .padding(.horizontal, 14).padding(.vertical, 8)
                            .background(Theme.rosa, in: Capsule())
                    }
                    Text(plato.descripcion)
                        .font(Theme.fuente(14))
                        .foregroundStyle(Theme.secundario)

                    HStack(spacing: 14) {
                        Dato(icono: "flame", valor: "\(plato.calorias) kcal", titulo: "Energía")
                        Dato(icono: "clock", valor: "\(plato.tiempo) min", titulo: "Preparación")
                    }

                    Stepper("Cantidad: \(cantidad)", value: $cantidad, in: 1...10)
                        .font(Theme.fuente(15, .semibold))
                        .foregroundStyle(Theme.oscuro)
                        .padding(16)
                        .tarjeta(radio: 20)

                    Button {
                        agregado = true
                    } label: {
                        Text(agregado ? "Agregado al pedido ✓"
                                      : String(format: "Agregar · S/ %.2f", plato.precio * Double(cantidad)))
                            .font(Theme.fuente(16, .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(Theme.oscuro, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(20)
        }
    }
}

private struct Dato: View {
    let icono: String
    let valor: String
    let titulo: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icono)
                .foregroundStyle(Theme.primario)
                .frame(width: 40, height: 40)
                .background(Theme.primario.opacity(0.12), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            VStack(alignment: .leading, spacing: 2) {
                Text(valor).font(Theme.fuente(14, .semibold)).foregroundStyle(Theme.oscuro)
                Text(titulo).font(Theme.fuente(11)).foregroundStyle(Theme.secundario)
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .tarjeta(radio: 20)
    }
}
