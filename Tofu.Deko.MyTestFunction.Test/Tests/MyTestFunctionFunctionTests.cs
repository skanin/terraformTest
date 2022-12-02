using AutoFixture;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Internal;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using Xunit;

namespace Tofu.Deko.MyTestFunction.Test.IntegrationTests
{
    public class MyTestFunctionFunctionTests : BaseTest
    {
        [Fact]
        public async Task ShouldReturn200AndValidResultWhenSucceeded()
        {
            var id = _fixture.Create<int>();
            var name = _fixture.Create<string>();
            var request = new DefaultHttpRequest(new DefaultHttpContext());
            request.QueryString = new QueryString($"?name={name}");

            var response = await _function.Run(request, id);

            var result = Assert.IsType<OkObjectResult>(response);
            Assert.Equal((int)HttpStatusCode.OK, result.StatusCode);
            Assert.Equal($"Hello World! AzureFunction response. Id: {id}, Name: {name}\nTester dette! Tester igjen.", result.Value.ToString());
        }
    }
}
