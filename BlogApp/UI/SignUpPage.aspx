<%@ Page Title="Sign Up " Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="SignUpPage.aspx.cs" Inherits="BlogApp.UI.SignUpPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <div id="site_title">
        <h1><a href="#" target="_parent"><strong>Code Figher Blog</strong><span>Coding is the best way to learn Coding</span></a></h1>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="post_content" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div id="msg" runat="server" clientidmode="Static"></div>

            <div>


                <table>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Full Name: "></asp:Label>

                        </td>

                        <td>
                            <asp:TextBox ID="signUpFullName" runat="server"></asp:TextBox>
                        </td>
                        <td style="width: 374px; text-align: left;">
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="signUpFullName" ErrorMessage="Enter Full Name" ForeColor="Red" style="text-align: left"></asp:RequiredFieldValidator>
                            
                        </td>

                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Email"></asp:Label>

                        </td>

                        <td>
                            <asp:TextBox ID="signUpEmailTextBox" runat="server" Height="20px"></asp:TextBox>
                        </td>
                         <td style="width: 374px; text-align: left;">
                            
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="signUpEmailTextBox" ErrorMessage="Enter Email " ForeColor="Red"></asp:RequiredFieldValidator>
                             <br />
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="signUpEmailTextBox" ErrorMessage="Enter Valid E-mail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="User Name"></asp:Label>

                        </td>

                        <td>
                            <asp:TextBox ID="userName" runat="server" OnTextChanged="userName_TextChanged"></asp:TextBox>
                        </td>
                         <td style="width: 374px; text-align: left;">
                            
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="userName" ErrorMessage="Enter User Name" ForeColor="Red"></asp:RequiredFieldValidator>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text="Password:"></asp:Label>
                        </td>

                        <td>
                            <asp:TextBox ID="signUpPassword" runat="server" TextMode="Password"></asp:TextBox>
                        </td>
                         <td style="width: 374px; text-align: left;">
                            
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="signUpPassword" ErrorMessage="Enter Password" ForeColor="Red"></asp:RequiredFieldValidator>
                            
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Conform Password: "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="signUpRepeatPassword" runat="server" TextMode="Password"></asp:TextBox>
                        </td>
                         <td style="width: 374px; text-align: left;">
                            
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="signUpRepeatPassword" ErrorMessage="Enter Conform Password" ForeColor="Red"></asp:RequiredFieldValidator>
                             <br />
                             <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="signUpPassword" ControlToValidate="signUpRepeatPassword" ErrorMessage="Both password must be same" ForeColor="Red"></asp:CompareValidator>
                            
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Button ID="signUpSubmitButton" runat="server" Text="Submit" OnClick="signUpSubmitButton_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
