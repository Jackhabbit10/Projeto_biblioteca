using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Projeto_biblioteca.Data;
using Projeto_biblioteca.Models;

namespace Projeto_biblioteca.Controllers
{
    public class EditorasController : Controller
    {

        private readonly Database db = new Database();

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult CriarEditora()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CriarEditora(Editora vm)
        {
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_editora_criar", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("p_nome", vm.nome);
            cmd.ExecuteNonQuery();

            return RedirectToAction("CriarEditora");
        }

    }
}
