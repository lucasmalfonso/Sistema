using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using Sistema.Negocio;

namespace Sistema.Presentacion
{
    public partial class FrmVenta : Form
    {
        private DataTable DtDetalle = new DataTable();
        public FrmVenta()
        {
            InitializeComponent();
        }
        private void Listar()
        {
            try
            {
                DgvListado.DataSource = NVenta.Listar();
                this.Formato();
                this.Limpiar();
                LblTotal.Text = "Total Registros: " + Convert.ToString(DgvListado.Rows.Count);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + ex.StackTrace);
            }
        }
        private void Buscar()
        {
            try
            {
                DgvListado.DataSource = NVenta.Buscar(TxtBuscar.Text);
                this.Formato();
                LblTotal.Text = "Total Registros: " + Convert.ToString(DgvListado.Rows.Count);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + ex.StackTrace);
            }
        }
        private void Formato()
        {
            
            DgvListado.Columns["ID"].Visible = true;
            DgvListado.Columns["ID"].HeaderText = "Item";

            // Columnas internas ya no se devuelven desde el stored procedure

            // Usuario
            DgvListado.Columns["Usuario"].Width = 120;

            // Cliente
            DgvListado.Columns["Cliente"].Width = 150;

            // Fecha
            DgvListado.Columns["Fecha"].Width = 90;
            DgvListado.Columns["Fecha"].DefaultCellStyle.Format = "dd/MM/yyyy";

            // Forma de pago
            DgvListado.Columns["Forma_Pago"].Width = 120;
            DgvListado.Columns["Forma_Pago"].HeaderText = "Forma de Pago";

            // Cuota
            DgvListado.Columns["Cuota"].Width = 80;

            // Moneda
            DgvListado.Columns["Moneda"].Width = 80;

            // Total
            DgvListado.Columns["Total"].Width = 100;
            DgvListado.Columns["Total"].DefaultCellStyle.Format = "N2";

            // Estado
            DgvListado.Columns["Estado"].Width = 90;

        }

        private void Limpiar()
        {
            TxtBuscar.Clear();
            TxtId.Clear();
            TxtIdCliente.Clear();
            TxtNombreCliente.Clear();
            CboFormadePago.SelectedIndex = -1;
            CboCuota.SelectedIndex = -1;
            CboMoneda.SelectedIndex = -1;
            DtDetalle.Clear();
            TxtTotal.Text = "0.00";

            DgvListado.Columns[0].Visible = false;
            BtnAnular.Visible = false;
            ChkSeleccionar.Checked = false;
        }
        private void MensajeError(string mensaje)
        {
            MessageBox.Show(mensaje, "Sistema de Ventas", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
        private void MensajeOk(string mensaje)
        {
            MessageBox.Show(mensaje, "Sistema de Ventas", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
        private void CrearTabla()
        {
            DtDetalle = new DataTable();
            DtDetalle.Columns.Add("idarticulo", typeof(int));
            DtDetalle.Columns.Add("idservicio", typeof(int));
            DtDetalle.Columns.Add("articulo", typeof(string));
            DtDetalle.Columns.Add("stock", typeof(int));
            DtDetalle.Columns.Add("cantidad", typeof(int));
            DtDetalle.Columns.Add("precio", typeof(decimal));
            DtDetalle.Columns.Add("descuento", typeof(decimal));
            DtDetalle.Columns.Add("importe", typeof(decimal));

            DgvDetalle.AutoGenerateColumns = true; // si no tenés columnas manuales en diseñador
            DgvDetalle.DataSource = DtDetalle;

            // Ocultar IDs
            DgvDetalle.Columns["idarticulo"].Visible = false;
            DgvDetalle.Columns["idservicio"].Visible = false;

            // Mostrar / formatear
            DgvDetalle.Columns["articulo"].HeaderText = "ARTICULO/SERVICIO";
            DgvDetalle.Columns["articulo"].Width = 200;

            DgvDetalle.Columns["stock"].HeaderText = "STOCK";
            DgvDetalle.Columns["stock"].Width = 80;

            DgvDetalle.Columns["cantidad"].HeaderText = "CANTIDAD";
            DgvDetalle.Columns["cantidad"].Width = 70;

            DgvDetalle.Columns["precio"].HeaderText = "PRECIO";
            DgvDetalle.Columns["precio"].Width = 70;
            DgvDetalle.Columns["precio"].DefaultCellStyle.Format = "N2";

            DgvDetalle.Columns["descuento"].HeaderText = "DESCUENTO";
            DgvDetalle.Columns["descuento"].Width = 80;
            DgvDetalle.Columns["descuento"].DefaultCellStyle.Format = "N2";

            DgvDetalle.Columns["importe"].HeaderText = "IMPORTE";
            DgvDetalle.Columns["importe"].Width = 90;
            DgvDetalle.Columns["importe"].DefaultCellStyle.Format = "N2";

            // Solo lectura
            DgvDetalle.Columns["articulo"].ReadOnly = true;
            DgvDetalle.Columns["stock"].ReadOnly = true;
            DgvDetalle.Columns["importe"].ReadOnly = true;
        }

        private void FrmVenta_Load(object sender, EventArgs e)
        {
            this.Listar();
            this.CrearTabla();
        }
        private void BtnBuscar_Click(object sender, EventArgs e)
        {
            this.Buscar();
        }
        private void BtnBuscarCliente_Click(object sender, EventArgs e)
        {
            FrmVista_ClienteVenta vista = new FrmVista_ClienteVenta();
            vista.ShowDialog();
            TxtIdCliente.Text = Convert.ToString(Variables.IdCliente);
            TxtNombreCliente.Text = Variables.NombreCliente;

        }
        private void TxtNombre_KeyDown(object sender, KeyEventArgs e)
        {
            try
            {
                if (e.KeyCode == Keys.Enter)
                {
                    DataTable Tabla = new DataTable();
                    // Primero busca en artículos
                    Tabla = NArticulo.BuscarNombreVenta(TxtNombre.Text.Trim());
                    if (Tabla.Rows.Count > 0)
                    {
                        // Es un artículo
                        this.AgregarDetalle(Convert.ToInt32(Tabla.Rows[0][0]), Convert.ToString(Tabla.Rows[0][1]), Convert.ToInt32(Tabla.Rows[0][3]), Convert.ToDecimal(Tabla.Rows[0][2]));
                    }
                    else
                    {
                        // Si no encuentra artículo, busca en servicios
                        Tabla = NServicio.BuscarNombreVenta(TxtNombre.Text.Trim());
                        if (Tabla.Rows.Count > 0)
                        {
                            // Es un servicio (no tiene stock, usamos 0)
                            this.AgregarDetalle(Convert.ToInt32(Tabla.Rows[0][0]), Convert.ToString(Tabla.Rows[0][1]), 0, Convert.ToDecimal(Tabla.Rows[0][2]));
                        }
                        else
                        {
                            this.MensajeError("No existe el artículo o servicio con ese nombre en el sistema o no está disponible");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void AgregarDetalle(int IdArticulo, string Nombre, int Stock, decimal Precio)
        {
            // Si Stock es 0, es un servicio, sino es un artículo
            bool EsServicio = (Stock == 0);
            int IdServicio = EsServicio ? IdArticulo : 0;
            int IdArticuloReal = EsServicio ? 0 : IdArticulo;
            
            bool Agregar = true;
            foreach (DataRow FilaTemp in this.DtDetalle.Rows)
            {
                if (EsServicio)
                {
                    if (FilaTemp["idservicio"] != DBNull.Value && Convert.ToInt32(FilaTemp["idservicio"]) == IdServicio)
                    {
                        Agregar = false;
                        this.MensajeError("El servicio ya ha sido agregado al detalle");
                    }
                }
                else
                {
                    if (FilaTemp["idarticulo"] != DBNull.Value && Convert.ToInt32(FilaTemp["idarticulo"]) == IdArticuloReal)
                    {
                        Agregar = false;
                        this.MensajeError("El artículo ya ha sido agregado al detalle");
                    }
                }
            }
            if (Agregar)
            {
                DataRow Fila = DtDetalle.NewRow();
                if (EsServicio)
                {
                    Fila["idarticulo"] = DBNull.Value;
                    Fila["idservicio"] = IdServicio;
                }
                else
                {
                    Fila["idarticulo"] = IdArticuloReal;
                    Fila["idservicio"] = DBNull.Value;
                }
                Fila["articulo"] = Nombre;
                Fila["stock"] = Stock;
                Fila["cantidad"] = 1;
                Fila["precio"] = Precio;
                Fila["descuento"] = 0;
                Fila["importe"] = Precio;
                this.DtDetalle.Rows.Add(Fila);
                this.CalcularTotales();
            }
        }
        private void CalcularTotales()
        {
            decimal Total = 0;
            if (DgvDetalle.Rows.Count == 0)
            {
                Total = 0;
            }
            else
            {
                foreach (DataRow FilaTemp in DtDetalle.Rows)
                {
                    Total = Total + Convert.ToDecimal(FilaTemp["importe"]);
                }
            }
            TxtTotal.Text = Total.ToString("#0.00#");

        }
        private void BtnVerArticulos_Click(object sender, EventArgs e)
        {
            PanelArticulos.Visible = true;
        }
        private void BtnCerrarArticulos_Click(object sender, EventArgs e)
        {
            PanelArticulos.Visible = false;
        }
        private void FormatoArticulos()
        {
            DgvArticulos.Columns[0].Visible = false;
            DgvArticulos.Columns[2].Width = 100;
            DgvArticulos.Columns[2].HeaderText = "Categoría";
            DgvArticulos.Columns[3].Width = 150;
            DgvArticulos.Columns[4].Width = 100;
            DgvArticulos.Columns[4].HeaderText = "Precio Venta";
            DgvArticulos.Columns[5].Width = 60;
            DgvArticulos.Columns[6].Width = 200;
            DgvArticulos.Columns[6].HeaderText = "Descripcion";
            DgvArticulos.Columns[7].Width = 100;
        }
        private void BtnFiltrarArticulos_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable TablaArticulos = NArticulo.BuscarVenta(TxtBuscarArticulo.Text.Trim());
                DataTable TablaServicios = NServicio.BuscarVenta(TxtBuscarArticulo.Text.Trim());
                
                // Combinar ambas tablas
                DataTable TablaCombinada = TablaArticulos.Clone();
                // Agregar columna para identificar si es servicio
                if (!TablaCombinada.Columns.Contains("EsServicio"))
                {
                    TablaCombinada.Columns.Add("EsServicio", typeof(bool));
                }
                
                // Copiar filas de artículos
                foreach (DataRow row in TablaArticulos.Rows)
                {
                    DataRow newRow = TablaCombinada.NewRow();
                    newRow.ItemArray = row.ItemArray;
                    newRow["EsServicio"] = false;
                    TablaCombinada.Rows.Add(newRow);
                }
                
                // Copiar filas de servicios (agregar columna Stock con valor 0)
                foreach (DataRow row in TablaServicios.Rows)
                {
                    DataRow newRow = TablaCombinada.NewRow();
                    newRow["ID"] = row["ID"];
                    newRow["idcategoria"] = row["idcategoria"];
                    newRow["Categoria"] = row["Categoria"];
                    newRow["Nombre"] = row["Nombre"];
                    newRow["Precio_Venta"] = row["Precio_Venta"];
                    newRow["Stock"] = 0; // Los servicios no tienen stock
                    newRow["Descripcion"] = row["Descripcion"];
                    newRow["Imagen"] = row["Imagen"];
                    newRow["Estado"] = row["Estado"];
                    newRow["EsServicio"] = true; // Marcar como servicio
                    TablaCombinada.Rows.Add(newRow);
                }
                
                DgvArticulos.DataSource = TablaCombinada;
                this.FormatoArticulos();
                LblTotalArticulos.Text = "Total Registros: " + Convert.ToString(DgvArticulos.Rows.Count);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + ex.StackTrace);
            }
        }
        private void DgvArticulos_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            int IdArticulo;
            string Nombre;
            decimal Precio;
            int Stock;
            bool EsServicio = false;
            
            IdArticulo = Convert.ToInt32(DgvArticulos.CurrentRow.Cells["ID"].Value);
            Nombre = Convert.ToString(DgvArticulos.CurrentRow.Cells["Nombre"].Value);
            
            // Verificar si es servicio usando la columna EsServicio si existe
            if (DgvArticulos.CurrentRow.Cells["EsServicio"] != null && DgvArticulos.CurrentRow.Cells["EsServicio"].Value != DBNull.Value)
            {
                EsServicio = Convert.ToBoolean(DgvArticulos.CurrentRow.Cells["EsServicio"].Value);
            }
            
            // Si la columna Stock existe, usar su valor, sino usar 0 (es un servicio)
            if (DgvArticulos.CurrentRow.Cells["Stock"].Value != null && DgvArticulos.CurrentRow.Cells["Stock"].Value != DBNull.Value)
            {
                Stock = Convert.ToInt32(DgvArticulos.CurrentRow.Cells["Stock"].Value);
            }
            else
            {
                Stock = 0; // Es un servicio
                EsServicio = true;
            }
            
            Precio = Convert.ToDecimal(DgvArticulos.CurrentRow.Cells["Precio_Venta"].Value);
            
            // Si es servicio, forzar stock a 0
            if (EsServicio)
            {
                Stock = 0;
            }
            
            this.AgregarDetalle(IdArticulo, Nombre, Stock, Precio);
        }
        private void DgvDetalle_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            DataRow Fila = (DataRow)DtDetalle.Rows[e.RowIndex];
            string Articulo = Convert.ToString(Fila["articulo"]);
            int Cantidad = Convert.ToInt32(Fila["cantidad"]);
            int Stock = Convert.ToInt32(Fila["stock"]);
            decimal Precio = Convert.ToDecimal(Fila["precio"]);
            decimal Descuento = Convert.ToDecimal(Fila["descuento"]);
            // Solo validar stock si es mayor a 0 (los servicios tienen stock = 0)
            if (Stock > 0 && Cantidad > Stock)
            {
                Cantidad = Stock;
                this.MensajeError("La cantidad de venta del articulo " + Articulo + " supera el stock disponible " + Stock);
            }
            Fila["cantidad"] = Cantidad;
            Fila["importe"] = (Cantidad * Precio) - Descuento;
            this.CalcularTotales();
        }

        private void BtnInsertar_Click(object sender, EventArgs e)
        {
            try
            {
                string Rpta = "";
                if (TxtIdCliente.Text == String.Empty || DtDetalle.Rows.Count == 0)
                {
                    this.MensajeError("Falta ingresar algunos datos, serán remarcados");
                    ErrorIcono.SetError(TxtIdCliente, "Seleccione un cliente");
                    ErrorIcono.SetError(DgvDetalle, "Ingrese los detalles del ingreso");
                }
                else
                {
                    string formaPago = !string.IsNullOrWhiteSpace(CboFormadePago.Text) ? CboFormadePago.Text.Trim() : "";
                    string cuota = !string.IsNullOrWhiteSpace(CboCuota.Text) ? CboCuota.Text.Trim() : "";
                    string moneda = !string.IsNullOrWhiteSpace(CboMoneda.Text) ? CboMoneda.Text.Trim() : "";
                    Rpta = NVenta.Insertar(Convert.ToInt32(TxtIdCliente.Text), Variables.IdUsuario, Convert.ToDecimal(TxtTotal.Text), formaPago, cuota, moneda, DtDetalle);
                    if (Rpta.Equals("OK"))
                    {
                        this.MensajeOk("Se insertó de forma correcta el registro");
                        this.Limpiar();
                        this.Listar();
                    }
                    else
                    {
                        this.MensajeError(Rpta);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + ex.StackTrace);
            }
        }

        private void BtnCancelar_Click(object sender, EventArgs e)
        {
            this.Limpiar();
            TabGeneral.SelectedIndex = 0;
        }

        private void DgvListado_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                // Limpiar el DataSource y las columnas previas completamente
                DgvMostrarDetalle.DataSource = null;
                DgvMostrarDetalle.Columns.Clear();
                DgvMostrarDetalle.AutoGenerateColumns = true;
                
                // Asignar el nuevo DataSource
                DataTable dtDetalle = NVenta.ListarDetalle(Convert.ToInt32(DgvListado.CurrentRow.Cells["ID"].Value));
                DgvMostrarDetalle.DataSource = dtDetalle;
                
                // Formatear las columnas después de asignar el DataSource
                this.FormatoMostrarDetalle();
                
                decimal Total = Convert.ToDecimal(DgvListado.CurrentRow.Cells["Total"].Value);
                TxtTotalD.Text = Total.ToString("#0.00#");
                PanelMostrar.Visible = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void FormatoMostrarDetalle()
        {
            if (DgvMostrarDetalle.Columns.Count > 0)
            {
                // Lista de columnas válidas que deben mostrarse
                string[] columnasValidas = { "ID", "TIPO", "ARTICULO", "CANTIDAD", "PRECIO", "DESCUENTO", "IMPORTE" };
                
                // Primero, eliminar TODAS las columnas que no están en la lista de válidas
                var columnasAEliminar = new List<DataGridViewColumn>();
                foreach (DataGridViewColumn col in DgvMostrarDetalle.Columns)
                {
                    string colNameUpper = col.Name.ToUpper();
                    bool esValida = false;
                    
                    // Verificar si es una columna válida
                    foreach (string colValida in columnasValidas)
                    {
                        if (colNameUpper == colValida.ToUpper())
                        {
                            esValida = true;
                            break;
                        }
                    }
                    
                    // Si no es válida, marcarla para eliminar
                    if (!esValida)
                    {
                        columnasAEliminar.Add(col);
                    }
                }
                
                // Eliminar columnas no válidas
                foreach (var col in columnasAEliminar)
                {
                    DgvMostrarDetalle.Columns.Remove(col);
                }
                
                // Ahora eliminar duplicados de IMPORTE (mantener solo una)
                columnasAEliminar.Clear();
                DataGridViewColumn columnaImportePrincipal = null;
                
                foreach (DataGridViewColumn col in DgvMostrarDetalle.Columns)
                {
                    string colNameUpper = col.Name.ToUpper();
                    if (colNameUpper == "IMPORTE")
                    {
                        if (columnaImportePrincipal == null)
                        {
                            columnaImportePrincipal = col;
                        }
                        else
                        {
                            // Si ya hay una columna IMPORTE, eliminar esta
                            columnasAEliminar.Add(col);
                        }
                    }
                }
                
                // Eliminar duplicados de IMPORTE
                foreach (var col in columnasAEliminar)
                {
                    DgvMostrarDetalle.Columns.Remove(col);
                }
                
                // Ocultar columnas internas
                if (DgvMostrarDetalle.Columns["ID"] != null)
                {
                    DgvMostrarDetalle.Columns["ID"].Visible = false;
                }
                if (DgvMostrarDetalle.Columns["TIPO"] != null)
                {
                    DgvMostrarDetalle.Columns["TIPO"].Visible = false;
                }
                
                // Formatear columna ARTICULO
                if (DgvMostrarDetalle.Columns["ARTICULO"] != null)
                {
                    DgvMostrarDetalle.Columns["ARTICULO"].HeaderText = "ARTICULO/SERVICIO";
                    DgvMostrarDetalle.Columns["ARTICULO"].Width = 200;
                    DgvMostrarDetalle.Columns["ARTICULO"].ReadOnly = true;
                    DgvMostrarDetalle.Columns["ARTICULO"].DisplayIndex = 0;
                }
                
                // Formatear columna CANTIDAD
                if (DgvMostrarDetalle.Columns["CANTIDAD"] != null)
                {
                    DgvMostrarDetalle.Columns["CANTIDAD"].Width = 80;
                    DgvMostrarDetalle.Columns["CANTIDAD"].ReadOnly = true;
                    DgvMostrarDetalle.Columns["CANTIDAD"].DisplayIndex = 1;
                }
                
                // Formatear columna PRECIO
                if (DgvMostrarDetalle.Columns["PRECIO"] != null)
                {
                    DgvMostrarDetalle.Columns["PRECIO"].Width = 80;
                    DgvMostrarDetalle.Columns["PRECIO"].DefaultCellStyle.Format = "N2";
                    DgvMostrarDetalle.Columns["PRECIO"].ReadOnly = true;
                    DgvMostrarDetalle.Columns["PRECIO"].DisplayIndex = 2;
                }
                
                // Formatear columna DESCUENTO
                if (DgvMostrarDetalle.Columns["DESCUENTO"] != null)
                {
                    DgvMostrarDetalle.Columns["DESCUENTO"].Width = 80;
                    DgvMostrarDetalle.Columns["DESCUENTO"].DefaultCellStyle.Format = "N2";
                    DgvMostrarDetalle.Columns["DESCUENTO"].ReadOnly = true;
                    DgvMostrarDetalle.Columns["DESCUENTO"].DisplayIndex = 3;
                }
                
                // Formatear columna IMPORTE (asegurarse de que solo hay una)
                if (DgvMostrarDetalle.Columns["IMPORTE"] != null)
                {
                    DgvMostrarDetalle.Columns["IMPORTE"].Width = 100;
                    DgvMostrarDetalle.Columns["IMPORTE"].DefaultCellStyle.Format = "N2";
                    DgvMostrarDetalle.Columns["IMPORTE"].ReadOnly = true;
                    DgvMostrarDetalle.Columns["IMPORTE"].DisplayIndex = 4;
                }
            }
        }

        private void BtnCerrarDetalle_Click(object sender, EventArgs e)
        {
            PanelMostrar.Visible = false;
        }

        private void DgvListado_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.ColumnIndex == DgvListado.Columns["Seleccionar"].Index)
            {
                DataGridViewCheckBoxCell ChkEliminar = (DataGridViewCheckBoxCell)DgvListado.Rows[e.RowIndex].Cells["Seleccionar"];
                ChkEliminar.Value = !Convert.ToBoolean(ChkEliminar.Value);
            }
        }


        private void ChkSeleccionar_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkSeleccionar.Checked)
            {
                DgvListado.Columns[0].Visible = true;
                BtnAnular.Visible = true;

            }
            else
            {
                DgvListado.Columns[0].Visible = false;
                BtnAnular.Visible = false;
            }
        }

        private void BtnAnular_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult Opcion;
                Opcion = MessageBox.Show("¿Realmente desea anular el(los) registro(s) seleccionados?", "Sistema de Ventas", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
                if (Opcion == DialogResult.OK)
                {
                    int Codigo;
                    string Rpta = "";

                    foreach (DataGridViewRow row in DgvListado.Rows)
                    {
                        if (Convert.ToBoolean(row.Cells[0].Value))
                        {
                            Codigo = Convert.ToInt32(row.Cells[1].Value);
                            Rpta = NVenta.Anular(Codigo);

                            if (Rpta.Equals("OK"))
                            {
                                this.MensajeOk("Se anuló de forma correcta el registro" + Convert.ToString(row.Cells[6].Value) + "-" + Convert.ToString(row.Cells[7].Value));
                            }
                            else
                            {
                                this.MensajeError(Rpta);
                            }
                        }
                    }
                    this.Listar();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + ex.StackTrace);
            }
        }

        private void BtnComprobante_Click(object sender, EventArgs e)
        {
            try
            {
                Variables.IdVenta = Convert.ToInt32(DgvListado.CurrentRow.Cells["ID"].Value);
                Reportes.FrmReporteComprobanteVenta reporte = new Reportes.FrmReporteComprobanteVenta();
                reporte.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void label16_Click(object sender, EventArgs e)
        {

        }

        private void label10_Click(object sender, EventArgs e)
        {

        }

        private void DgvMostrarDetalle_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
