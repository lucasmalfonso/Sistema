using System;
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
            this.DtDetalle.Columns.Add("idarticulo", System.Type.GetType("System.Int32"));
            this.DtDetalle.Columns.Add("idservicio", System.Type.GetType("System.Int32"));
            this.DtDetalle.Columns.Add("articulo", System.Type.GetType("System.String"));
            this.DtDetalle.Columns.Add("stock", System.Type.GetType("System.Int32"));
            this.DtDetalle.Columns.Add("cantidad", System.Type.GetType("System.Int32"));
            this.DtDetalle.Columns.Add("precio", System.Type.GetType("System.Decimal"));
            this.DtDetalle.Columns.Add("descuento", System.Type.GetType("System.Decimal"));
            this.DtDetalle.Columns.Add("importe", System.Type.GetType("System.Decimal"));

            DgvDetalle.DataSource = this.DtDetalle;

            DgvDetalle.Columns[0].Visible = false; // idarticulo
            DgvDetalle.Columns[1].Visible = false; // idservicio
            DgvDetalle.Columns[2].HeaderText = "ARTICULO/SERVICIO";
            DgvDetalle.Columns[2].Width = 200;
            DgvDetalle.Columns[3].HeaderText = "STOCK";
            DgvDetalle.Columns[3].Width = 80;
            DgvDetalle.Columns[4].HeaderText = "CANTIDAD";
            DgvDetalle.Columns[4].Width = 70;
            DgvDetalle.Columns[5].HeaderText = "PRECIO";
            DgvDetalle.Columns[5].Width = 70;
            DgvDetalle.Columns[6].HeaderText = "DESCUENTO";
            DgvDetalle.Columns[6].Width = 80;
            DgvDetalle.Columns[7].HeaderText = "IMPORTE";
            DgvDetalle.Columns[7].Width = 80;

            DgvDetalle.Columns[2].ReadOnly = true;
            DgvDetalle.Columns[3].ReadOnly = true;
            DgvDetalle.Columns[7].ReadOnly = true;
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
                    DataTable TablaArticulo = new DataTable();
                    DataTable TablaServicio = new DataTable();
                    
                    // Buscar artículo
                    TablaArticulo = NArticulo.BuscarNombreVenta(TxtNombre.Text.Trim());
                    
                    // Buscar servicio
                    TablaServicio = NServicio.BuscarNombreVenta(TxtNombre.Text.Trim());
                    
                    if (TablaArticulo.Rows.Count > 0)
                    {
                        // Es un artículo
                        this.AgregarDetalle(Convert.ToInt32(TablaArticulo.Rows[0][0]), Convert.ToString(TablaArticulo.Rows[0][1]), Convert.ToInt32(TablaArticulo.Rows[0][3]), Convert.ToDecimal(TablaArticulo.Rows[0][2]));
                        TxtNombre.Clear();
                    }
                    else if (TablaServicio.Rows.Count > 0)
                    {
                        // Es un servicio
                        this.AgregarDetalleServicio(Convert.ToInt32(TablaServicio.Rows[0][0]), Convert.ToString(TablaServicio.Rows[0][1]), Convert.ToDecimal(TablaServicio.Rows[0][2]));
                        TxtNombre.Clear();
                    }
                    else
                    {
                        this.MensajeError("No existe el artículo o servicio con ese nombre en el sistema o no hay stock disponible");
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
            bool Agregar = true;
            foreach (DataRow FilaTemp in this.DtDetalle.Rows)
            {
                if (!DBNull.Value.Equals(FilaTemp["idarticulo"]) && Convert.ToInt32(FilaTemp["idarticulo"]) == IdArticulo)
                {
                    Agregar = false;
                    this.MensajeError("El artículo ya ha sido agregado al detalle");
                }
            }
            if (Agregar)
            {
                DataRow Fila = DtDetalle.NewRow();
                Fila["idarticulo"] = IdArticulo;
                Fila["idservicio"] = DBNull.Value;
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
        private void AgregarDetalleServicio(int IdServicio, string Nombre, decimal Precio)
        {
            bool Agregar = true;
            foreach (DataRow FilaTemp in this.DtDetalle.Rows)
            {
                if (!DBNull.Value.Equals(FilaTemp["idservicio"]) && Convert.ToInt32(FilaTemp["idservicio"]) == IdServicio)
                {
                    Agregar = false;
                    this.MensajeError("El servicio ya ha sido agregado al detalle");
                }
            }
            if (Agregar)
            {
                DataRow Fila = DtDetalle.NewRow();
                Fila["idarticulo"] = DBNull.Value;
                Fila["idservicio"] = IdServicio;
                Fila["articulo"] = Nombre;
                Fila["stock"] = DBNull.Value; // Los servicios no tienen stock
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
            // Cargar todos los artículos y servicios al abrir el panel
            TxtBuscarArticulo.Clear();
            BtnFiltrarArticulos_Click(sender, e);
        }
        private void BtnCerrarArticulos_Click(object sender, EventArgs e)
        {
            PanelArticulos.Visible = false;
        }
        private void FormatoArticulos()
        {
            DgvArticulos.Columns[0].Visible = false; // ID
            if (DgvArticulos.Columns.Contains("Tipo"))
            {
                DgvArticulos.Columns["Tipo"].Visible = false;
            }
            if (DgvArticulos.Columns.Contains("Categoria"))
            {
                DgvArticulos.Columns["Categoria"].Width = 100;
                DgvArticulos.Columns["Categoria"].HeaderText = "Categoría";
            }
            if (DgvArticulos.Columns.Contains("Nombre"))
            {
                DgvArticulos.Columns["Nombre"].Width = 150;
            }
            if (DgvArticulos.Columns.Contains("Precio_Venta"))
            {
                DgvArticulos.Columns["Precio_Venta"].Width = 100;
                DgvArticulos.Columns["Precio_Venta"].HeaderText = "Precio Venta";
            }
            if (DgvArticulos.Columns.Contains("Stock"))
            {
                DgvArticulos.Columns["Stock"].Width = 60;
            }
            if (DgvArticulos.Columns.Contains("Descripcion"))
            {
                DgvArticulos.Columns["Descripcion"].Width = 200;
                DgvArticulos.Columns["Descripcion"].HeaderText = "Descripcion";
            }
            if (DgvArticulos.Columns.Contains("Estado"))
            {
                DgvArticulos.Columns["Estado"].Width = 100;
            }
        }
        private void BtnFiltrarArticulos_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable TablaArticulos = NArticulo.BuscarVenta(TxtBuscarArticulo.Text.Trim());
                DataTable TablaServicios = NServicio.BuscarVenta(TxtBuscarArticulo.Text.Trim());
                
                // Combinar artículos y servicios
                DataTable TablaCombinada = new DataTable();
                
                // Crear estructura base con todas las columnas necesarias
                if (TablaArticulos.Rows.Count > 0)
                {
                    TablaCombinada = TablaArticulos.Clone();
                    // Cambiar el tipo de la columna Stock a string para poder mostrar "-" en servicios
                    if (TablaCombinada.Columns.Contains("Stock"))
                    {
                        int stockIndex = TablaCombinada.Columns.IndexOf("Stock");
                        TablaCombinada.Columns.Remove("Stock");
                        TablaCombinada.Columns.Add("Stock", typeof(string));
                        // Mover la columna Stock a su posición original
                        TablaCombinada.Columns["Stock"].SetOrdinal(stockIndex);
                    }
                    // Agregar columna Tipo para distinguir artículos de servicios
                    if (!TablaCombinada.Columns.Contains("Tipo"))
                    {
                        TablaCombinada.Columns.Add("Tipo", typeof(string));
                    }
                    // Agregar artículos
                    foreach (DataRow row in TablaArticulos.Rows)
                    {
                        DataRow newRow = TablaCombinada.NewRow();
                        foreach (DataColumn col in TablaArticulos.Columns)
                        {
                            if (col.ColumnName == "Stock")
                            {
                                // Convertir Stock a string
                                newRow["Stock"] = Convert.ToString(row[col]);
                            }
                            else if (TablaCombinada.Columns.Contains(col.ColumnName))
                            {
                                newRow[col.ColumnName] = row[col.ColumnName];
                            }
                        }
                        newRow["Tipo"] = "Articulo";
                        TablaCombinada.Rows.Add(newRow);
                    }
                }
                else
                {
                    // Si no hay artículos, clonar estructura de servicios y agregar columnas Stock y Tipo
                    TablaCombinada = TablaServicios.Clone();
                    if (!TablaCombinada.Columns.Contains("Stock"))
                    {
                        TablaCombinada.Columns.Add("Stock", typeof(string));
                    }
                    if (!TablaCombinada.Columns.Contains("Tipo"))
                    {
                        TablaCombinada.Columns.Add("Tipo", typeof(string));
                    }
                }
                
                // Si hay artículos pero no hay columna Stock en la estructura combinada, agregarla
                if (!TablaCombinada.Columns.Contains("Stock") && TablaServicios.Rows.Count > 0)
                {
                    TablaCombinada.Columns.Add("Stock", typeof(string));
                }
                if (!TablaCombinada.Columns.Contains("Tipo") && TablaServicios.Rows.Count > 0)
                {
                    TablaCombinada.Columns.Add("Tipo", typeof(string));
                }
                
                // Agregar servicios
                foreach (DataRow row in TablaServicios.Rows)
                {
                    DataRow newRow = TablaCombinada.NewRow();
                    foreach (DataColumn col in TablaServicios.Columns)
                    {
                        if (TablaCombinada.Columns.Contains(col.ColumnName))
                        {
                            newRow[col.ColumnName] = row[col.ColumnName];
                        }
                    }
                    // Los servicios no tienen stock, poner "-"
                    if (TablaCombinada.Columns.Contains("Stock"))
                    {
                        newRow["Stock"] = "-";
                    }
                    if (TablaCombinada.Columns.Contains("Tipo"))
                    {
                        newRow["Tipo"] = "Servicio";
                    }
                    TablaCombinada.Rows.Add(newRow);
                }
                
                DgvArticulos.DataSource = TablaCombinada;
                this.FormatoArticulos();
                LblTotalArticulos.Text = "Total Registros: " + Convert.ToString(DgvArticulos.Rows.Count);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void DgvArticulos_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                int Id;
                string Nombre;
                decimal Precio;
                int Stock = 0;
                string Tipo = "";
                
                Id = Convert.ToInt32(DgvArticulos.CurrentRow.Cells["ID"].Value);
                Nombre = Convert.ToString(DgvArticulos.CurrentRow.Cells["Nombre"].Value);
                Precio = Convert.ToDecimal(DgvArticulos.CurrentRow.Cells["Precio_Venta"].Value);
                
                // Verificar tipo usando la columna Tipo si existe
                if (DgvArticulos.CurrentRow.Cells["Tipo"] != null && DgvArticulos.CurrentRow.Cells["Tipo"].Value != DBNull.Value)
                {
                    Tipo = Convert.ToString(DgvArticulos.CurrentRow.Cells["Tipo"].Value);
                }
                else if (DgvArticulos.CurrentRow.Cells["Stock"] != null && DgvArticulos.CurrentRow.Cells["Stock"].Value != DBNull.Value)
                {
                    // Si no hay columna Tipo, usar Stock para determinar
                    string stockValue = Convert.ToString(DgvArticulos.CurrentRow.Cells["Stock"].Value);
                    if (stockValue == "-")
                    {
                        Tipo = "Servicio";
                    }
                    else
                    {
                        Tipo = "Articulo";
                        Stock = Convert.ToInt32(stockValue);
                    }
                }
                
                if (Tipo == "Servicio")
                {
                    // Es un servicio
                    this.AgregarDetalleServicio(Id, Nombre, Precio);
                }
                else
                {
                    // Es un artículo
                    if (DgvArticulos.CurrentRow.Cells["Stock"] != null && DgvArticulos.CurrentRow.Cells["Stock"].Value != DBNull.Value)
                    {
                        string stockValue = Convert.ToString(DgvArticulos.CurrentRow.Cells["Stock"].Value);
                        if (stockValue != "-")
                        {
                            Stock = Convert.ToInt32(stockValue);
                        }
                    }
                    this.AgregarDetalle(Id, Nombre, Stock, Precio);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void DgvDetalle_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            DataRow Fila = (DataRow)DtDetalle.Rows[e.RowIndex];
            string Articulo = Convert.ToString(Fila["articulo"]);
            int Cantidad = Convert.ToInt32(Fila["cantidad"]);
            decimal Precio = Convert.ToDecimal(Fila["precio"]);
            decimal Descuento = Convert.ToDecimal(Fila["descuento"]);
            
            // Solo validar stock si es un artículo (idservicio es null)
            if (DBNull.Value.Equals(Fila["idservicio"]) || Fila["idservicio"] == DBNull.Value)
            {
                // Es un artículo, validar stock
                if (!DBNull.Value.Equals(Fila["stock"]) && Fila["stock"] != DBNull.Value)
                {
                    int Stock = Convert.ToInt32(Fila["stock"]);
                    if (Cantidad > Stock)
                    {
                        Cantidad = Stock;
                        Fila["cantidad"] = Cantidad;
                        this.MensajeError("La cantidad de venta del artículo " + Articulo + " supera el stock disponible " + Stock);
                    }
                }
            }
            // Los servicios no tienen validación de stock
            
            Fila["importe"] = (Cantidad * Precio) - Descuento;
            this.CalcularTotales();
        }

        private void BtnInsertar_Click(object sender, EventArgs e)
        {
            try
            {
                string Rpta = "";
                // Limpiar errores previos
                ErrorIcono.Clear();
                
                // Validar campos obligatorios
                bool hayErrores = false;
                
                if (TxtIdCliente.Text == String.Empty)
                {
                    ErrorIcono.SetError(TxtIdCliente, "Seleccione un cliente");
                    hayErrores = true;
                }
                
                if (DtDetalle.Rows.Count == 0)
                {
                    ErrorIcono.SetError(DgvDetalle, "Ingrese los detalles del ingreso");
                    hayErrores = true;
                }
                
                if (CboFormadePago.SelectedIndex == -1 || string.IsNullOrWhiteSpace(CboFormadePago.Text))
                {
                    ErrorIcono.SetError(CboFormadePago, "Seleccione una forma de pago");
                    hayErrores = true;
                }
                
                if (CboMoneda.SelectedIndex == -1 || string.IsNullOrWhiteSpace(CboMoneda.Text))
                {
                    ErrorIcono.SetError(CboMoneda, "Seleccione una moneda");
                    hayErrores = true;
                }
                
                if (CboCuota.SelectedIndex == -1 || string.IsNullOrWhiteSpace(CboCuota.Text))
                {
                    ErrorIcono.SetError(CboCuota, "Seleccione una cuota");
                    hayErrores = true;
                }
                
                if (hayErrores)
                {
                    this.MensajeError("Falta ingresar algunos datos, serán remarcados");
                }
                else
                {
                    string formaPago = CboFormadePago.Text.Trim();
                    string cuota = CboCuota.Text.Trim();
                    string moneda = CboMoneda.Text.Trim();
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
                DgvMostrarDetalle.DataSource = NVenta.ListarDetalle(Convert.ToInt32(DgvListado.CurrentRow.Cells["ID"].Value));
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
                }
                
                // Formatear columna CANTIDAD
                if (DgvMostrarDetalle.Columns["CANTIDAD"] != null)
                {
                    DgvMostrarDetalle.Columns["CANTIDAD"].Width = 80;
                    DgvMostrarDetalle.Columns["CANTIDAD"].ReadOnly = true;
                }
                
                // Formatear columna PRECIO
                if (DgvMostrarDetalle.Columns["PRECIO"] != null)
                {
                    DgvMostrarDetalle.Columns["PRECIO"].Width = 80;
                    DgvMostrarDetalle.Columns["PRECIO"].DefaultCellStyle.Format = "N2";
                    DgvMostrarDetalle.Columns["PRECIO"].ReadOnly = true;
                }
                
                // Formatear columna DESCUENTO
                if (DgvMostrarDetalle.Columns["DESCUENTO"] != null)
                {
                    DgvMostrarDetalle.Columns["DESCUENTO"].Width = 80;
                    DgvMostrarDetalle.Columns["DESCUENTO"].DefaultCellStyle.Format = "N2";
                    DgvMostrarDetalle.Columns["DESCUENTO"].ReadOnly = true;
                }
                
                // Formatear columna IMPORTE
                if (DgvMostrarDetalle.Columns["IMPORTE"] != null)
                {
                    DgvMostrarDetalle.Columns["IMPORTE"].Width = 100;
                    DgvMostrarDetalle.Columns["IMPORTE"].DefaultCellStyle.Format = "N2";
                    DgvMostrarDetalle.Columns["IMPORTE"].ReadOnly = true;
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
    }
}
