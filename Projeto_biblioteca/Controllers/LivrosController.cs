using Microsoft.AspNetCore.Mvc;

namespace Projeto_biblioteca.Controllers
{
    public class LivrosController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

    }
}
