<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Items.aspx.cs" Inherits="WebDota.Items" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView runat="server" ID="ItemsGrid"></asp:GridView>
    <br/>
    Item Name:<asp:TextBox runat="server" ID="txtItemName"></asp:TextBox>
    <asp:Button runat="server" Text="Sell" ID="Sell" OnClick="Sell_Click"/>
    <asp:Button runat="server" Text="Buy" ID="Buy" OnClick="Buy_Click"/>
</asp:Content>
