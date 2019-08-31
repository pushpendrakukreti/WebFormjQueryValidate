<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="jQueryFormValidation.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/jquery.validate.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
    <style>
        #txtName-error, #ddlGender-error, #txtAge-error, #txtEmail-error,
        #txtConfirm-error {
            color: darkred !important;
            font-size: medium !important;
            float: left !important;
            margin: 1% !important;
        }

        .form-control {
            width: 50% !important;
        }

        label {
            float: right;
            font-size: x-large;
        }

        #radioSkills > tbody > tr > td > label {
            font-size: medium;
        }

        .label {
            width: 40%;
        }

        input[type="text"], input[type="number"] {
            width: 50%;
        }

        #ddlGender {
            width: 50%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="container">
        <table class="table table-bordered table-hover mt-4 table-primary">
            <tr>
                <td colspan="2" class="text-center">
                    <h2>jQuery Validation Form</h2>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <label>Name : </label>
                </td>
                <td>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <label>Gender : </label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0">--Select Gender--</asp:ListItem>
                        <asp:ListItem Value="1">Male</asp:ListItem>
                        <asp:ListItem Value="2">Female</asp:ListItem>
                        <asp:ListItem Value="3">Others</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <label>SKILLS : </label>
                </td>
                <td>
                    <asp:CheckBoxList ID="radioSkills" runat="server" RepeatDirection="horizontal" RepeatColumns="4">
                        <asp:ListItem Value="0">JAVA</asp:ListItem>
                        <asp:ListItem Value="1">.NET</asp:ListItem>
                        <asp:ListItem Value="2">ANGULAR</asp:ListItem>
                        <asp:ListItem Value="3">HTML</asp:ListItem>
                        <asp:ListItem Value="4">CSS</asp:ListItem>
                        <asp:ListItem Value="5">JQUERY</asp:ListItem>
                        <asp:ListItem Value="6">DOCKER</asp:ListItem>
                        <asp:ListItem Value="7">GOLANG</asp:ListItem>
                    </asp:CheckBoxList>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <label>AGE : </label>
                </td>
                <td>
                    <asp:TextBox ID="txtAge" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <label>Email Id : </label>
                </td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" CausesValidation="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <label>Confirm Id : </label>
                </td>
                <td>
                    <asp:TextBox ID="txtConfirm" runat="server" CssClass="form-control" CausesValidation="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <center><asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success"/></center>
                </td>
            </tr>
        </table>
    </form>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnSubmit').on('click', function (e) {
                var sText = $('#ddlGender option:selected').text().toLowerCase();

                $('input[type=checkbox]').on('change', function (e) {
                    if ($('input[type=checkbox]:checked').length > 4) {
                        $(this).prop('checked', false);
                        alert("Allowed Only 4");
                    }
                });

                var checked = $(':checkbox:checked').length;
                if (checked == 0) {
                    alert('Atleast One Skill Should Be Selected');
                    e.preventDefault();
                }
                else if (sText == '--select gender--') {
                    alert('Please select any gender.');
                    e.preventDefault();
                }
                else
                    $("#form1").validate({
                        rules: {
                        <%=txtName.UniqueID%>: {
                            required: true
                        },
                        <%=txtConfirm.UniqueID %>: {
                            required: true,
                            equalTo: "#<%=txtEmail.ClientID %>" // Id of the control to compare.                         
                        },
                        <%=txtEmail.UniqueID %>: {
                            required: true
                        },
                        <%=txtAge.UniqueID %>: {
                            required: true,
                            range: [10, 20],
                        },  
                },
                messages: {
                <%=txtName.UniqueID%>:{
                    required: "Please Fill The Name !!"
                },
                <%=txtEmail.UniqueID %>: {
                    required: "Please Enter a valid Email Id..."
                },
                <%=txtConfirm.UniqueID %>: {
                    equalTo: "Enter Same Email Id."
                },
                <%=txtAge.UniqueID %>: {
                    required: "Fill Your Age ..",
                    range: "Age should be between {0} and {1}"
                },  
            },
            });
            });
        });
    </script>
</body>
</html>
