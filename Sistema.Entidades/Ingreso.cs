using System;
using System.Data;

namespace Sistema.Entidades
{
    public class Ingreso
    {
        public int IdIngreso { get; set; }
        public int IdProveedor { get; set; }
        public int IdUsuario { get; set; }
        public DateTime Fecha {  get; set; }
        public decimal Total {  get; set; }
        public string Estado { get; set; }
        public DataTable Detalles { get; set; }
    }
}
