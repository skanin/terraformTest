using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Tofu.Deko.MyTestFunction.Helpers.Options
{
    internal static class ConfigurationServiceCollectionExtensions
    {
        public static IServiceCollection AddAppConfiguration(this IServiceCollection services, IConfiguration config)
        {
            services.Configure<FunctionOptions>(config.GetSection(nameof(FunctionOptions)));
            return services;
        }
    }
}
