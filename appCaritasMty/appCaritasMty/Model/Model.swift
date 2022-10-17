//
//  Model.swift
//  appCaritasMty
//
//  Created by CLP on 20/09/22.
//

import Foundation

struct Voluntario:Codable{
    let Apellido: String
    let Contrasenia: String
    let Correo: String
    let Nombre: String
    let idVol: Int
}

struct Administrador:Codable{
    let idAdmin: Int
    let Contrasenia: String
    let Correo: String
    let nombreAdmin: String
}

struct Proyecto:Codable{
    let Proyecto: String
    let idProyecto: Int
}

struct HorasR:Codable{
    let HorasVol: String
}

struct Inscripcion:Codable{
    let idVol:Int
    let idProyecto:Int
}

struct horasValidadasVoluntario:Codable{
    let Nombre: String
    let Correo: String
    let HorasVol: String
    let idVol: Int
}

struct horasProyecto:Codable{
    let Apellido: String
    let Horas: String
    let Nombre: String
    let Proyecto: String
}

struct NyP:Codable{
    let idVoluntariado: Int
    let idVol: Int
    let Nombre: String
    let Apellido: String
    let Dia: String
    let Mes: String
    let HoraEntrada: String
    let HoraSalida: String
    let Proyecto: String
}

//SE LE AGREGÓ

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
