using System;
using System.Data;
using System.Data.SqlClient;
using Sistema.Entidades;

namespace Sistema.Datos
{
    public class DVenta
    {
        public DataTable Listar()
        {
            SqlDataReader Resultado;
            DataTable Tabla = new DataTable();
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon = Conexion.getInstancia().CrearConexion();
                SqlCommand Comando = new SqlCommand("venta_listar", SqlCon);
                Comando.CommandType = CommandType.StoredProcedure;
                SqlCon.Open();
                Resultado = Comando.ExecuteReader();
                Tabla.Load(Resultado);
                return Tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (SqlCon.State == ConnectionState.Open) SqlCon.Close();
            }
        }
        public DataTable Buscar(string Valor)
        {
            SqlDataReader Resultado;
            DataTable Tabla = new DataTable();
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon = Conexion.getInstancia().CrearConexion();
                SqlCommand Comando = new SqlCommand("venta_buscar", SqlCon);
                Comando.CommandType = CommandType.StoredProcedure;
                Comando.Parameters.Add("@valor", SqlDbType.VarChar).Value = Valor;
                SqlCon.Open();
                Resultado = Comando.ExecuteReader();
                Tabla.Load(Resultado);
                return Tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (SqlCon.State == ConnectionState.Open) SqlCon.Close();
            }
        }
        public DataTable ConsultaFechas(DateTime FechaInicio, DateTime FechaFin)
        {
            SqlDataReader Resultado;
            DataTable Tabla = new DataTable();
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon = Conexion.getInstancia().CrearConexion();
                SqlCommand Comando = new SqlCommand("venta_consulta_fechas", SqlCon);
                Comando.CommandType = CommandType.StoredProcedure;
                Comando.Parameters.Add("@fecha_inicio", SqlDbType.Date).Value = FechaInicio;
                Comando.Parameters.Add("@fecha_fin", SqlDbType.Date).Value = FechaFin;
                SqlCon.Open();
                Resultado = Comando.ExecuteReader();
                Tabla.Load(Resultado);
                return Tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (SqlCon.State == ConnectionState.Open) SqlCon.Close();
            }
        }
        public DataTable ListarDetalle(int Id)
        {
            SqlDataReader Resultado;
            DataTable Tabla = new DataTable();
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon = Conexion.getInstancia().CrearConexion();
                SqlCommand Comando = new SqlCommand("venta_listar_detalle", SqlCon);
                Comando.CommandType = CommandType.StoredProcedure;
                Comando.Parameters.Add("@idventa", SqlDbType.Int).Value = Id;
                SqlCon.Open();
                Resultado = Comando.ExecuteReader();
                Tabla.Load(Resultado);
                return Tabla;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                if (SqlCon.State == ConnectionState.Open) SqlCon.Close();
            }
        }
        public string Insertar(Venta Obj)
        {
            string Rpta = "";
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon = Conexion.getInstancia().CrearConexion();
                SqlCommand Comando = new SqlCommand("venta_insertar", SqlCon);
                Comando.CommandType = CommandType.StoredProcedure;
                Comando.Parameters.Add("@idusuario", SqlDbType.Int).Value = Obj.IdUsuario;
                Comando.Parameters.Add("@idcliente", SqlDbType.Int).Value = Obj.IdCliente;
                Comando.Parameters.Add("@tipo_comprobante", SqlDbType.VarChar, 20).Value = Obj.TipoCompronte;
                Comando.Parameters.Add("@serie_comprobante", SqlDbType.VarChar, 7).Value = Obj.SerieComprobante;
                Comando.Parameters.Add("@num_comprobante", SqlDbType.VarChar, 10).Value = Obj.NumComprobante;
                Comando.Parameters.Add("@impuesto", SqlDbType.Decimal).Value = Obj.Impuesto;
                Comando.Parameters.Add("@total", SqlDbType.Decimal).Value = Obj.Total;
                SqlParameter paramFormaPago = new SqlParameter("@forma_pago", SqlDbType.VarChar, 50);
                paramFormaPago.Value = string.IsNullOrWhiteSpace(Obj.FormaPago) ? (object)DBNull.Value : Obj.FormaPago;
                Comando.Parameters.Add(paramFormaPago);
                
                SqlParameter paramCuota = new SqlParameter("@cuota", SqlDbType.VarChar, 20);
                paramCuota.Value = string.IsNullOrWhiteSpace(Obj.Cuota) ? (object)DBNull.Value : Obj.Cuota;
                Comando.Parameters.Add(paramCuota);
                Comando.Parameters.Add("@detalle", SqlDbType.Structured).Value = Obj.Detalles;
                SqlCon.Open();
                Comando.ExecuteNonQuery();
                Rpta = "OK";
            }
            catch (Exception ex)
            {
                Rpta = ex.Message;
            }
            finally
            {
                if (SqlCon.State == ConnectionState.Open) SqlCon.Close();
            }
            return Rpta;
        }
        public string Anular(int Id)
        {
            string Rpta = "";
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon = Conexion.getInstancia().CrearConexion();
                SqlCommand Comando = new SqlCommand("venta_anular", SqlCon);
                Comando.CommandType = CommandType.StoredProcedure;
                Comando.Parameters.Add("@idventa", SqlDbType.Int).Value = Id;
                SqlCon.Open();
                Comando.ExecuteNonQuery();
                Rpta = "OK";
            }
            catch (Exception ex)
            {
                Rpta = ex.Message;
            }
            finally
            {
                if (SqlCon.State == ConnectionState.Open) SqlCon.Close();
            }
            return Rpta;
        }
    }
}
