//
//  ModelTeamData.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import Foundation

struct ModelTeamData: Codable {
    let data: TeamData
}

// MARK: - DataClass
struct TeamData: Codable {
    let teams: [Team]
}

// MARK: - Team
struct Team: Codable, Identifiable {
    var id = UUID().uuidString
    let uid: String
    let year: Int
    let leagueID, seasonID, istGroup, tid: String
    let tn, ta, tc, di: String
    let co: Co
    let sta: String
    let logo: String
    let color: String
    let customFields: TeamJSONNull?
    let templateFields: TeamTemplateFields?

    enum CodingKeys: String, CodingKey {
        case uid, year
        case leagueID = "league_id"
        case seasonID = "season_id"
        case istGroup = "ist_group"
        case tid, tn, ta, tc, di, co, sta, logo, color
        case customFields = "custom_fields"
        case templateFields = "template_fields"
    }
}

enum Co: String, Codable {
    case east = "East"
    case west = "West"
}

// MARK: - TeamTemplateFields
struct TeamTemplateFields: Codable {
    let version: Int?
    let locale: TeamLocale?
    let acl: ACL?
    let createdAt: String?
    let createdBy: CreatedBy?
    let dfeClassUid, leagueID: String?
    let logo: String?
    let seasonID, ta: String?
    let tags: [TeamJSONAny]?
    let tc, tid, title, tn: String?
    let updatedAt: String?
    let updatedBy: UpdatedBy?
    let year: Int?
    let publishDetails: PublishDetails?

    enum CodingKeys: String, CodingKey {
        case version = "_version"
        case locale
        case acl = "ACL"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case dfeClassUid = "dfe_class_uid"
        case leagueID = "league_id"
        case logo
        case seasonID = "season_id"
        case ta, tags, tc, tid, title, tn
        case updatedAt = "updated_at"
        case updatedBy = "updated_by"
        case year
        case publishDetails = "publish_details"
    }
}

// MARK: - ACL
struct ACL: Codable {
}

enum CreatedBy: String, Codable {
    case bltd2C33A5D025E0530 = "bltd2c33a5d025e0530"
}

enum TeamLocale: String, Codable {
    case enUs = "en-us"
}

// MARK: - PublishDetails
struct PublishDetails: Codable {
    let environment: Environment
    let locale: TeamLocale
    let time: String
    let user: UpdatedBy
}

enum Environment: String, Codable {
    case bltbccb042732E19B69 = "bltbccb042732e19b69"
}

enum UpdatedBy: String, Codable {
    case blt3B0E6Dba12024A93 = "blt3b0e6dba12024a93"
}

// MARK: - Encode/decode helpers

class TeamJSONNull: Codable, Hashable {

    public static func == (lhs: TeamJSONNull, rhs: TeamJSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(TeamJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TeamJSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class TeamJSONCodingKey: CodingKey {
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

class TeamJSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode TeamJSONAny")
            return DecodingError.typeMismatch(TeamJSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode TeamJSONAny")
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
                    return TeamJSONNull()
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
                            return TeamJSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: TeamJSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<TeamJSONCodingKey>, forKey key: TeamJSONCodingKey) throws -> Any {
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
                            return TeamJSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: TeamJSONCodingKey.self, forKey: key) {
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

    static func decodeDictionary(from container: inout KeyedDecodingContainer<TeamJSONCodingKey>) throws -> [String: Any] {
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
                    } else if value is TeamJSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: TeamJSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<TeamJSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = TeamJSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is TeamJSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: TeamJSONCodingKey.self, forKey: key)
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
            } else if value is TeamJSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try TeamJSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: TeamJSONCodingKey.self) {
                    self.value = try TeamJSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try TeamJSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try TeamJSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: TeamJSONCodingKey.self)
                    try TeamJSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try TeamJSONAny.encode(to: &container, value: self.value)
            }
    }
}
