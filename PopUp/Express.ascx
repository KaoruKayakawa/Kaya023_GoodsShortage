<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Express.ascx.vb" Inherits="Kaya023_GoodsShortage.Express" %>

<%@ Import Namespace="Web2_CsvToDb" %>

<script type="text/javascript">
<!--
    function show_modalPopupExpress(p_cap, p_msg) {
		$('<%= "#" + pnl_00.ClientID %>').css('width', '<%= Integer.Parse(Const_App.PopUp.Default_Width_PopUp) %>' + 'px');
        $('<%= "#" + div_caption.ClientID %>').text(p_cap);

        let msg = '<%= Const_App.PopUp.Layout_Message %>';
		msg = msg.replace('{0:D}', '<%= Integer.Parse(Const_App.PopUp.Default_Width_Msg) %>');
		msg = msg.replace('{1}', '<%= Const_App.PopUp.Default_TextAlign_Msg %>');
        msg = msg.replace('{2}', p_msg);

		$('<%= "#" + div_message.ClientID %>').html(msg);

		var modalPopupBehavior = $find('<%= ModalPopupExtender1.ClientID %>');
		modalPopupBehavior.show();
    }

    function onOk_Express()
    {
        var modalPopupBehavior = $find('<%= ModalPopupExtender1.ClientID %>');
        modalPopupBehavior.hide();
    }
//-->
</script>

<asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>

<asp:Panel ID="pnl_00" runat="server" Style="display: none;" CssClass="modalPopup">
    <asp:Panel ID="pnl_01" runat="server" Style="width: 100%; background-color: #FFCFAF; border: solid 1px Gray; color: Black; cursor: pointer;">
        <div style="text-align: center; padding: 2px 0px;">
            <div id="div_caption" runat="server"></div>
        </div>
    </asp:Panel>
    
    <div id="div_message" runat="server"></div>
    
    <table style="width: 100%;">
        <colgroup>
            <col style="width: 100%;" />
        </colgroup>
        <tr style="height: 10px;"><td></td></tr>
        <tr>
            <td style="text-align: center;">
                <asp:Button ID="btn_OK" runat="server" CausesValidation="false" Text="OK" Style="cursor: pointer;" />
            </td>
        </tr>
    </table>
</asp:Panel>

<ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
    TargetControlID="hdn_dummyTarget"
    PopupControlID="pnl_00" 
    BackgroundCssClass="modalBackground"
    OkControlID=""
    OnOkScript="" 
    CancelControlID="btn_OK"
    DropShadow="true"
    PopupDragHandleControlID="pnl_01" />
    
<asp:HiddenField ID="hdn_dummyTarget" runat="server" />
