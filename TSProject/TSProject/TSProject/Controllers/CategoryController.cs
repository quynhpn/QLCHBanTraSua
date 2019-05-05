using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TSProject.Data;

namespace TSProject.Controllers
{
    public class CategoryController : Controller
    {
        // GET: Category
        Connect cnn = new Connect();
        public ActionResult Index()
        {
            var query = from c in cnn.Category
                        where c.IsActive.Equals(1)
                        select c;
            if(query!=null && query.Count() > 0)
            {
                return View(query.ToList());
            }
            return View();
        }
    }
}