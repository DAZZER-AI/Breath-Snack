import Foundation

public enum PhaseType: String, Codable, CaseIterable, Sendable {
    case inhale
    case hold
    case exhale
    case rest
}

public enum SnackCategory: String, Codable, CaseIterable, Sendable {
    case calm
    case energy
    case sleep
    case balance
    case hrv
}

public struct HapticProfile: Codable, Equatable, Sendable {
    public let startIntensity: Double
    public let endIntensity: Double

    public init(startIntensity: Double, endIntensity: Double) {
        self.startIntensity = startIntensity
        self.endIntensity = endIntensity
    }
}

public struct OrbColors: Codable, Equatable, Sendable {
    public let primaryHex: String
    public let secondaryHex: String

    public init(primaryHex: String, secondaryHex: String) {
        self.primaryHex = primaryHex
        self.secondaryHex = secondaryHex
    }
}

public struct BreathPhase: Codable, Equatable, Sendable {
    public let name: String
    public let duration: Int
    public let type: PhaseType
    public let hapticProfile: HapticProfile

    public init(name: String, duration: Int, type: PhaseType, hapticProfile: HapticProfile) {
        self.name = name
        self.duration = duration
        self.type = type
        self.hapticProfile = hapticProfile
    }
}

public struct BreathPattern: Identifiable, Codable, Equatable, Sendable {
    public let id: String
    public let name: String
    public let imageName: String
    public let animationName: String
    public let category: SnackCategory
    public let phases: [BreathPhase]
    public let defaultRounds: Int
    public let orbColorScheme: OrbColors
    public let researchCitation: String

    public init(
        id: String,
        name: String,
        imageName: String,
        animationName: String,
        category: SnackCategory,
        phases: [BreathPhase],
        defaultRounds: Int,
        orbColorScheme: OrbColors,
        researchCitation: String
    ) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.animationName = animationName
        self.category = category
        self.phases = phases
        self.defaultRounds = defaultRounds
        self.orbColorScheme = orbColorScheme
        self.researchCitation = researchCitation
    }

    public var totalDuration: Int {
        phases.map(\.duration).reduce(0, +) * defaultRounds
    }
}

public enum BreathCatalog {
    public static let defaultHaptic = HapticProfile(startIntensity: 0.4, endIntensity: 0.7)

    public static let patterns: [BreathPattern] = [
        BreathPattern(id: "sigh", name: "Physiological Sigh", imageName: "snack_sigh", animationName: "orb_drift", category: .calm, phases: [
            BreathPhase(name: "Inhale", duration: 2, type: .inhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "Top-up", duration: 1, type: .inhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "Exhale", duration: 8, type: .exhale, hapticProfile: defaultHaptic)
        ], defaultRounds: 3, orbColorScheme: OrbColors(primaryHex: "#88B8FF", secondaryHex: "#C7DEFF"), researchCitation: "Huberman Lab, 2023"),
        BreathPattern(id: "box", name: "Box Breathing", imageName: "snack_box", animationName: "orb_square", category: .balance, phases: [
            BreathPhase(name: "Inhale", duration: 4, type: .inhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "Hold", duration: 4, type: .hold, hapticProfile: defaultHaptic),
            BreathPhase(name: "Exhale", duration: 4, type: .exhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "Hold", duration: 4, type: .hold, hapticProfile: defaultHaptic)
        ], defaultRounds: 4, orbColorScheme: OrbColors(primaryHex: "#7DE1D3", secondaryHex: "#A8FFF3"), researchCitation: "Grossman et al., 2021"),
        BreathPattern(id: "478", name: "4-7-8", imageName: "snack_sleep", animationName: "orb_night", category: .sleep, phases: [
            BreathPhase(name: "Inhale", duration: 4, type: .inhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "Hold", duration: 7, type: .hold, hapticProfile: defaultHaptic),
            BreathPhase(name: "Exhale", duration: 8, type: .exhale, hapticProfile: defaultHaptic)
        ], defaultRounds: 4, orbColorScheme: OrbColors(primaryHex: "#5BA7CC", secondaryHex: "#A0D8F1"), researchCitation: "Weil, 2015"),
        BreathPattern(id: "diaphragm", name: "Diaphragmatic", imageName: "snack_diaphragm", animationName: "orb_wave", category: .calm, phases: [
            BreathPhase(name: "Inhale", duration: 4, type: .inhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "Exhale", duration: 6, type: .exhale, hapticProfile: defaultHaptic)
        ], defaultRounds: 6, orbColorScheme: OrbColors(primaryHex: "#7DB4FF", secondaryHex: "#B6D3FF"), researchCitation: "Jerath et al., 2019"),
        BreathPattern(id: "cyclic", name: "Cyclic Hyperventilation", imageName: "snack_cyclic", animationName: "orb_pulse_fast", category: .energy, phases: [
            BreathPhase(name: "Power In", duration: 2, type: .inhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "Quick Out", duration: 2, type: .exhale, hapticProfile: defaultHaptic)
        ], defaultRounds: 10, orbColorScheme: OrbColors(primaryHex: "#FF9854", secondaryHex: "#FFD0A8"), researchCitation: "Kox et al., 2014"),
        BreathPattern(id: "nadi", name: "Nadi Shodhana", imageName: "snack_nadi", animationName: "orb_dual", category: .balance, phases: [
            BreathPhase(name: "L In", duration: 4, type: .inhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "R Out", duration: 4, type: .exhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "R In", duration: 4, type: .inhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "L Out", duration: 4, type: .exhale, hapticProfile: defaultHaptic)
        ], defaultRounds: 5, orbColorScheme: OrbColors(primaryHex: "#8CC8A8", secondaryHex: "#C3F0D8"), researchCitation: "Saoji et al., 2019"),
        BreathPattern(id: "resonance", name: "Resonance", imageName: "snack_resonance", animationName: "orb_resonance", category: .hrv, phases: [
            BreathPhase(name: "Inhale", duration: 6, type: .inhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "Exhale", duration: 6, type: .exhale, hapticProfile: defaultHaptic)
        ], defaultRounds: 8, orbColorScheme: OrbColors(primaryHex: "#5DD5C2", secondaryHex: "#9FF5E8"), researchCitation: "Lehrer et al., 2020"),
        BreathPattern(id: "kapalabhati", name: "Kapalabhati", imageName: "snack_kapalabhati", animationName: "orb_sharp", category: .energy, phases: [
            BreathPhase(name: "Sharp Out", duration: 1, type: .exhale, hapticProfile: defaultHaptic),
            BreathPhase(name: "Passive In", duration: 1, type: .inhale, hapticProfile: defaultHaptic)
        ], defaultRounds: 20, orbColorScheme: OrbColors(primaryHex: "#FF8A5B", secondaryHex: "#FFC0A1"), researchCitation: "Bhavanani et al., 2018")
    ]
}
