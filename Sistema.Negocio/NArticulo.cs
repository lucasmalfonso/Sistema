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
    public class NArticulo
    {
        public static DataTable Listar()
        {
            DArticulo Datos = new DArticulo();
            return Datos.Listar();
        }
        public static DataTable Buscar(string Valor)
        {
            DArticulo Datos = new DArticulo();
            return Datos.Buscar(Valor);
        }
        public static DataTable BuscarVenta(string Valor)
        {
            DArticulo Datos = new DArticulo();
            return Datos.BuscarVenta(Valor);
        }
        public static DataTable BuscarNombre(string Valor)
        {
            DArticulo Datos = new DArticulo();
            return Datos.BuscarNombre(Valor);
        }
        public static DataTable BuscarNombreVenta(string Valor)
        {
            DArticulo Datos = new DArticulo();
            return Datos.BuscarNombreVenta(Valor);
        }
        public static string Insertar(int IdCategoria, string Nombre,decimal PrecioVenta,int Stock, string Descripcion,string Imagen)
        {
            DArticulo Datos = new DArticulo();

            string Existe = Datos.Existe(Nombre);
            if (Existe.Equals("1"))
            {
                return "El artículo ya existe";
            }
            else
            {
                Articulo Obj = new Articulo();
                Obj.IdCategoria = IdCategoria;
                Obj.Nombre = Nombre;
                Obj.PrecioVenta = PrecioVenta;
                Obj.Stock = Stock;
                Obj.Descripcion = Descripcion;
                Obj.Imagen = Imagen;
                return Datos.Insertar(Obj);
            }
        }
        public static string Actualizar(int Id,int IdCategoria, string NombreAnt, string Nombre,decimal PrecioVenta,int Stock, string Descripcion,string Imagen)
        {
            DArticulo Datos = new DArticulo();
            Articulo Obj = new Articulo();

            if (NombreAnt.Equals(Nombre))
            {
                Obj.IdArticulo = Id;
                Obj.IdCategoria = Id;
                Obj.Nombre = Nombre;
                Obj.PrecioVenta = PrecioVenta;
                Obj.Stock = Stock;
                Obj.Descripcion = Descripcion;
                Obj.Imagen = Imagen;
                return Datos.Actualizar(Obj);
            }
            else
            {
                string Existe = Datos.Existe(Nombre);
                if (Existe.Equals("1"))
                {
                    return "El artículo ya existe";
                }
                else
                {
                    Obj.IdArticulo = Id;
                    Obj.IdCategoria = Id;
                    Obj.Nombre = Nombre;
                    Obj.PrecioVenta = PrecioVenta;
                    Obj.Stock = Stock;
                    Obj.Descripcion = Descripcion;
                    Obj.Imagen = Imagen;
                    return Datos.Actualizar(Obj);
                }
            }

        }
        public static string Eliminar(int Id)
        {
            DArticulo Datos = new DArticulo();
            return Datos.Eliminar(Id);
        }
        public static string Activar(int Id)
        {
            DArticulo Datos = new DArticulo();
            return Datos.Activar(Id);
        }
        public static string Desactivar(int Id)
        {
            DArticulo Datos = new DArticulo();
            return Datos.Desactivar(Id);
        }
    }
}
