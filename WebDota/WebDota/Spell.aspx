<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Spell.aspx.cs" Inherits="WebDota.Spell" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView runat="server" ID="otherUserGrid"></asp:GridView>
    <br/>
    <asp:GridView runat="server" ID="SpellGrid"></asp:GridView>
    <br/>
    PlayerId:<asp:TextBox runat="server" ID="txtPlayerId"></asp:TextBox>
    <br/>
    Spell Name:<asp:TextBox runat="server" ID="txtSpellId"></asp:TextBox>

    <br/>
    <asp:Button runat="server" ID="btnSpell" Text="Cast" OnClick="btnSpell_Click" />
    <br/>
    result:<asp:Label runat="server" ID="result"></asp:Label>
</asp:Content>
