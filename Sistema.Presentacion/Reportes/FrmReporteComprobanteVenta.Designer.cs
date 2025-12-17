namespace Sistema.Presentacion.Reportes
{
    partial class FrmReporteComprobanteVenta
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource1 = new Microsoft.Reporting.WinForms.ReportDataSource();
            this.ventacomprobanteBindingSource6 = new System.Windows.Forms.BindingSource(this.components);
            this.dsSistemaBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.dsSistema = new Sistema.Presentacion.Reportes.DsSistema();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.ventacomprobanteBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.venta_comprobanteTableAdapter = new Sistema.Presentacion.Reportes.DsSistemaTableAdapters.venta_comprobanteTableAdapter();
            this.ventacomprobanteBindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.ventacomprobanteBindingSource2 = new System.Windows.Forms.BindingSource(this.components);
            this.ventacomprobanteBindingSource3 = new System.Windows.Forms.BindingSource(this.components);
            this.ventacomprobanteBindingSource4 = new System.Windows.Forms.BindingSource(this.components);
            this.ventacomprobanteBindingSource5 = new System.Windows.Forms.BindingSource(this.components);
            this.articulolistarBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.articulo_listarTableAdapter = new Sistema.Presentacion.Reportes.DsSistemaTableAdapters.articulo_listarTableAdapter();
            this.articulolistarBindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.articulo_listarBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.venta_comprobanteBindingSource = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource6)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dsSistemaBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dsSistema)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.articulolistarBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.articulolistarBindingSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.articulo_listarBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.venta_comprobanteBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // ventacomprobanteBindingSource6
            // 
            this.ventacomprobanteBindingSource6.DataMember = "venta_comprobante";
            this.ventacomprobanteBindingSource6.DataSource = this.dsSistemaBindingSource;
            // 
            // dsSistemaBindingSource
            // 
            this.dsSistemaBindingSource.DataSource = this.dsSistema;
            this.dsSistemaBindingSource.Position = 0;
            // 
            // dsSistema
            // 
            this.dsSistema.DataSetName = "DsSistema";
            this.dsSistema.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // reportViewer1
            // 
            this.reportViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            reportDataSource1.Name = "DsComprobanteVenta";
            reportDataSource1.Value = this.venta_comprobanteBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "Sistema.Presentacion.Reportes.RptComprobanteVenta.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.ServerReport.BearerToken = null;
            this.reportViewer1.Size = new System.Drawing.Size(1203, 652);
            this.reportViewer1.TabIndex = 0;
            this.reportViewer1.Load += new System.EventHandler(this.reportViewer1_Load);
            // 
            // ventacomprobanteBindingSource
            // 
            this.ventacomprobanteBindingSource.DataMember = "venta_comprobante";
            this.ventacomprobanteBindingSource.DataSource = this.dsSistemaBindingSource;
            // 
            // venta_comprobanteTableAdapter
            // 
            this.venta_comprobanteTableAdapter.ClearBeforeFill = true;
            // 
            // ventacomprobanteBindingSource1
            // 
            this.ventacomprobanteBindingSource1.DataMember = "venta_comprobante";
            this.ventacomprobanteBindingSource1.DataSource = this.dsSistemaBindingSource;
            // 
            // ventacomprobanteBindingSource2
            // 
            this.ventacomprobanteBindingSource2.DataMember = "venta_comprobante";
            this.ventacomprobanteBindingSource2.DataSource = this.dsSistema;
            // 
            // ventacomprobanteBindingSource3
            // 
            this.ventacomprobanteBindingSource3.DataMember = "venta_comprobante";
            this.ventacomprobanteBindingSource3.DataSource = this.dsSistemaBindingSource;
            // 
            // ventacomprobanteBindingSource4
            // 
            this.ventacomprobanteBindingSource4.DataMember = "venta_comprobante";
            this.ventacomprobanteBindingSource4.DataSource = this.dsSistemaBindingSource;
            // 
            // ventacomprobanteBindingSource5
            // 
            this.ventacomprobanteBindingSource5.DataMember = "venta_comprobante";
            this.ventacomprobanteBindingSource5.DataSource = this.dsSistemaBindingSource;
            // 
            // articulolistarBindingSource
            // 
            this.articulolistarBindingSource.DataMember = "articulo_listar";
            this.articulolistarBindingSource.DataSource = this.dsSistemaBindingSource;
            // 
            // articulo_listarTableAdapter
            // 
            this.articulo_listarTableAdapter.ClearBeforeFill = true;
            // 
            // articulolistarBindingSource1
            // 
            this.articulolistarBindingSource1.DataMember = "articulo_listar";
            this.articulolistarBindingSource1.DataSource = this.dsSistemaBindingSource;
            // 
            // articulo_listarBindingSource
            // 
            this.articulo_listarBindingSource.DataMember = "articulo_listar";
            this.articulo_listarBindingSource.DataSource = this.dsSistema;
            // 
            // venta_comprobanteBindingSource
            // 
            this.venta_comprobanteBindingSource.DataMember = "venta_comprobante";
            this.venta_comprobanteBindingSource.DataSource = this.dsSistema;
            // 
            // FrmReporteComprobanteVenta
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1203, 652);
            this.Controls.Add(this.reportViewer1);
            this.Name = "FrmReporteComprobanteVenta";
            this.Text = "Reporte Comprobante Venta";
            this.Load += new System.EventHandler(this.FrmReporteComprobanteVenta_Load);
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource6)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dsSistemaBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dsSistema)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ventacomprobanteBindingSource5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.articulolistarBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.articulolistarBindingSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.articulo_listarBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.venta_comprobanteBindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource dsSistemaBindingSource;
        private DsSistema dsSistema;
        private System.Windows.Forms.BindingSource ventacomprobanteBindingSource;
        private DsSistemaTableAdapters.venta_comprobanteTableAdapter venta_comprobanteTableAdapter;
        private System.Windows.Forms.BindingSource ventacomprobanteBindingSource1;
        private System.Windows.Forms.BindingSource ventacomprobanteBindingSource2;
        private System.Windows.Forms.BindingSource ventacomprobanteBindingSource4;
        private System.Windows.Forms.BindingSource ventacomprobanteBindingSource3;
        private System.Windows.Forms.BindingSource ventacomprobanteBindingSource5;
        private System.Windows.Forms.BindingSource articulolistarBindingSource;
        private DsSistemaTableAdapters.articulo_listarTableAdapter articulo_listarTableAdapter;
        private System.Windows.Forms.BindingSource ventacomprobanteBindingSource6;
        private System.Windows.Forms.BindingSource articulolistarBindingSource1;
        private System.Windows.Forms.BindingSource articulo_listarBindingSource;
        private System.Windows.Forms.BindingSource venta_comprobanteBindingSource;
    }
}