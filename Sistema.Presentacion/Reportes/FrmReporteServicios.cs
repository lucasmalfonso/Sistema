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
using Microsoft.Reporting.WinForms;

namespace Sistema.Presentacion.Reportes
{
    public partial class FrmReporteServicios : Form
    {
        public FrmReporteServicios()
        {
            InitializeComponent();
        }

        private void FrmReporteServicios_Load(object sender, EventArgs e)
        {
            try
            {
                // Cargar datos de servicios
                DataTable dtServicios = NServicio.Listar();
                
                // Configurar el reporte
                ReportDataSource rds = new ReportDataSource("DtsServicio", dtServicios);
                this.reportViewer1.LocalReport.DataSources.Clear();
                this.reportViewer1.LocalReport.DataSources.Add(rds);
                this.reportViewer1.LocalReport.ReportEmbeddedResource = "Sistema.Presentacion.Reportes.RptServicios.rdlc";
                this.reportViewer1.RefreshReport();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar el reporte: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void reportViewer1_Load(object sender, EventArgs e)
        {

        }
    }
}





