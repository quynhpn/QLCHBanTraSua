using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TSProject.Data;
using PagedList;

namespace TSProject.Controllers
{
    public class ProductController : Controller
    {
        // GET: Product
        Connect cnn = new Connect();
        public ActionResult Index()
        {
            var query = from p in cnn.Product
                        where p.IsActive.Equals(1)
                        select p;
            if(query !=null && query.Count() > 0)
            {
                return View(query.ToList());
            }
            return View();
        }

        public PartialViewResult Search(int page, string productName ="")
        {
            var query = from p in cnn.Product
                        where p.IsActive.Equals(1) && p.Name.Contains(productName)
                        orderby p.Name
                        select p;
            if(query !=null && query.Count() > 0)
            {
                return PartialView("_List", query.ToPagedList(page, 10));
            }
            else
            {
                return PartialView("_List", new List<Product>().ToPagedList(page, 10));
            }
        }
    }
}