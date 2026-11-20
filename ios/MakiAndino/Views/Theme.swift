import SwiftUI

// ─────────────────────────────────────────────────────────────
//  TEMA VISUAL  (única fuente de colores y tipografía de la app)
//  Referencia: IKIGAI — Restaurant App (Behance)
//  https://www.behance.net/gallery/256882763/IKIGAI-Restaurant-App
//  Paleta: FFF0F1 · FDB0B4 · FC8B90 · FA666C · F84147 · 1C1C1C · 404345 · 696D70 · CBCCCD · F1F3F5
//  Tipografía: Golos Text (H1 SemiBold 28, H2 SemiBold 22, H3 Medium 18, Text Regular 16, Subtitle Regular 13)
// ─────────────────────────────────────────────────────────────
enum Theme {
    static let fondo      = Color(hex: 0xF1F3F5)   // gris muy claro (fondo)
    static let tarjeta    = Color(hex: 0xFFFFFF)   // tarjetas
    static let primario   = Color(hex: 0xF84147)   // rojo IKIGAI
    static let acento     = Color(hex: 0xFA666C)   // rojo suave
    static let rosa       = Color(hex: 0xFFF0F1)   // rosa muy claro
    static let oscuro     = Color(hex: 0x1C1C1C)   // negro (texto y botones)
    static let secundario = Color(hex: 0x696D70)   // gris (texto secundario)
    static let borde      = Color(hex: 0xCBCCCD)   // gris claro

    enum Peso: String {
        case regular  = "GolosText-Regular"
        case medium   = "GolosText-Medium"
        case semibold = "GolosText-SemiBold"
        case bold     = "GolosText-Bold"
    }

    static func fuente(_ tamano: CGFloat, _ peso: Peso = .regular) -> Font {
        .custom(peso.rawValue, size: tamano)
    }
}

extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}

// Tarjeta con bordes redondeados, borde sutil y sombra.
struct TarjetaEstilo: ViewModifier {
    var radio: CGFloat = 24
    func body(content: Content) -> some View {
        content
            .background(Theme.tarjeta, in: RoundedRectangle(cornerRadius: radio, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: radio, style: .continuous)
                    .stroke(Theme.oscuro.opacity(0.06), lineWidth: 1)
            )
            .shadow(color: Theme.oscuro.opacity(0.12), radius: 16, x: 0, y: 8)
    }
}

extension View {
    func tarjeta(radio: CGFloat = 24) -> some View {
        modifier(TarjetaEstilo(radio: radio))
    }

    /// Título de la barra de navegación con la tipografía del tema.
    func titulo(_ texto: String) -> some View {
        self
            .navigationTitle(texto)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(texto)
                        .font(Theme.fuente(17, .semibold))
                        .foregroundStyle(Theme.oscuro)
                }
            }
    }
}
