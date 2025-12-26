namespace Sistema.Presentacion
{
    partial class FrmConsulta_VentaFechas
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
            this.DgvMostrarDetalle = new System.Windows.Forms.DataGridView();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.LblDolares = new System.Windows.Forms.Label();
            this.LblPesos = new System.Windows.Forms.Label();
            this.CboMonedaConsulta = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.CboFormaPagoConsulta = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.DtpFechaFin = new System.Windows.Forms.DateTimePicker();
            this.DtpFechaInicio = new System.Windows.Forms.DateTimePicker();
            this.BtnComprobante = new System.Windows.Forms.Button();
            this.PanelMostrar = new System.Windows.Forms.Panel();
            this.label5 = new System.Windows.Forms.Label();
            this.TxtTotalD = new System.Windows.Forms.TextBox();
            this.label14 = new System.Windows.Forms.Label();
            this.BtnCerrarDetalle = new System.Windows.Forms.Button();
            this.BtnBuscar = new System.Windows.Forms.Button();
            this.LblTotal = new System.Windows.Forms.Label();
            this.DgvListado = new System.Windows.Forms.DataGridView();
            this.Seleccionar = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.TabGeneral = new System.Windows.Forms.TabControl();
            this.ErrorIcono = new System.Windows.Forms.ErrorProvider(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.DgvMostrarDetalle)).BeginInit();
            this.tabPage1.SuspendLayout();
            this.PanelMostrar.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.DgvListado)).BeginInit();
            this.TabGeneral.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ErrorIcono)).BeginInit();
            this.SuspendLayout();
            // 
            // DgvMostrarDetalle
            // 
            this.DgvMostrarDetalle.AllowUserToAddRows = false;
            this.DgvMostrarDetalle.AllowUserToDeleteRows = false;
            this.DgvMostrarDetalle.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DgvMostrarDetalle.Location = new System.Drawing.Point(26, 51);
            this.DgvMostrarDetalle.Name = "DgvMostrarDetalle";
            this.DgvMostrarDetalle.ReadOnly = true;
            this.DgvMostrarDetalle.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.DgvMostrarDetalle.Size = new System.Drawing.Size(894, 275);
            this.DgvMostrarDetalle.TabIndex = 0;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.LblDolares);
            this.tabPage1.Controls.Add(this.LblPesos);
            this.tabPage1.Controls.Add(this.CboMonedaConsulta);
            this.tabPage1.Controls.Add(this.label4);
            this.tabPage1.Controls.Add(this.CboFormaPagoConsulta);
            this.tabPage1.Controls.Add(this.label3);
            this.tabPage1.Controls.Add(this.label2);
            this.tabPage1.Controls.Add(this.label1);
            this.tabPage1.Controls.Add(this.DtpFechaFin);
            this.tabPage1.Controls.Add(this.DtpFechaInicio);
            this.tabPage1.Controls.Add(this.BtnComprobante);
            this.tabPage1.Controls.Add(this.PanelMostrar);
            this.tabPage1.Controls.Add(this.BtnBuscar);
            this.tabPage1.Controls.Add(this.LblTotal);
            this.tabPage1.Controls.Add(this.DgvListado);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(1342, 633);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Listado";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // LblDolares
            // 
            this.LblDolares.AutoSize = true;
            this.LblDolares.Location = new System.Drawing.Point(898, 531);
            this.LblDolares.Name = "LblDolares";
            this.LblDolares.Size = new System.Drawing.Size(46, 13);
            this.LblDolares.TabIndex = 18;
            this.LblDolares.Text = "Dolares:";
            // 
            // LblPesos
            // 
            this.LblPesos.AutoSize = true;
            this.LblPesos.Location = new System.Drawing.Point(898, 497);
            this.LblPesos.Name = "LblPesos";
            this.LblPesos.Size = new System.Drawing.Size(39, 13);
            this.LblPesos.TabIndex = 17;
            this.LblPesos.Text = "Pesos:";
            // 
            // CboMonedaConsulta
            // 
            this.CboMonedaConsulta.FormattingEnabled = true;
            this.CboMonedaConsulta.Items.AddRange(new object[] {
            "TODAS",
            "PESOS",
            "DOLARES"});
            this.CboMonedaConsulta.Location = new System.Drawing.Point(658, 8);
            this.CboMonedaConsulta.Name = "CboMonedaConsulta";
            this.CboMonedaConsulta.Size = new System.Drawing.Size(121, 21);
            this.CboMonedaConsulta.TabIndex = 16;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(605, 12);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(46, 13);
            this.label4.TabIndex = 15;
            this.label4.Text = "Moneda";
            // 
            // CboFormaPagoConsulta
            // 
            this.CboFormaPagoConsulta.FormattingEnabled = true;
            this.CboFormaPagoConsulta.Items.AddRange(new object[] {
            "TODAS",
            "EFECTIVO",
            "TRANSFERENCIA",
            "MERCADO PAGO",
            "TARJETA DE CREDITO",
            "TARJETA DE DEBITO"});
            this.CboFormaPagoConsulta.Location = new System.Drawing.Point(467, 9);
            this.CboFormaPagoConsulta.Name = "CboFormaPagoConsulta";
            this.CboFormaPagoConsulta.Size = new System.Drawing.Size(121, 21);
            this.CboFormaPagoConsulta.TabIndex = 14;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(381, 12);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(79, 13);
            this.label3.TabIndex = 13;
            this.label3.Text = "Forma de Pago";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(221, 12);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(35, 13);
            this.label2.TabIndex = 12;
            this.label2.Text = "Hasta";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(60, 12);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(38, 13);
            this.label1.TabIndex = 11;
            this.label1.Text = "Desde";
            // 
            // DtpFechaFin
            // 
            this.DtpFechaFin.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.DtpFechaFin.Location = new System.Drawing.Point(262, 11);
            this.DtpFechaFin.Name = "DtpFechaFin";
            this.DtpFechaFin.Size = new System.Drawing.Size(98, 20);
            this.DtpFechaFin.TabIndex = 10;
            // 
            // DtpFechaInicio
            // 
            this.DtpFechaInicio.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.DtpFechaInicio.Location = new System.Drawing.Point(104, 11);
            this.DtpFechaInicio.Name = "DtpFechaInicio";
            this.DtpFechaInicio.Size = new System.Drawing.Size(101, 20);
            this.DtpFechaInicio.TabIndex = 9;
            // 
            // BtnComprobante
            // 
            this.BtnComprobante.Location = new System.Drawing.Point(1026, 7);
            this.BtnComprobante.Name = "BtnComprobante";
            this.BtnComprobante.Size = new System.Drawing.Size(117, 23);
            this.BtnComprobante.TabIndex = 8;
            this.BtnComprobante.Text = "Comprobante";
            this.BtnComprobante.UseVisualStyleBackColor = true;
            this.BtnComprobante.Click += new System.EventHandler(this.BtnComprobante_Click);
            // 
            // PanelMostrar
            // 
            this.PanelMostrar.BackColor = System.Drawing.Color.Moccasin;
            this.PanelMostrar.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.PanelMostrar.Controls.Add(this.label5);
            this.PanelMostrar.Controls.Add(this.TxtTotalD);
            this.PanelMostrar.Controls.Add(this.label14);
            this.PanelMostrar.Controls.Add(this.BtnCerrarDetalle);
            this.PanelMostrar.Controls.Add(this.DgvMostrarDetalle);
            this.PanelMostrar.ForeColor = System.Drawing.SystemColors.ControlDarkDark;
            this.PanelMostrar.Location = new System.Drawing.Point(63, 68);
            this.PanelMostrar.Name = "PanelMostrar";
            this.PanelMostrar.Size = new System.Drawing.Size(941, 394);
            this.PanelMostrar.TabIndex = 7;
            this.PanelMostrar.Visible = false;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(26, 13);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(86, 13);
            this.label5.TabIndex = 8;
            this.label5.Text = "Detalle de Venta";
            // 
            // TxtTotalD
            // 
            this.TxtTotalD.Enabled = false;
            this.TxtTotalD.Location = new System.Drawing.Point(779, 352);
            this.TxtTotalD.Name = "TxtTotalD";
            this.TxtTotalD.Size = new System.Drawing.Size(100, 20);
            this.TxtTotalD.TabIndex = 7;
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Location = new System.Drawing.Point(695, 355);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(31, 13);
            this.label14.TabIndex = 4;
            this.label14.Text = "Total";
            // 
            // BtnCerrarDetalle
            // 
            this.BtnCerrarDetalle.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.BtnCerrarDetalle.ForeColor = System.Drawing.Color.Red;
            this.BtnCerrarDetalle.Location = new System.Drawing.Point(889, 13);
            this.BtnCerrarDetalle.Name = "BtnCerrarDetalle";
            this.BtnCerrarDetalle.Size = new System.Drawing.Size(31, 23);
            this.BtnCerrarDetalle.TabIndex = 1;
            this.BtnCerrarDetalle.Text = "X";
            this.BtnCerrarDetalle.UseVisualStyleBackColor = true;
            this.BtnCerrarDetalle.Click += new System.EventHandler(this.BtnCerrarDetalle_Click);
            // 
            // BtnBuscar
            // 
            this.BtnBuscar.BackColor = System.Drawing.Color.Transparent;
            this.BtnBuscar.Location = new System.Drawing.Point(823, 7);
            this.BtnBuscar.Name = "BtnBuscar";
            this.BtnBuscar.Size = new System.Drawing.Size(127, 23);
            this.BtnBuscar.TabIndex = 3;
            this.BtnBuscar.Text = "Buscar";
            this.BtnBuscar.UseVisualStyleBackColor = false;
            this.BtnBuscar.Click += new System.EventHandler(this.BtnBuscar_Click);
            // 
            // LblTotal
            // 
            this.LblTotal.AutoSize = true;
            this.LblTotal.Location = new System.Drawing.Point(898, 465);
            this.LblTotal.Name = "LblTotal";
            this.LblTotal.Size = new System.Drawing.Size(34, 13);
            this.LblTotal.TabIndex = 1;
            this.LblTotal.Text = "Total:";
            // 
            // DgvListado
            // 
            this.DgvListado.AllowUserToAddRows = false;
            this.DgvListado.AllowUserToDeleteRows = false;
            this.DgvListado.AllowUserToOrderColumns = true;
            this.DgvListado.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DgvListado.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Seleccionar});
            this.DgvListado.Location = new System.Drawing.Point(16, 41);
            this.DgvListado.Name = "DgvListado";
            this.DgvListado.ReadOnly = true;
            this.DgvListado.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.DgvListado.Size = new System.Drawing.Size(1310, 399);
            this.DgvListado.TabIndex = 0;
            this.DgvListado.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.DgvListado_CellDoubleClick);
            // 
            // Seleccionar
            // 
            this.Seleccionar.HeaderText = "Seleccionar";
            this.Seleccionar.Name = "Seleccionar";
            this.Seleccionar.ReadOnly = true;
            // 
            // TabGeneral
            // 
            this.TabGeneral.Controls.Add(this.tabPage1);
            this.TabGeneral.Location = new System.Drawing.Point(12, 12);
            this.TabGeneral.Name = "TabGeneral";
            this.TabGeneral.SelectedIndex = 0;
            this.TabGeneral.Size = new System.Drawing.Size(1350, 659);
            this.TabGeneral.TabIndex = 3;
            // 
            // ErrorIcono
            // 
            this.ErrorIcono.ContainerControl = this;
            // 
            // FrmConsulta_VentaFechas
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1374, 676);
            this.Controls.Add(this.TabGeneral);
            this.Name = "FrmConsulta_VentaFechas";
            this.Text = "Consulta de ventas entre fechas";
            this.Load += new System.EventHandler(this.FrmConsulta_VentaFechas_Load);
            ((System.ComponentModel.ISupportInitialize)(this.DgvMostrarDetalle)).EndInit();
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            this.PanelMostrar.ResumeLayout(false);
            this.PanelMostrar.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.DgvListado)).EndInit();
            this.TabGeneral.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ErrorIcono)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView DgvMostrarDetalle;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DateTimePicker DtpFechaFin;
        private System.Windows.Forms.DateTimePicker DtpFechaInicio;
        private System.Windows.Forms.Button BtnComprobante;
        private System.Windows.Forms.Panel PanelMostrar;
        private System.Windows.Forms.TextBox TxtTotalD;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.Button BtnCerrarDetalle;
        private System.Windows.Forms.Button BtnBuscar;
        private System.Windows.Forms.Label LblTotal;
        private System.Windows.Forms.DataGridView DgvListado;
        private System.Windows.Forms.DataGridViewCheckBoxColumn Seleccionar;
        private System.Windows.Forms.TabControl TabGeneral;
        private System.Windows.Forms.ErrorProvider ErrorIcono;
        private System.Windows.Forms.ComboBox CboMonedaConsulta;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox CboFormaPagoConsulta;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label LblDolares;
        private System.Windows.Forms.Label LblPesos;
        private System.Windows.Forms.Label label5;
    }
}