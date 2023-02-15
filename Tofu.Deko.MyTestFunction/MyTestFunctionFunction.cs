using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using Tofu.Deko.MyTestFunction.DAL;

namespace Tofu.Deko.MyTestFunction
{
    public class MyTestFunctionFunction
    {
        private readonly IMyTestFunctionRepository _repository;
        private readonly ILogger<MyTestFunctionFunction> _logger;

        public MyTestFunctionFunction(IMyTestFunctionRepository repository, ILogger<MyTestFunctionFunction> loggger)
        {
            _repository = repository;
            _logger = loggger;
        }

        [FunctionName("MyTestFunction")]
        [OpenApiOperation("Template operation name", tags: new[] { "name" })]
        [OpenApiParameter("id", In = ParameterLocation.Path, Description = "The **Id** parameter", Required = true)]
        [OpenApiParameter("name", In = ParameterLocation.Query, Description = "The **Name** parameter")]
        [OpenApiResponseWithBody(HttpStatusCode.OK, "application/json", typeof(string), Description = "The OK response")]
        [OpenApiResponseWithoutBody(HttpStatusCode.BadRequest, Description = "The BadRequest 400 response")]
        [OpenApiResponseWithoutBody(HttpStatusCode.NotFound, Description = "The NotFound 404 response")]
        [OpenApiResponseWithoutBody(HttpStatusCode.InternalServerError, Summary = "Internal server error", Description = "Internal server error occured")]
        public async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "MyTestFunction/{id}")] HttpRequest req, int id)
        {
           var res = new FuncReq
            {
                Id = id.ToString(),
                Message = $"Hello from me. You sent me Id: {id}"
            };

            return await Task.FromResult(new OkObjectResult(res));
        }
    }
}
