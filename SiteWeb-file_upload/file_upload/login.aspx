<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>


<!DOCTYPE html>

<script runat="server">
    SqlConnection conx = new SqlConnection(@"data source=ABDELMALEK-PC\SQLEXPRESS;database=file_host;integrated security=true");


    protected void Button1_Click(object sender, EventArgs e)
    {

        string sql = " select * from users where email=@email and pass=@pass";
        SqlCommand cmd = new SqlCommand(sql, conx);
        cmd.Parameters.AddWithValue("@email", TextBox1.Text);
        cmd.Parameters.AddWithValue("@pass", TextBox2.Text);
        SqlDataReader dr;
        conx.Open();
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            string users_typ = "";
            while (dr.Read())
            {
                Session["user"] = dr["users_id"].ToString();
                users_typ = dr["users_typ"].ToString();
            }
             
             if (users_typ == "2")
             {
                 Response.Redirect("upload.aspx")
             } 
       
        }
        else {
             Label1.Text = "خطاء في الدخول ";
        }
       conx.Close();
       
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 500px;
            border-collapse: collapse;
        }
        .auto-style2 {
            width: 364px;
            text-align: right;
        }
        .auto-style3 {
            width: 364px;
            height: 21px;
            text-align: right;
        }
        .auto-style4 {
            height: 21px;
            text-align: right;
        }
        .auto-style5 {
            width: 364px;
            text-align: right;
        }
        .auto-style6 {
            text-align: right;
        }
    </style>
</head>
<body style="margin-top:0px;margin-right:0px;margin-left:0px">
    <form id="form1" runat="server">
    <div style="width:100%;height:120px;background-color:#ede7e7; text-align: center;">
    


        <asp:Image ID="Image1" runat="server" Height="114px" ImageUrl="~/images/logo.png" Width="780px" />



    </div>
        <table align="center" class="auto-style1">
            <tr>
                <td class="auto-style3">
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style4">
                    <asp:Label ID="Label1" runat="server" Text="البريد الإلكتروني"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style5">
                    <asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>
                </td>
                <td class="auto-style6">
                    <asp:Label ID="Label2" runat="server" Text="كلمة المرور"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td>
                    <asp:Label ID="Label3" runat="server" style="text-align: right"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Button ID="Button1" runat="server" Text="دخول" OnClick="Button1_Click" style="text-align: right" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
