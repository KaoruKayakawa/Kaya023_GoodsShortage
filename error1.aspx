<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="error1.aspx.vb" Inherits="Kaya023_GoodsShortage.error1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    
    <asp:PlaceHolder ID="PlaceHolder1" runat="server">
        <%: System.Web.Optimization.Styles.Render("~/Styles/CSS") %>
        <%: System.Web.Optimization.Scripts.Render("~/Scripts/JS") %>
    </asp:PlaceHolder>
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding-bottom: 25px; border-bottom: 2px solid gray; margin-bottom: 20px;">
            <h2 style="color: white; background-color: indianred; width: 100%; border-width: 2px; border-style: solid none; border-color: lightgray;">&nbsp;&nbsp;エラー</h2>

            <asp:MultiView ID="mv1" runat="server">
                <asp:View ID="v1_1" runat="server">
                    &nbsp;&nbsp;<asp:Label ID="lbl_errMsg" runat="server" Font-Size="1.2em" Font-Bold="true" ForeColor="DimGray" />
                </asp:View>
                <asp:View ID="v1_2" runat="server">
                    &nbsp;&nbsp;<span style="font-size: 1.2em; font-weight: bold; color: dimgray;">アプリケーションで、障害が発生しました。</span>
                </asp:View>
            </asp:MultiView>
        </div>

        <asp:MultiView ID="mv2" runat="server">
            <asp:View ID="v2_1" runat="server">
                &nbsp;&nbsp;<asp:HyperLink ID="hlk_toPage" runat="server">処理を新規に再開する</asp:HyperLink>
            </asp:View>
            <asp:View ID="v2_2" runat="server">
                &nbsp;&nbsp;ご迷惑をお掛けしております。
                <br />
                &nbsp;&nbsp;最初から操作をやり直してみてください。
                <br />
                <br />
                &nbsp;&nbsp;再度このメッセージが出るようでしたら、システム部までご連絡願います。
            </asp:View>
        </asp:MultiView>
    </form>
</body>
</html>
