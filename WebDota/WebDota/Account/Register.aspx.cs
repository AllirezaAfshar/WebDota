using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using WebDota.Models;
using WebDota.Domain;

namespace WebDota.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            try
            {
                SqlHelper.Run(string.Format(""));
            }
            catch (Exception exp)
            {
                ErrorMessage.Text = exp.Message;

            }

        }
    }
}