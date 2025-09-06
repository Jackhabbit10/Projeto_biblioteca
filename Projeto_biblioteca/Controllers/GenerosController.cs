using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Projeto_biblioteca.Data;
using Projeto_biblioteca.Models;

namespace Projeto_biblioteca.Controllers
{
    public class GenerosController : Controller
    {
        private readonly Database db = new Database();

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult CriarGenero()
        {
            return View();
        }
        [HttpPost]
        public IActionResult CriarGenero(Generos vm)
        {
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_genero_criar", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("p_nome", vm.nome);
            cmd.ExecuteNonQuery();

            return RedirectToAction("CriarGenero");
        }

    }
}
