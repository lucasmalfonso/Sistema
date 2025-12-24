using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Sistema.Negocio;

namespace Sistema.Presentacion
{
    public partial class FrmConsulta_VentaFechas : Form
    {
        public FrmConsulta_VentaFechas()
        {
            InitializeComponent();
        }
        private void Buscar()
        {
            try
            {
                string formaPago = CboFormaPagoConsulta.SelectedIndex >= 0 ? CboFormaPagoConsulta.Text : "TODAS";
                string moneda = CboMonedaConsulta.SelectedIndex >= 0 ? CboMonedaConsulta.Text : "TODAS";
                
                DgvListado.DataSource = NVenta.ConsultaFechas(Convert.ToDateTime(DtpFechaInicio.Value), Convert.ToDateTime(DtpFechaFin.Value), formaPago, moneda);
                this.Formato();
                this.Limpiar();
                LblTotal.Text = "Total Registros: " + Convert.ToString(DgvListado.Rows.Count);
                
                // Calcular totales en Pesos y Dólares
                decimal totalPesos = 0;
                decimal totalDolares = 0;
                
                foreach (DataGridViewRow row in DgvListado.Rows)
                {
                    if (row.Cells["Total"].Value != null && row.Cells["Moneda"].Value != null)
                    {
                        decimal total = Convert.ToDecimal(row.Cells["Total"].Value);
                        string monedaVenta = row.Cells["Moneda"].Value.ToString();
                        
                        if (monedaVenta == "PESOS")
                        {
                            totalPesos += total;
                        }
                        else if (monedaVenta == "DOLARES")
                        {
                            totalDolares += total;
                        }
                    }
                }
                
                LblPesos.Text = "Pesos: $" + totalPesos.ToString("N2");
                LblDolares.Text = "Dolares: $" + totalDolares.ToString("N2");
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
            DgvListado.Columns[0].Visible = false;
        }
        private void MensajeError(string mensaje)
        {
            MessageBox.Show(mensaje, "Sistema de Ventas", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
        private void MensajeOk(string mensaje)
        {
            MessageBox.Show(mensaje, "Sistema de Ventas", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
        private void FrmConsulta_VentaFechas_Load(object sender, EventArgs e)
        {

        }

        private void BtnBuscar_Click(object sender, EventArgs e)
        {
            this.Buscar();
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

        private void BtnCerrarDetalle_Click(object sender, EventArgs e)
        {
            PanelMostrar.Visible=false;
        }
    }
}
