<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Admin.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">
    SqlConnection conx = new SqlConnection(@"data source=ABDELMALEK-PC\SQLEXPRESS;database=file_host;integrated security=true");


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Random rnd = new Random();
        TextBox3.Text = rnd.Next(1000, 1000000).ToString();
        

        string sql = "insert into users (users_name, email , pass, user_type) values (@name,@email,@pass,@type)";
        SqlCommand cmd = new SqlCommand(sql, conx);
        cmd.Parameters.AddWithValue("@name", TextBox1.Text);
        cmd.Parameters.AddWithValue("@email", TextBox2.Text);
        cmd.Parameters.AddWithValue("@pass", TextBox3.Text);
        cmd.Parameters.AddWithValue("@type", DropDownList1.SelectedValue);
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
            width: 350px;
        }
        .auto-style5 {
            width: 582px;
        text-align: right;
    }
        .auto-style6 {
            width: 582px;
            text-align: right;
        }
        .auto-style7 {
            width: 582px;
            text-align: right;
            height: 26px;
        }
        .auto-style8 {
            height: 26px;
        }
        .auto-style9 {
            width: 582px;
            text-align: right;
            height: 30px;
        }
        .auto-style10 {
            height: 30px;
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
                <asp:Label ID="Label1" runat="server" style="text-align: right" Text="إسم المستخدم"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style6">
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="Label2" runat="server" Text="البريد الإلكتروني"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style8">
                <asp:Label ID="Label3" runat="server" Text="كلمة المرور"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">
                <asp:DropDownList ID="DropDownList1" runat="server" Height="16px" Width="118px">
                    <asp:ListItem Value="1">الطالب</asp:ListItem>
                    <asp:ListItem Value="2">المعلم</asp:ListItem>
                    <asp:ListItem Value="3">مشرف الموقع</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label ID="Label4" runat="server" Text="نوع المستخدم"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style6">
                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9"></td>
            <td class="auto-style10">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="حفظ المستخدم" />
            </td>
        </tr>
    </table>
</asp:Content>

