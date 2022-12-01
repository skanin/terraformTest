using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using Tofu.Deko.MyTestFunction.DAL;
using Tofu.Deko.MyTestFunction.Helpers.Options;

[assembly: FunctionsStartup(typeof(Tofu.Deko.MyTestFunction.Startup))]
namespace Tofu.Deko.MyTestFunction
{
    public class Startup : FunctionsStartup
    {
        public override void Configure(IFunctionsHostBuilder builder)
        {
            var configuration = BuildConfiguration();
            builder.Services.AddAppConfiguration(configuration);
            //Add your injections here
            builder.Services.AddScoped<IMyTestFunctionRepository, MyTestFunctionRepository>();
        }

        private IConfiguration BuildConfiguration()
        {
            var config =
                new ConfigurationBuilder()
                    .SetBasePath(Environment.CurrentDirectory)
                    .AddJsonFile("local.settings.json", optional: true, reloadOnChange: true)
                    .AddJsonFile("settings.json", optional: true, reloadOnChange: true)
                    .AddEnvironmentVariables()
                    .Build();

            return config;
        }
    }
}
