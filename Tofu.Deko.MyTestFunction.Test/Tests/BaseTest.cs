using AutoFixture;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Moq;
using Tofu.Deko.MyTestFunction.DAL;

namespace Tofu.Deko.MyTestFunction.Test.IntegrationTests
{
    public abstract class BaseTest
    {
        protected readonly Fixture _fixture;
        protected readonly MyTestFunctionFunction _function;

        protected BaseTest()
        {
            var startup = new Startup();
            var host = new HostBuilder()
                .ConfigureWebJobs(startup.Configure)
                .Build();

            _function = new MyTestFunctionFunction(host.Services.GetRequiredService<IMyTestFunctionRepository>(), Mock.Of<ILogger<MyTestFunctionFunction>>());
            _fixture = new Fixture();
        }
    }
}
