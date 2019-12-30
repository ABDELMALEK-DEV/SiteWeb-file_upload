<%@ Page Title="" Language="C#" MasterPageFile="~/Master_student.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">
    SqlConnection conx = new SqlConnection(@"data source=ABDELMALEK-PC\SQLEXPRESS;database=file_host;integrated security=true");

    void fill_files()
    {
        string sql = " select *,(select course_name from courses where course_id=files.course_id) as course_name from files order by upload_date desc";
        SqlDataAdapter dr = new SqlDataAdapter(sql, conx);
        DataTable dt = new DataTable();
        dr.Fill(dt);
        GridView1.DataSource = dt;
        GridView1.DataBind();

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            fill_files();
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "down")
        {
            int j = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[j];
            Label file = (Label)row.FindControl("label1");
            string sql = "";
            sql = "update files set downloads=downloads+1 where file_id=@file";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@file", row.Cells[0].Text);
            conx.Open();
            cmd.ExecuteNonQuery();
            conx.Close();
            Response.Clear();
            Response.AddHeader("content-disponsition", "attachment; filename=" + file.Text);
            Response.ContentType = "application/octet-stream";
            Response.WriteFile(file.Text);
            Response.Clear();
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        fill_files();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label file = (Label)e.Row.FindControl("Label1");
            System.IO.FileInfo y = new System.IO.FileInfo(Server.MapPath("\\") + file.Text.Replace("~" , ""));
            decimal size = Convert.ToDecimal(y.Length / 1024);
            e.Row.Cells[5].Text = size.ToString("f3");
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style3 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="auto-style3">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="file_id" HeaderText="رقم الملف" />
                        <asp:BoundField DataField="title" HeaderText="وصف الملف">
                        <ItemStyle Width="220px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="upload_date" HeaderText="تاريخ الملف" DataFormatString="{0:yyyy/MM/dd}" />
                        <asp:BoundField DataField="course_name" HeaderText="اسم المقرر" />
                        <asp:TemplateField HeaderText="مسار الملف" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("path") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="حجم الملف" />
                        <asp:ButtonField ButtonType="Button" CommandName="dowan" Text="تحميل " />
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>

