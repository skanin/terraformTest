using Microsoft.Extensions.Options;
using System;
using System.Threading.Tasks;
using Tofu.Deko.MyTestFunction.Helpers.Options;

namespace Tofu.Deko.MyTestFunction.DAL
{
    internal class MyTestFunctionRepository : IMyTestFunctionRepository
    {
        private readonly FunctionOptions _functionOptions;

        public MyTestFunctionRepository(IOptions<FunctionOptions> functionOptions)
        {
            _functionOptions = functionOptions?.Value ?? throw new ArgumentNullException(nameof(functionOptions));
        }

        public Task<string> HelloWorld()
        {
            return Task.FromResult(_functionOptions.Message);
        }
    }
}
