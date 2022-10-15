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
    let idVol: Int
    let idProyecto: Int
}

struct RegistroVoluntariado:Codable{
    let horaFechaEntrada: String
    let horaFechaSalida: String
    let horas: Int
    let idProyecto: Int
    let idVol: Int
    let idVoluntariado: Int
    let validacion: Int
}

struct NyP:Codable{
    let Nombre: String
    let Apellido: String
    let Dia: String
    let Mes: String
    let HoraEntrada: String
    let HoraSalida: String
    let Proyecto: String
}

