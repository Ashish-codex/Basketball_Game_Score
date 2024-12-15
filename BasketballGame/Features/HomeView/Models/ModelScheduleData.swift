//
//  ModelHomeList.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import Foundation

struct ModelScheduleData:Codable{
    let data: ScheduleData
}

// MARK: - DataClass
struct ScheduleData: Codable {
    let schedules: [Schedule]
}

// MARK: - Schedule
struct Schedule: Codable {
    let uid: String
    let year: Int
    let leagueID, seasonID: String
    let h, v: H
    let gid, gcode: String
    let buyTicket: String?
    let bd: Bd
    let seri, isGameNecessary, gametime: String
    let cl: Cl?
    let arenaName, arenaCity, arenaState: String
    let st: Int
    let stt: String
    let ppdst: Ppdst
    let buyTicketURL: String?
    let logoURL: JSONNull?
    let hide: Bool
    let gameState: GameState
    let gameSubtype: String?
    let customFields: JSONNull?
    let templateFields: TemplateFields?
    let csCustomFields: CSCustomFields?

    enum CodingKeys: String, CodingKey {
        case uid, year
        case leagueID = "league_id"
        case seasonID = "season_id"
        case h, v, gid, gcode
        case buyTicket = "buy_ticket"
        case bd, seri
        case isGameNecessary = "is_game_necessary"
        case gametime, cl
        case arenaName = "arena_name"
        case arenaCity = "arena_city"
        case arenaState = "arena_state"
        case st, stt, ppdst
        case buyTicketURL = "buy_ticket_url"
        case logoURL = "logo_url"
        case hide
        case gameState = "game_state"
        case gameSubtype = "game_subtype"
        case customFields = "custom_fields"
        case templateFields = "template_fields"
        case csCustomFields = "cs_custom_fields"
    }
}

// MARK: - Bd
struct Bd: Codable {
    let b: [B]
}

// MARK: - B
struct B: Codable {
    let seq: Int
    let broadcasterID: Int?
    let disp: String
    let scope: Scope
    let type: TypeEnum
    let lan: LAN
    let url: String?
    let dfeDisplayText, dfeBroadcasterLogo, dfeClickThroughURL, customField1: JSONNull?
    let customField2: JSONNull?

    enum CodingKeys: String, CodingKey {
        case seq
        case broadcasterID = "broadcasterId"
        case disp, scope, type, lan, url
        case dfeDisplayText = "dfe_display_text"
        case dfeBroadcasterLogo = "dfe_broadcaster_logo"
        case dfeClickThroughURL = "dfe_click_through_url"
        case customField1 = "custom_field_1"
        case customField2 = "custom_field_2"
    }
}

enum LAN: String, Codable {
    case empty = ""
    case english = "English"
}

enum Scope: String, Codable {
    case away = "away"
    case can = "can"
    case home = "home"
    case natl = "natl"
}

enum TypeEnum: String, Codable {
    case nss = "nss"
    case ott = "ott"
    case radio = "radio"
    case tv = "tv"
}

enum Cl: String, Codable {
    case empty = ""
    case the00000 = "00:00.0"
}

// MARK: - CSCustomFields
struct CSCustomFields: Codable {
    let familyNight: String
    let sponsor: Sponsor
    let hideTuneIn: Bool
    let tuneIn, utilityMenu: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case familyNight = "family_night"
        case sponsor
        case hideTuneIn = "hide_tune_in"
        case tuneIn = "tune_in"
        case utilityMenu = "utility_menu"
    }
}

// MARK: - Sponsor
struct Sponsor: Codable {
    let image: JSONNull?
    let clickthroughLink: String

    enum CodingKeys: String, CodingKey {
        case image
        case clickthroughLink = "clickthrough_link"
    }
}

enum GameState: String, Codable {
    case active = "active"
}

// MARK: - H
struct H: Codable {
    let tid, re, ta, tn: String
    let tc, s: String
    let istGroup: IstGroup?

    enum CodingKeys: String, CodingKey {
        case tid, re, ta, tn, tc, s
        case istGroup = "ist_group"
    }
}

enum IstGroup: String, Codable {
    case eastGroupB = "East Group B"
    case eastGroupC = "East Group C"
}

enum Ppdst: String, Codable {
    case i = "I"
}

// MARK: - TemplateFields
struct TemplateFields: Codable {
    let accessPassSetup: AccessPassSetup?
    let heatJerseyLink: String?

    enum CodingKeys: String, CodingKey {
        case accessPassSetup = "access_pass_setup"
        case heatJerseyLink = "heat_jersey_link"
    }
}

// MARK: - AccessPassSetup
struct AccessPassSetup: Codable {
    let stmCost, nonStmCost, totalPassesAllowed, availablePasses: Int?
    let noThreshold: Bool
    let fortressPassesSold: JSONNull?

    enum CodingKeys: String, CodingKey {
        case stmCost = "stm_cost"
        case nonStmCost = "non_stm_cost"
        case totalPassesAllowed = "total_passes_allowed"
        case availablePasses = "available_passes"
        case noThreshold = "no_threshold"
        case fortressPassesSold = "fortress_passes_sold"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}
