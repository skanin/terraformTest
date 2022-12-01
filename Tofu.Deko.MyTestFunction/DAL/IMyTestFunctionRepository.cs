using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tofu.Deko.MyTestFunction.DAL
{
    public interface IMyTestFunctionRepository
    {
        Task<string> HelloWorld();
    }
}
