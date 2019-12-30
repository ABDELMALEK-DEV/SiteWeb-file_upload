<%@ Page Title="" Language="C#" MasterPageFile="~/Master_teacher.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    SqlConnection conx = new SqlConnection(@"data source=ABDELMALEK-PC\SQLEXPRESS;database=file_host;integrated security=true");

    protected void Page_Load(object sender, EventArgs e)
    {
        //conx.Open();
        //Response.Write(conx.State.ToString());

        //conx.Close();
        

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string sql = "insert into courses values (@id,@name)";
        SqlCommand cmd = new SqlCommand(sql, conx);
        cmd.Parameters.AddWithValue("@id", TextBox1.Text);
        cmd.Parameters.AddWithValue("@name", TextBox2.Text);
        conx.Open();
        cmd.ExecuteNonQuery();
        conx.Close();
        Label1.Text = "تمت عملية الإضافة";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .auto-style3 {
        width: 100%;
    }
    .auto-style4 {
        width: 419px;
    }
    .auto-style5 {
        width: 568px;
    }
        .auto-style6 {
            text-align: center;
        }
        .auto-style7 {
            font-size: x-large;
        }
        .auto-style8 {
            width: 568px;
            text-align: right;
        }
        .auto-style9 {
            width: 568px;
            text-align: right;
            height: 31px;
        }
        .auto-style10 {
            text-align: center;
            height: 31px;
        }
        .auto-style11 {
            width: 568px;
            height: 23px;
        }
        .auto-style12 {
            height: 23px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="auto-style3">
    <tr>
        <td class="auto-style8">
            <asp:TextBox ID="TextBox1" runat="server" Width="147px"></asp:TextBox>
        </td>
        <td class="auto-style6">
            <asp:Label ID="Label1" runat="server" CssClass="auto-style7" Text="رقم المقرر "></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="auto-style9">
            <asp:TextBox ID="TextBox2" runat="server" Width="147px"></asp:TextBox>
        </td>
        <td class="auto-style10">
            <asp:Label ID="Label2" runat="server" CssClass="auto-style7" Text="اسم المقرر "></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="auto-style11">&nbsp;</td>
        <td class="auto-style12">
            <asp:Label ID="Label3" runat="server" style="text-align: center"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="auto-style5">&nbsp;</td>
        <td>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" style="text-align: right" Text="إضافة المقرر " />
        </td>
    </tr>
    <tr>
        <td class="auto-style5">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>
</asp:Content>

