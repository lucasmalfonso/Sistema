namespace Sistema.Entidades
{
    public class Servicio
    {
        public int IdServicio { get; set; }
        public int IdCategoria { get; set; }
        public string Nombre { get; set; }
        public decimal PrecioVenta { get; set; }
        public string Descripcion { get; set; }
        public string Imagen { get; set; }
        public bool Estado { get; set; }
    }
}
