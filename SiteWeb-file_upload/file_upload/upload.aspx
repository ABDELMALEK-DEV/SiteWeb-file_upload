<%@ Page Title="" Language="C#" MasterPageFile="~/Master_teacher.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">
    SqlConnection conx = new SqlConnection(@"data source=ABDELMALEK-PC\SQLEXPRESS;database=file_host;integrated security=true");

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("~\\enter");
        }
        if (!Page.IsPostBack)
        {
            string sql = "select * from courses";
            SqlDataAdapter dr = new SqlDataAdapter(sql, conx);
            DataTable dt = new DataTable();
            dr.Fill(dt);
            DropDownList1.DataSource = dt;
            DropDownList1.DataTextField = "course_name";
            DropDownList1.DataValueField = "course_id";
            DropDownList1.DataBind();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            string ex = System.IO.Path.GetExtension(FileUpload1.FileName);
            if (ex != ".pdf" && ex != ".mp4" && ex != ".pptx" && ex != ".docx")
            {
                Label1.Text = "هذا النوع من الملفات غير مسموح";
                return;
                
            } 
            string file_name = "";
            file_name = file_name + Session["user"].ToString() + "_";
            file_name = file_name + DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString();
            file_name += DateTime.Now.Hour.ToString();
            file_name += DateTime.Now.Minute.ToString();
            file_name += DateTime.Now.Second.ToString();
            FileUpload1.SaveAs(Server.MapPath("files") + "\\" + file_name + ex);
            string path = "\\files\\" + file_name + ex;

            string sql = "insert into files (title, upload_date , course, user_id, path, downloads) values (@title,@upload_date,@course,@user_id, @path, @downloads)";
            SqlCommand cmd = new SqlCommand(sql, conx);
            cmd.Parameters.AddWithValue("@title", TextBox1.Text);
            cmd.Parameters.AddWithValue("@upload_date", DateTime.Now);
            cmd.Parameters.AddWithValue("@course", DropDownList1.SelectedValue);
            cmd.Parameters.AddWithValue("@user_id", Session["user"].ToString());
            cmd.Parameters.AddWithValue("@path", path);
            cmd.Parameters.AddWithValue("@downloads", 0);
            conx.Open();
            cmd.ExecuteNonQuery();
            conx.Close();
            Label4.Text = "تمت عملية الإضافة";
        }
        else
        {
            Label4.Text = "يرجى إختيار الملف المراد رفعه";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style3 {
            width: 100%;
            border-collapse: collapse;
        }
        .auto-style4 {
            width: 358px;
        }
        .auto-style5 {
            width: 588px;
        }
        .auto-style6 {
            width: 588px;
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="auto-style3">
        <tr>
            <td class="auto-style6">
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="Label1" runat="server" Text="وصف الملف"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style6">
                <asp:DropDownList ID="DropDownList1" runat="server">
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label ID="Label2" runat="server" Text="اسم المقرر"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style6">
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </td>
            <td>
                <asp:Label ID="Label3" runat="server" Text="مكان الملف"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>
                <asp:Label ID="Label4" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>
                <asp:Button ID="Button1" runat="server" Text="رفع الملف" OnClick="Button1_Click" />
            </td>
        </tr>
    </table>
</asp:Content>

