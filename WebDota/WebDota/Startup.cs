using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WebDota.Startup))]
namespace WebDota
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
