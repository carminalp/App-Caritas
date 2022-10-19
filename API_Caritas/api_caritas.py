from flask import Flask, jsonify, make_response, request, send_file
import json
import sys
import mysql.connector
import os

import logging
#logging basic definition
LOG_FILE = './api/api_caritas.log'
logging.basicConfig(filename=LOG_FILE, level=logging.INFO,
    format='%(asctime)s.%(msecs)03d %(levelname)s: %(message)s',
    datefmt='%d-%d-%y %H:%M:%S')


# Connect to MySQL dB from start
mysql_params = {}
mysql_params['DB_HOST'] = '100.80.80.6'
mysql_params['DB_NAME'] = 'caritas'
mysql_params['DB_USER'] = os.environ['MYSQL_USER']
mysql_params['DB_PASSWORD'] = os.environ['MYSQL_PSWD']
 
try:
   cnx = mysql.connector.connect(
       user=mysql_params['DB_USER'],
       password=mysql_params['DB_PASSWORD'],
       host=mysql_params['DB_HOST'],
       database=mysql_params['DB_NAME'],
       auth_plugin='mysql_native_password'
       )
except Exception as e:
   print("Cannot connect to MySQL server!: {}".format(e))
   sys.exit()
 
def module_path():
   import sys
   import os
   if (hasattr(sys, "frozen")):
       return os.path.dirname(sys.executable)
   if os.path.dirname(__file__) == "":
       return "."
   return os.path.dirname(__file__)
def mysql_connect():
   global mysql_params
   cnx = mysql.connector.connect(
       user=mysql_params['DB_USER'],
       password=mysql_params['DB_PASSWORD'],
       host=mysql_params['DB_HOST'],
       database=mysql_params['DB_NAME'],
       auth_plugin='mysql_native_password'
       )
   return cnx

# Get información de administrador
def read_nombre_data():
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("SELECT idVoluntariado, rv.idVol, Nombre, Apellido, date_format(horaFechaEntrada, \"%d\") AS Dia,MONTHNAME(horaFechaEntrada) AS Mes, date_format(horaFechaEntrada,\"%H:%i\") AS HoraEntrada, date_format(horaFechaSalida,\"%H:%i\") AS HoraSalida, Proyecto FROM RegistroVoluntariado AS rv JOIN Voluntario AS v ON rv.idVol = v.idVol JOIN Proyecto AS p ON rv.idProyecto = p.idProyecto WHERE validacion = 0;")
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_user_data:%s" % e)

# Get información de administrador
def read_admin_data(email, password):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("SELECT idAdmin, Correo, Contrasenia, nombreAdmin FROM Administrador WHERE Correo = %s AND Contrasenia = %s",( email, password,))
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_user_data:%s" % e)
 
 # Get información de voluntario
def read_vol_data(table_name, email, password):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("SELECT Apellido, Contrasenia, Correo, Nombre, idVol FROM Voluntario WHERE Correo = %s AND Contrasenia = %s",(email, password,))
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_user_data:%s" % e)

# Get información de proyectos incritos
def read_pro_data(table_name, proyecto):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("SELECT Proyecto.idProyecto, Proyecto FROM Proyecto JOIN Inscripcion ON Proyecto.idProyecto = Inscripcion.idProyecto and idVol = %s;",(proyecto,))
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_user_data:%s" % e)
 
 # Post de voluntarios
def insert_vol_into(d):
  global cnx
  try:
      try:
          cnx.ping(reconnect=False, attempts=1, delay=3)
      except:
          cnx = mysql_connect()
      cursor = cnx.cursor()
      keys = ""
      values = ""
      data = []
      for k in d:
          keys += k + ','
          values += "%s,"
          if isinstance(d[k],bool):
              d[k] = int(d[k] == True)
          data.append(d[k])
      keys = keys[:-1]
      values = values[:-1]
      insert = 'INSERT INTO Voluntario (%s) VALUES (%s)'  % (keys, values)
      a = cursor.execute(insert,data)
      #insert = "INSERT INTO Voluntario (Nombre, Apellido, Correo, Contrasenia) VALUES (%s,%s,%s,%s)"
      #a = cursor.execute(insert,data)
      id_new = cursor.lastrowid
      cnx.commit()
      cursor.close()
      return id_new
  except Exception as e:
      raise TypeError("insert_vol_into:%s" % e)

# Post registrar horas 
def insert_horas_into(d):
  global cnx
  try:
      try:
          cnx.ping(reconnect=False, attempts=1, delay=3)
      except:
          cnx = mysql_connect()
      cursor = cnx.cursor()
      keys = ""
      values = ""
      data = []
      for k in d:
          keys += k + ','
          values += "%s,"
          if isinstance(d[k],bool):
              d[k] = int(d[k] == True)
          data.append(d[k])
      keys = keys[:-1]
      values = values[:-1]
      insert = 'INSERT INTO RegistroVoluntariado (%s) VALUES (%s)'  % (keys, values)
      a = cursor.execute(insert,data)
      #insert = "INSERT INTO RegistroVoluntariado (idVol,idProyecto,horaFechaEntrada,horaFechaSalida,validacion,horas) VALUES (%s,%s,%s,%s,%s,%s)"
      #a = cursor.execute(insert,data)
      id_new = cursor.lastrowid
      cnx.commit()
      cursor.close()
      return id_new
  except Exception as e:
      raise TypeError("insert_vol_into:%s" % e)

# Post inscripción voluntariado
def insert_vol_project(d):
  global cnx
  try:
      try:
          cnx.ping(reconnect=False, attempts=1, delay=3)
      except:
          cnx = mysql_connect()
      cursor = cnx.cursor()
      keys = ""
      values = ""
      data = []
      for k in d:
          keys += k + ','
          values += "%s,"
          if isinstance(d[k],bool):
              d[k] = int(d[k] == True)
          data.append(d[k])
      keys = keys[:-1]
      values = values[:-1]
      insert = 'INSERT INTO Inscripcion (%s) VALUES (%s)' % (keys, values)
      a = cursor.execute(insert,data)
      #insert = "INSERT INTO Inscripcion (idVol, idProyecto, fechaInscripcion) VALUES (%s,%s,%s)"
      #a = cursor.execute(insert,data)
      id_new = cursor.lastrowid
      cnx.commit()
      cursor.close()
      return id_new
  except Exception as e:
      raise TypeError("insert_vol_into:%s" % e)

# Get proyectos
def read_projects_data(table_name):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)

       cursor.execute('SELECT * FROM Proyecto')
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_user_data:%s" % e)


# Get voluntarios
def read_voluntarios_data():
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)

       cursor.execute('SELECT * FROM Voluntario')
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_user_data:%s" % e)
   
   
   # Get horas registradas sin validar
def read_horas_sin_validar():
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)

       cursor.execute('SELECT Nombre, Apellido, date_format(horaFechaEntrada, \"%d %m\") AS Dia, date_format(horaFechaEntrada,\"%H:%i\") AS HoraEntrada, date_format(horaFechaSalida,\"%H:%i\") AS HoraSalida, Proyecto FROM Voluntario AS v JOIN RegistroVoluntariado AS rv ON v.idVol = rv.idVol JOIN Inscripcion AS I ON rv.idProyecto = I.idProyecto JOIN Proyecto AS p ON I.idProyecto = p.idProyecto WHERE validacion = 0')
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_user_data:%s" % e)

# Get Horas de Voluntario
def read_voluntario_horas(table_name, idVol):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("SELECT SUM(horas) AS HorasVol FROM RegistroVoluntariado WHERE idVol = %s AND validacion=1 GROUP BY idVol;", (idVol,))
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_voluntario_horas:%s" % e)

#UPDATE `caritas`.`RegistroVoluntariado` SET `validacion` = '1' WHERE (`idVoluntariado` = '15') and (`idVol` = '27');
#update_horas_validas

# Update de horas validas
def update_horas_validas(table_name, idVoluntariado, idVol):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("UPDATE RegistroVoluntariado SET validacion = 1 WHERE (idVoluntariado = %s) and (idVol = %s);", (idVoluntariado, idVol,))
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_voluntario_horasP:%s" % e)

# Get Horas de Voluntario
def read_voluntario_horasP(table_name, idVol):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("SELECT SUM(horas) AS HorasVol FROM RegistroVoluntariado WHERE idVol = %s AND validacion=0 GROUP BY idVol;", (idVol,))
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_voluntario_horasP:%s" % e)

 # Get información de inscripción
def read_ins_data(table_name, idV, idP):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("SELECT idVol, idProyecto FROM Inscripcion WHERE idVol = %s AND idProyecto = %s",(idV, idP,))
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_user_data:%s" % e)

# Get Horas x Voluntario
def read_horas_x_vol(table_name):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("SELECT rv.idVol, Nombre, Correo, SUM(horas) AS HorasVol FROM RegistroVoluntariado AS rv JOIN Voluntario AS v ON v.idVol = rv.idVol WHERE validacion=1 GROUP BY rv.idVol;")
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_horas_x_vol:%s" % e)

# Borrar horas invalidas
def delete_borrar_h(idVoluntariado, idVol):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("DELETE FROM RegistroVoluntariado WHERE (idVoluntariado = %s) and (idVol = %s);", (idVoluntariado, idVol,))
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_horas_x_vol:%s" % e)
   
# Get Horas x Proyecto
def read_horas_x_proy(table_name,idV):
   global cnx
   try:
       try:
           cnx.ping(reconnect=False, attempts=1, delay=3)
       except:
           cnx = mysql_connect()
       cursor = cnx.cursor(dictionary=True)
       cursor.execute("SELECT Nombre, Apellido, Sum(Horas) AS Horas, Proyecto FROM Voluntario AS v JOIN RegistroVoluntariado AS rv ON v.idVol = rv.idVol JOIN Proyecto AS p ON rv.idProyecto = p.idProyecto WHERE validacion = 1 AND v.idVol= %s GROUP BY Proyecto;",(idV,))
       a = cursor.fetchall()
       cnx.commit()
       cursor.close()
       return a
   except Exception as e:
       raise TypeError("read_horas_x_proy:%s" % e)



app = Flask(__name__)

@app.after_request
def add_header(r):
    import secure
    secure_headers = secure.Secure()
    secure_headers.framework.flask(r)
    r.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    return r 

@app.route("/hello")
def hello():
  return "Scoops Ahoy!\n"

# Login Admin
@app.route("/admin")
def admin():
  correo = request.args.get('Correo', None)
  password = request.args.get('Contrasenia', None)
  d_admin = read_admin_data (correo, password)
  if len(d_admin) == 0:
      logging.info("User Admin '{}' not found (IP: {})".format(correo, request.remote_addr))
  elif len(d_admin) == 1:
      logging.info("User Admin '{}' ok (IP: {})".format(correo, request.remote_addr))
  return make_response(jsonify(d_admin))

# Borrar horas
@app.route("/borrarHoras", methods=['DELETE'])
def borrarH():
  idVoluntariado = request.args.get('idVoluntariado', None)
  idVol = request.args.get('idVol', None)
  borrar_h = delete_borrar_h (idVoluntariado, idVol)
  return make_response(jsonify(borrar_h))

# get nombre y proyecto
@app.route("/getNyP")
def NyP():
  d_nombre = read_nombre_data ()
  return make_response(jsonify(d_nombre))

# Login Voluntario
@app.route("/vol")
def vol():
  correo = request.args.get('Correo', None)
  password = request.args.get('Contrasenia', None)
  d_vol= read_vol_data('Voluntario', correo, password)  
  if len(d_vol) == 0:
      logging.info("User Vol '{}' not found (IP: {})".format(correo, request.remote_addr))
  elif len(d_vol) == 1:
      logging.info("User Vol '{}' ok (IP: {})".format(correo, request.remote_addr))
  return make_response(jsonify(d_vol))

# Vefificación botón inscripción
@app.route("/inscripcionPasada")
def ins():
  idVolun = request.args.get('idVol', None)
  idPro = request.args.get('idProyecto', None)
  d_ins= read_ins_data('Inscripcion', idVolun, idPro)  
  return make_response(jsonify(d_ins))

# Get voluntarios
@app.route("/voluntarios")
def voluntarios():
    d_voluntarios = read_voluntarios_data()
    return make_response(jsonify(d_voluntarios))

# Get proyectos inscritos
@app.route("/proyectoRegistro")
def pro():
  idVolu = request.args.get('idVol', None)
  d_pro= read_pro_data('Proyecto', idVolu)  
  return make_response(jsonify(d_pro))

# Get projectos ? FAVOR DE CLARIFICAR
@app.route("/categorias")
def proyectos():
    d_proyectos = read_projects_data('Proyecto')
    return make_response(jsonify(d_proyectos))

# Get Horas de Voluntario
@app.route("/volHoras")
def volH():
  idVol = request.args.get('idVol', None)
  d_hrs= read_voluntario_horas('RegistroVoluntariado', idVol)  
  return make_response(jsonify(d_hrs))

  # Get Horas de Voluntario Pendientes
@app.route("/volHorasPend")
def volHP():
  idVol = request.args.get('idVol', None)
  d_hrs= read_voluntario_horasP('RegistroVoluntariado', idVol)  
  return make_response(jsonify(d_hrs))

#Get horas sin validar
@app.route("/horas/sinvalidar")
def horasSinValidar():
   d_proyectos = read_horas_sin_validar()
   return make_response(jsonify(d_proyectos))

#Get horas val x voluntario
@app.route("/admin/horasVal")
def horasxVol():
  d_hrs_x_vol= read_horas_x_vol('RegistroVoluntariado')  
  return make_response(jsonify(d_hrs_x_vol))

#Get horas x proyecto
@app.route("/admin/horasproyecto")
def horasxProy():
  idVol = request.args.get('idVol', None)
  d_hrs_x_proy = read_horas_x_proy('Voluntario',idVol)
  return make_response(jsonify(d_hrs_x_proy))

# post registrar voluntario
@app.route("/vol/registro", methods=['POST'])
def crud_create():
  d = request.json
  vol = insert_vol_into(d)
  return make_response(jsonify(vol))

# post registrar voluntario
@app.route("/horas/validas", methods=['PUT'])
def h_validas():
  idVoluntariado = request.args.get('idVoluntariado', None)
  idVol = request.args.get('idVol', None)
  v_hrs= update_horas_validas('RegistroVoluntariado', idVoluntariado, idVol)  
  return make_response(jsonify(v_hrs))

# post registrar horas de voluntariado
@app.route("/registro/horas", methods=['POST'])
def cru_create():
  d = request.json
  horas = insert_horas_into(d)
  return make_response(jsonify(horas))

# post inscripción proyecto
@app.route("/vol/proyecto", methods=['POST'])
def inscription_create():
    d_ins = request.json
    proyecto = insert_vol_project(d_ins)
    return make_response(jsonify(proyecto))



API_CERT = './SSL/equipo02.tc2007b.tec.mx.cer'.format(module_path())
API_KEY = './SSL/equipo02.tc2007b.tec.mx.key'.format(module_path())
CA = './SSL/ca.tc2007b.tec.mx.cer'.format(module_path())
 
if __name__ == '__main__':
   import ssl
   context = ssl.SSLContext(ssl.PROTOCOL_TLSv1_2)
   context.load_verify_locations(CA)
   context.load_cert_chain(API_CERT, API_KEY)
   app.run(host='100.80.80.210', port=10210, ssl_context=context, debug=False)