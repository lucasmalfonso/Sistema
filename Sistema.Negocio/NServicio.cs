using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sistema.Datos;
using Sistema.Entidades;

namespace Sistema.Negocio
{
    public class NServicio
    {
        public static DataTable Listar()
        {
            DServicio Datos = new DServicio();
            return Datos.Listar();
        }
        public static DataTable Buscar(string Valor)
        {
            DServicio Datos = new DServicio();
            return Datos.Buscar(Valor);
        }
        public static DataTable BuscarVenta(string Valor)
        {
            DServicio Datos = new DServicio();
            return Datos.BuscarVenta(Valor);
        }
        public static DataTable BuscarNombre(string Valor)
        {
            DServicio Datos = new DServicio();
            return Datos.BuscarNombre(Valor);
        }
        public static DataTable BuscarNombreVenta(string Valor)
        {
            DServicio Datos = new DServicio();
            return Datos.BuscarNombreVenta(Valor);
        }
        public static string Insertar(int IdCategoria, string Nombre,decimal PrecioVenta, string Descripcion,string Imagen)
        {
            DServicio Datos = new DServicio();

            string Existe = Datos.Existe(Nombre);
            if (Existe.Equals("1"))
            {
                return "El servicio ya existe";
            }
            else
            {
                Servicio Obj = new Servicio();
                Obj.IdCategoria = IdCategoria;
                Obj.Nombre = Nombre;
                Obj.PrecioVenta = PrecioVenta;
                Obj.Descripcion = Descripcion;
                Obj.Imagen = Imagen;
                return Datos.Insertar(Obj);
            }
        }
        public static string Actualizar(int Id,int IdCategoria, string NombreAnt, string Nombre,decimal PrecioVenta, string Descripcion,string Imagen)
        {
            DServicio Datos = new DServicio();
            Servicio Obj = new Servicio();

            if (NombreAnt.Equals(Nombre))
            {
                Obj.IdServicio = Id;
                Obj.IdCategoria = IdCategoria;
                Obj.Nombre = Nombre;
                Obj.PrecioVenta = PrecioVenta;
                Obj.Descripcion = Descripcion;
                Obj.Imagen = Imagen;
                return Datos.Actualizar(Obj);
            }
            else
            {
                string Existe = Datos.Existe(Nombre);
                if (Existe.Equals("1"))
                {
                    return "El servicio ya existe";
                }
                else
                {
                    Obj.IdServicio = Id;
                    Obj.IdCategoria = IdCategoria;
                    Obj.Nombre = Nombre;
                    Obj.PrecioVenta = PrecioVenta;
                    Obj.Descripcion = Descripcion;
                    Obj.Imagen = Imagen;
                    return Datos.Actualizar(Obj);
                }
            }

        }
        public static string Eliminar(int Id)
        {
            DServicio Datos = new DServicio();
            return Datos.Eliminar(Id);
        }
        public static string Activar(int Id)
        {
            DServicio Datos = new DServicio();
            return Datos.Activar(Id);
        }
        public static string Desactivar(int Id)
        {
            DServicio Datos = new DServicio();
            return Datos.Desactivar(Id);
        }
    }
}
