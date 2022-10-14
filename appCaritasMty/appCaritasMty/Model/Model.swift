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
