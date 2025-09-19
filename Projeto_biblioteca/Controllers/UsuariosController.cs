﻿using BCrypt.Net;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Projeto_biblioteca.Data;
using Projeto_biblioteca.Models;
namespace Projeto_biblioteca.Controllers
{
    public class UsuariosController : Controller
    {
        private readonly Database db = new Database();

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult CriarUsuario()
        {
            return View();
        }
        [HttpPost]
        public IActionResult CriarUsuario(Usuarios vm)
        {
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_usuario_criar", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            var senhaHash = BCrypt.Net.BCrypt.HashPassword(vm.senha_hash, workFactor: 12);

            cmd.Parameters.AddWithValue("p_nome", vm.nome);
            cmd.Parameters.AddWithValue("p_email", vm.email);
            cmd.Parameters.AddWithValue("p_senha_hash", senhaHash);
            cmd.Parameters.AddWithValue("p_role", vm.role);
            cmd.ExecuteNonQuery();

            return RedirectToAction("CriarUsuario");
        }
    }
}
