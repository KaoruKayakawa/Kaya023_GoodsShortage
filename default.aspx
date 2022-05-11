<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="Kaya023_GoodsShortage._default" %>

<%@ Register src="~/UserControl/ListPager.ascx" tagname="ListPager" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="ja">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    
    <asp:PlaceHolder ID="PlaceHolder1" runat="server">
        <%: System.Web.Optimization.Styles.Render("~/Styles/CSS") %>
        <%: System.Web.Optimization.Scripts.Render("~/Scripts/JS") %>
    </asp:PlaceHolder>
</head>
<body onload="history.forward();" onresize="adjust_divListHeight();">
    <form id="form1" runat="server">
		<asp:Button ID="btn_dummy" runat="server" UseSubmitBehavior="false" Text="dummy" OnClientClick="return false;" Style="display: none;" />
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true" AsyncPostBackTimeout="200"></asp:ScriptManager>

        <table id="tbl_01" style="width: 100%;">
            <colgroup>
                <col style="width: 100%;" />
            </colgroup>
            <tr>
                <td style="background-color: linen; border: solid 2px rosybrown; padding: 2px;">
                    <table style="background-color: rosybrown; color: white; width: 100%;">
                        <colgroup>
                            <col id="hgc_col1" runat="server" />
                            <col />
                            <col style="width: 20em;" />
                        </colgroup>
                        <tr>
                            <td style="text-align: right; padding-right: 10px; font-size: 13px; font-weight: bold;">
                                <asp:LinkButton ID="lbtn_toMenu" runat="server" ForeColor="paleturquoise" Text="MENU　&gt;" />
                            </td>
                            <td style="padding: 2px 20px; font-size: 17px; font-weight: bold;">
                                <asp:Literal ID="lrl_capWnd" runat="server" />
                            </td>
                            <td style="text-align: right; padding-right: 20px; font-size: 11px;">Ver： <asp:Literal ID="lrl_version" runat="server" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 10px;"><td></td></tr>
            <tr>
                <td>
                    <asp:UpdatePanel ID="up_2" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <table style="width: 100%;">
                                <colgroup>
                                    <col style="width: 7em;" />
                                    <col style="width: 11em;" />
                                    <col style="width: 7em;" />
                                    <col style="width: 25em;" />
                                    <col style="width: 7em;" />
                                    <col style="width: 21em;" />
                                    <col />
                                </colgroup>
                                <tr>
                                    <td style="text-align: right; padding-right: 0px;">
                                        会社：
                                    </td>
                                    <td>
                                        <asp:RadioButtonList ID="rbl_会社" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rbl_会社_SelectedIndexChanged">
                                            <asp:ListItem Value="10,31">サンシ&nbsp;&nbsp;</asp:ListItem>
                                            <asp:ListItem Value="80">ベリー&nbsp;&nbsp;</asp:ListItem>
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="rbl_会社_RequiredFieldValidator" runat="server" Display="None" ValidationGroup="ValGrp1"
                                            ErrorMessage="選択してください" ControlToValidate="rbl_会社" SetFocusOnError="true" />
                                        <ajaxToolkit:ValidatorCalloutExtender ID="rbl_会社_RequiredFieldValidator_ValidatorCalloutExtender" PopupPosition="BottomLeft"
                                            runat="server" Enabled="True" TargetControlID="rbl_会社_RequiredFieldValidator" />
                                    </td>
                                    <td style="text-align: right; padding-right: 15px;">
                                        店舗：
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_店舗" runat="server" Width="12em" DataTextField="店舗名" DataValueField="会社店ｺｰﾄﾞ"
                                            AutoPostBack="true" OnSelectedIndexChanged="ddl_店舗_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        &nbsp;
                                        <asp:TextBox ID="tbx_店舗" runat="server" Width="8em" MaxLength="9" />
                                        <ajaxToolkit:FilteredTextBoxExtender ID="tbx_店舗_FilteredTextBoxExtender" runat="server"
                                            TargetControlID="tbx_店舗" FilterType="Numbers" />
                                    </td>
                                    <td style="text-align: right; padding-right: 15px;">
                                        部門：
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_部門" runat="server" Width="12em" DataTextField="部門名" DataValueField="部門ｺｰﾄﾞ"
                                            AutoPostBack="true" OnSelectedIndexChanged="ddl_部門_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        &nbsp;
                                        <asp:TextBox ID="tbx_部門" runat="server" Width="4em" MaxLength="4" />
                                        <ajaxToolkit:FilteredTextBoxExtender ID="tbx_部門_FilteredTextBoxExtender" runat="server"
                                            TargetControlID="tbx_部門" FilterType="Numbers" />
                                    </td>
                                    <td></td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="rbl_会社" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 15px;">
                    <asp:UpdatePanel ID="up_3" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                        <ContentTemplate>
                            <table style="width: 100%;">
                                <colgroup>
                                    <col style="width: 7em;" />
                                    <col style="width: 31em;" />
                                    <col style="width: 7em;" />
                                    <col />
                                    <col style="width: 10em;" />
                                </colgroup>
                                <tr>
                                    <td style="text-align: right; padding-right: 15px;">
                                        仕入先：
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_仕入先" runat="server" Width="23em"
                                            DataTextField="仕入先名" DataValueField="仕入先ｺｰﾄﾞ" AutoPostBack="false">
                                        </asp:DropDownList>
                                        &nbsp;
                                        <asp:TextBox ID="tbx_仕入先" runat="server" Width="4em" MaxLength="4" />
                                        <ajaxToolkit:FilteredTextBoxExtender ID="tbx_仕入先_FilteredTextBoxExtender" runat="server"
                                            TargetControlID="tbx_仕入先" FilterType="Numbers" />
                                    </td>
                                    <td style="text-align: right; padding-right: 15px;">
                                        納品日：
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbx_納品日_from" runat="server" Style="width: 6em;" />
                                        <asp:ImageButton ID="ibtn_納品日_from" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png" AlternateText="click to show calendar" />
                                        <ajaxToolkit:CalendarExtender ID="tbx_納品日_from_CalendarExtender" runat="server" Enabled="True"
                                            Format="yyyy/MM/dd" TargetControlID="tbx_納品日_from" PopupButtonID="ibtn_納品日_from" />
                                        <ajaxToolkit:MaskedEditExtender ID="tbx_納品日_from_MaskedEditExtender" runat="server"
                                            ClearMaskOnLostFocus="False" Enabled="True" MaskType="Date" Mask="9999/99/99" TargetControlID="tbx_納品日_from" />
                                        <asp:CustomValidator id="tbx_納品日_from_CustomValidator" runat="server" ControlToValidate="tbx_納品日_from" ValidationGroup="ValGrp1" Display="None"
                                            ErrorMessage="日付 （1900/01/01 ～）<br />を入力して下さい。" ClientValidationFunction="date_validateInputValue" />
                                        <ajaxToolkit:ValidatorCalloutExtender ID="tbx_納品日_from_CustomValidator_ValidatorCalloutExtender" PopupPosition="BottomLeft"
                                            runat="server" Enabled="True" TargetControlID="tbx_納品日_from_CustomValidator" />
                                        &nbsp;～&nbsp;
                                        <asp:TextBox ID="tbx_納品日_to" runat="server" Style="width: 6em;" />
                                        <asp:ImageButton ID="ibtn_納品日_to" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png" AlternateText="click to show calendar" />
                                        <ajaxToolkit:CalendarExtender ID="tbx_納品日_to_CalendarExtender" runat="server" Enabled="True"
                                            Format="yyyy/MM/dd" TargetControlID="tbx_納品日_to" PopupButtonID="ibtn_納品日_to" />
                                        <ajaxToolkit:MaskedEditExtender ID="tbx_納品日_to_MaskedEditExtender" runat="server"
                                            ClearMaskOnLostFocus="False" Enabled="True" MaskType="Date" Mask="9999/99/99" TargetControlID="tbx_納品日_to" />
                                        <asp:CustomValidator id="tbx_納品日_to_CustomValidator" runat="server" ControlToValidate="tbx_納品日_to" ValidationGroup="ValGrp1" Display="None"
                                            ErrorMessage="日付 （1900/01/01 ～）<br />を入力して下さい。" ClientValidationFunction="date_validateInputValue" />
                                        <ajaxToolkit:ValidatorCalloutExtender ID="tbx_納品日_to_CustomValidator_ValidatorCalloutExtender" PopupPosition="BottomLeft"
                                            runat="server" Enabled="True" TargetControlID="tbx_納品日_to_CustomValidator" />
                                    </td>
                                    <td style="padding-right: 5%; text-align: right;">
                                        <asp:Button ID="btn_Search" runat="server" CssClass="btn01" ValidationGroup="ValGrp1" Text="検 索" OnClick="btn_Search_Click" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="rbl_会社" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="ddl_店舗" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="ddl_部門" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>

        <asp:UpdatePanel ID="up_1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
            <ContentTemplate>
                <div style="margin-top: 5px; background-color: rosybrown; color: Black; border: solid 2px linen; padding: 2px;">
                    <table style="background-color: linen; width: 100%; overflow-wrap: break-word;">
                        <colgroup>
                            <col style="width: 100%;" />
                        </colgroup>
                        <tr>
                            <td>
                                <table id="tbl_02" style="width: 100%;">
                                    <colgroup>
                                        <col style="width: 6em;" />
                                        <col />
                                        <col style="width: 2em;" />
                                    </colgroup>
                                    <tr>
                                        <td style="text-align: right; padding-right: 2em;">条件</td>
                                        <td>
                                            [会社]&nbsp;&nbsp;<asp:Label ID="lbl_会社" runat="server" Text="&nbsp;&nbsp;" />
                                            ,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            [店舗]&nbsp;&nbsp;<asp:Label ID="lbl_店舗" runat="server" Text="&nbsp;&nbsp;" />
                                            ,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            [部門]&nbsp;&nbsp;<asp:Label ID="lbl_部門" runat="server" Text="&nbsp;&nbsp;" />
                                            ,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            [仕入先]&nbsp;&nbsp;<asp:Label ID="lbl_仕入先" runat="server" Text="&nbsp;&nbsp;" />
                                            ,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            [納品日]&nbsp;&nbsp;<asp:Label ID="lbl_納品日_fromTo" runat="server" Text="&nbsp;&nbsp;" />
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 2px;"><td></td></tr>
                        <tr>
                            <td style="background-color: lightgrey;">
                                <asp:Repeater id="rep_1" runat="server" OnItemDataBound="rep_1_ItemDataBound">
                                    <HeaderTemplate>
                                        <div style="overflow-x: hidden; overflow-y: scroll; width: 100%;">
                                            <table style="table-layout: fixed; border-collapse: separate; border-spacing: 1px; width: 100%; background-color: Gray;">
                                                <colgroup>
                                                    <col style="width: 5em;" />
                                                    <col />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                </colgroup>
                                                <tr>
                                                    <th style="padding: 3px; color: Gray; background-color: white; text-align: center;"></th>
                                                    <th style="padding: 3px; color: Gray; background-color: lightgrey; text-align: center;">仕入先名</th>
                                                    <th style="padding: 3px; color: Gray; background-color: lightgrey; text-align: center;">発注点数</th>
                                                    <th style="padding: 3px; color: Gray; background-color: lightgrey; text-align: center;">欠品点数</th>
                                                    <th style="padding: 3px; color: Gray; background-color: lightgrey; text-align: center;">変更点数</th>
                                                    <th style="padding: 3px; color: Gray; background-color: lightgrey; text-align: center;">合計</th>
                                                    <th style="padding: 3px; color: Gray; background-color: lightgrey; text-align: center;">欠品率</th>
                                                    <th style="padding: 3px; color: Gray; background-color: lightgrey; text-align: center;">変更率</th>
                                                    <th style="padding: 3px; color: Gray; background-color: lightgrey; text-align: center;">率合計</th>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="div_List" style="height: 0; overflow-x: hidden; overflow-y: scroll; width: 100%;">
                                            <table style="table-layout: fixed; border-collapse: separate; border-spacing: 0; width: 100%; background-color: Gray;">
                                                <colgroup>
                                                    <col style="width: 5em;" />
                                                    <col />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                    <col style="width: 7em;" />
                                                </colgroup>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                                <tr>
                                                    <td colspan="9" style="padding: 0;">
                                                        <asp:Panel ID="pnl_Item_Header" runat="server" Width="100%">
                                                            <table style="table-layout: fixed; border-collapse: separate; border-spacing: 1px; width: 100%; background-color: Gray;">
                                                                <colgroup style="background-color: white;">
                                                                    <col style="width: 5em;" />
                                                                    <col />
                                                                    <col style="width: 7em;" />
                                                                    <col style="width: 7em;" />
                                                                    <col style="width: 7em;" />
                                                                    <col style="width: 7em;" />
                                                                    <col style="width: 7em;" />
                                                                    <col style="width: 7em;" />
                                                                    <col style="width: 7em;" />
                                                                </colgroup>
                                                                <tbody>
                                                                    <tr runat="server" id="tblRow_1">
                                                                        <td style="background-color: lightsteelblue; text-align: center; font-weight: bold;">
                                                                            <div style="cursor: pointer;">
                                                                                <asp:Label ID="lbl_Item_Header" runat="server" Width="100%"></asp:Label>
                                                                            </div>
                                                                        </td>
                                                                        <td style="text-align: left;">
                                                                            <%# DirectCast(DataBinder.Eval(Container.DataItem, "仕入先名"), String)%>
                                                                        </td>
                                                                        <td style="text-align: right;">
                                                                            <%# DirectCast(DataBinder.Eval(Container.DataItem, "発注点数"), Integer).ToString("#,0")%>
                                                                        </td>
                                                                        <td style="text-align: right;">
                                                                            <%# DirectCast(DataBinder.Eval(Container.DataItem, "欠品点数"), Integer).ToString("#,0")%>
                                                                        </td>
                                                                        <td style="text-align: right;">
                                                                            <%# DirectCast(DataBinder.Eval(Container.DataItem, "変更点数"), Integer).ToString("#,0")%>
                                                                        </td>
                                                                        <td style="text-align: right;">
																			<%# DirectCast(DataBinder.Eval(Container.DataItem, "合計"), Integer).ToString("#,0")%>
                                                                        </td>
                                                                        <td style="text-align: right;">
																			<%# DirectCast(DataBinder.Eval(Container.DataItem, "欠品率"), Decimal).ToString("0.00")%>
                                                                        </td>
                                                                        <td style="text-align: right;">
																			<%# DirectCast(DataBinder.Eval(Container.DataItem, "変更率"), Decimal).ToString("0.00")%>
                                                                        </td>
                                                                        <td style="text-align: right;">
																			<%# DirectCast(DataBinder.Eval(Container.DataItem, "率合計"), Decimal).ToString("0.00")%>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </asp:Panel>
                                                        <asp:Panel ID="pnl_Item_Detail" runat="server" Width="98%" Height="0px" Style="background-color: lavender; padding: 10px 1%;">
                                                            <asp:Repeater ID="rep_2" runat="server" ClientIDMode="Predictable">
                                                                <HeaderTemplate>
                                                                    <table style="table-layout: fixed; border-collapse: separate; border-spacing: 1px; width: 100%; background-color: Gray;">
                                                                        <colgroup>
                                                                            <col style="width: 3em;" />
                                                                            <col style="width: 7em;" />
                                                                            <col style="width: 12em;" />
                                                                            <col />
                                                                            <col style="width: 10em;" />
                                                                            <col style="width: 7em;" />
                                                                            <col style="width: 10em;" />
                                                                            <col style="width: 7em;" />
                                                                            <col style="width: 7em;" />
                                                                        </colgroup>
                                                                        <tr>
                                                                            <th style="padding: 3px; color: white; background-color: darkgray; text-align: center;">区分</th>
                                                                            <th style="padding: 3px; color: white; background-color: darkgray; text-align: center;">部門コード</th>
                                                                            <th style="padding: 3px; color: white; background-color: darkgray; text-align: center;">JANコード</th>
                                                                            <th style="padding: 3px; color: white; background-color: darkgray; text-align: center;">商品名</th>
                                                                            <th style="padding: 3px; color: white; background-color: darkgray; text-align: center;">店舗名</th>
                                                                            <th style="padding: 3px; color: white; background-color: darkgray; text-align: center;">発注日</th>
                                                                            <th style="padding: 3px; color: white; background-color: darkgray; text-align: center;">伝票番号</th>
                                                                            <th style="padding: 3px; color: white; background-color: darkgray; text-align: center;">発注数</th>
                                                                            <th style="padding: 3px; color: white; background-color: darkgray; text-align: center;">変更数</th>
                                                                        </tr>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                        <tr>
                                                                            <td style="text-align: center; color: dimgray; background-color: white;">
                                                                                <%# DirectCast(DataBinder.Eval(Container.DataItem, "区分"), String)%>
                                                                            </td>
                                                                            <td style="text-align: center; color: dimgray; background-color: white;">
                                                                                <%# DirectCast(DataBinder.Eval(Container.DataItem, "部門ｺｰﾄﾞ"), Short).ToString("d")%>
                                                                            </td>
                                                                            <td style="text-align: center; color: dimgray; background-color: white;">
                                                                                <%# CLng(DataBinder.Eval(Container.DataItem, "JANｺｰﾄﾞ")).ToString("d")%>
                                                                            </td>
                                                                            <td style="text-align: left; color: dimgray; background-color: white;">
                                                                                <%# DirectCast(DataBinder.Eval(Container.DataItem, "商品名"), String)%>
                                                                            </td>
                                                                            <td style="text-align: left; color: dimgray; background-color: white;">
                                                                                <%# DirectCast(DataBinder.Eval(Container.DataItem, "店舗名"), String)%>
                                                                            </td>
                                                                            <td style="text-align: center; color: dimgray; background-color: white;">
                                                                                <%# DirectCast(DataBinder.Eval(Container.DataItem, "発注日"), DateTime).ToString("yyyy/MM/dd")%>
                                                                            </td>
                                                                            <td style="text-align: center; color: dimgray; background-color: white;">
                                                                                <%# CLng(DataBinder.Eval(Container.DataItem, "伝票番号")).ToString("d")%>
                                                                            </td>
                                                                            <td style="text-align: right; color: dimgray; background-color: white;">
                                                                                <%# DirectCast(DataBinder.Eval(Container.DataItem, "発注ﾊﾞﾗ数"), Decimal).ToString("#,0.0")%>
                                                                            </td>
                                                                            <td style="text-align: right; color: dimgray; background-color: white;">
                                                                                <%# DirectCast(DataBinder.Eval(Container.DataItem, "納品ﾊﾞﾗ数"), Decimal).ToString("#,0.0")%>
                                                                            </td>
                                                                        </tr>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    </table>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </asp:Panel>
                                                        <ajaxToolkit:CollapsiblePanelExtender ID="cpe_Item" runat="server" Enabled="True"
                                                            TargetControlID="pnl_Item_Detail" ExpandControlID="lbl_Item_Header" CollapseControlID="lbl_Item_Header" 
                                                            Collapsed="true" CollapsedText="（開く）" ExpandedText="（閉る）" TextLabelID="lbl_Item_Header">
                                                        </ajaxToolkit:CollapsiblePanelExtender>
                                                    </td>
                                                </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                            </table>
                                        </div>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center;">
                                <div style="position: relative; width: 100%;">
                                    <div style="position: absolute; left: 50%; top: 1em; margin-left: -10em; width: 20em; background-color: palegoldenrod; border: 1px solid Gray;">
                                        <uc1:ListPager ID="uc_ListPager_Item" runat="server" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btn_Search" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="uc_ListPager_Item" />
            </Triggers>
        </asp:UpdatePanel>
    </form>
    
    <script type="text/javascript">
    <!--
        var mng;
        function pageLoad() {
            mng = Sys.WebForms.PageRequestManager.getInstance();

            mng.remove_initializeRequest(initializeRequest_mng);
            mng.add_initializeRequest(initializeRequest_mng);

            mng.remove_endRequest(endRequest_mng);
            mng.add_endRequest(endRequest_mng);

			adjust_divListHeight();

            $('<% = "#" + Me.ddl_店舗.ClientID %>').off('change.goodsShortage');
            $('<% = "#" + Me.ddl_店舗.ClientID %>').on('change.goodsShortage', 
                function(event){
                    $('<% = "#" + Me.tbx_店舗.ClientID %>').val($(this).val());
                });
            $('<% = "#" + Me.tbx_店舗.ClientID %>').off('change.goodsShortage');
            $('<% = "#" + Me.tbx_店舗.ClientID %>').on('change.goodsShortage', 
				function (event) {
					const ele = $('<% = "#" + Me.ddl_店舗.ClientID %>');
					ele.val($(this).val());
					if (ele.prop("selectedIndex") < 0) {
						$(this).val("0");
						ele.val("0");
					}
					eval(ele[0].onchange)();

					var prm = Sys.WebForms.PageRequestManager.getInstance();
					var en = '<% = "#" + Me.btn_dummy.ClientID %>';

					if (!Array.contains(prm._asyncPostBackControlIDs, en)) {
						prm._asyncPostBackControlIDs.push(en);
					}
					if (!Array.contains(prm._asyncPostBackControlClientIDs, en)) {
						prm._asyncPostBackControlClientIDs.push(en);
					}

					var ps = "<% = GetPostBackScript() %>";
					eval(ps.replace('{0}', en).replace('{1}', 'tbx_店舗_Changed'));
                });

			$('<% = "#" + Me.ddl_部門.ClientID %>').off('change.goodsShortage');
			$('<% = "#" + Me.ddl_部門.ClientID %>').on('change.goodsShortage',
				function (event) {
					$('<% = "#" + Me.tbx_部門.ClientID %>').val($(this).val());
                });
            $('<% = "#" + Me.tbx_部門.ClientID %>').off('change.goodsShortage');
            $('<% = "#" + Me.tbx_部門.ClientID %>').on('change.goodsShortage', 
				function (event) {
					const ele = $('<% = "#" + Me.ddl_部門.ClientID %>');
					ele.val($(this).val());
					if (ele.prop("selectedIndex") < 0) {
						$(this).val("0");
						ele.val("0");
					}

					var prm = Sys.WebForms.PageRequestManager.getInstance();
					var en = '<% = "#" + Me.btn_dummy.ClientID %>';

					if (!Array.contains(prm._asyncPostBackControlIDs, en)) {
						prm._asyncPostBackControlIDs.push(en);
					}
					if (!Array.contains(prm._asyncPostBackControlClientIDs, en)) {
						prm._asyncPostBackControlClientIDs.push(en);
					}

					var ps = "<% = GetPostBackScript() %>";
					eval(ps.replace('{0}', en).replace('{1}', 'tbx_部門_Changed'));
                });

            $('<% = "#" + Me.ddl_仕入先.ClientID %>').off('change.goodsShortage');
            $('<% = "#" + Me.ddl_仕入先.ClientID %>').on('change.goodsShortage', 
                function(event){
                    $('<% = "#" + Me.tbx_仕入先.ClientID %>').val($(this).val());
                });
            $('<% = "#" + Me.tbx_仕入先.ClientID %>').off('change.goodsShortage');
            $('<% = "#" + Me.tbx_仕入先.ClientID %>').on('change.goodsShortage', 
				function (event) {
					const ele = $('<% = "#" + Me.ddl_仕入先.ClientID %>');
					ele.val($(this).val());
					if (ele.prop("selectedIndex") < 0) {
						$(this).val("0");
						ele.val("0");
					}
                });
        }
        function initializeRequest_mng(sender, args) {
            if (mng.get_isInAsyncPostBack()) {
                args.set_cancel(true);

                return;
            }

            $.sanIndicator();
        }
        function endRequest_mng(sender, args) {
            $.sanIndicator.hide();
		}

        function adjust_divListHeight() {
            /*
			var height = document.documentElement.clientHeight - 270;
			if (height < 0) {
				height = 0;
			}

			document.getElementById('div_List').style.height = height + 'px';
            */

			var height = $(window).innerHeight() - $('#tbl_01').outerHeight() - $('#tbl_02').outerHeight() - 120;
			if (height < 0) {
				height = 0;
			}

			var ele = $('#div_List');
			ele.outerHeight(height);
		}

		function date_validateInputValue(oSrc, args) {
			if (args.Value == '____/__/__') {
				args.IsValid = true;

				return;
			}

			args.IsValid = false;

			var dt = new Date(args.Value);
			if (isNaN(dt)) {
				return;
			}

			if (dt.getFullYear() != parseInt(args.Value.substr(0, 4), 10)) {
				return;
			}
			if (dt.getMonth() + 1 != parseInt(args.Value.substr(5, 2), 10)) {
				return;
			}
			if (dt.getDate() != parseInt(args.Value.substr(8, 2), 10)) {
				return;
			}
			if (dt.getFullYear() < 1900) {
				return;
			}

			args.IsValid = true;
		}
    //-->
	</script>
</body>
</html>
