using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TSProject.Startup))]
namespace TSProject
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
