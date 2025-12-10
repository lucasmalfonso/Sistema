using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Sistema.Datos;

namespace Sistema.Negocio
{
    public class NRol
    {
        public static DataTable Listar()
        {
            Datos.DRol Datos = new Datos.DRol();
            return Datos.Listar();
        }
    }
}
