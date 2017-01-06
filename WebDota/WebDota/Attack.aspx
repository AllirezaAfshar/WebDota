<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Attack.aspx.cs" Inherits="WebDota.Attack" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView runat="server" ID="otherUserGrid"></asp:GridView>
    <br/>
    PlayerId:<asp:TextBox runat="server" ID="txtPlayerId"></asp:TextBox>
    <br/>
    <asp:Button runat="server" ID="btnAttack" Text="Punch Him!" OnClick="btnAttack_Click"/>
    <br/>
    result:<asp:Label runat="server" ID="result"></asp:Label>
</asp:Content>
