using System;
using System.Data;
using Sistema.Datos;
using Sistema.Entidades;

namespace Sistema.Negocio
{
    public class NVenta
    {
        public static DataTable Listar()
        {
            DVenta Datos = new DVenta();
            return Datos.Listar();
        }
        public static DataTable Buscar(string Valor)
        {
            DVenta Datos = new DVenta();
            return Datos.Buscar(Valor);
        }
        public static DataTable ConsultaFechas(DateTime FechaInicio, DateTime FechaFin, string FormaPago, string Moneda)
        {
            DVenta Datos = new DVenta();
            return Datos.ConsultaFechas(FechaInicio, FechaFin, FormaPago, Moneda);
        }
        public static DataTable ListarDetalle(int Id)
        {
            DVenta Datos = new DVenta();
            return Datos.ListarDetalle(Id);
        }
        public static string Insertar(int IdCliente, int IdUsuario, decimal Total, string FormaPago, string Cuota, string Moneda, DataTable Detalles)
        {
            DVenta Datos = new DVenta();
            Venta Obj = new Venta();
            Obj.IdCliente = IdCliente;
            Obj.IdUsuario = IdUsuario;
            Obj.Total = Total;
            Obj.FormaPago = FormaPago;
            Obj.Cuota = Cuota;
            Obj.Moneda = Moneda;
            Obj.Detalles = Detalles;
            return Datos.Insertar(Obj);
        }
        public static string Anular(int Id)
        {
            DVenta Datos = new DVenta();
            return Datos.Anular(Id);
        }
    }
}
