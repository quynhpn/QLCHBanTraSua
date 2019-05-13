using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TSProject.Data;
using PagedList;

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
        public PartialViewResult Search(int page, string categoryName="")
        {
            var query = from c in cnn.Category
                        where c.IsActive.Equals(1) && c.Name.Contains(categoryName)
                        orderby c.Name
                        select c;
            if(query != null && query.Count() > 0)
            {
                return PartialView("_List", query.ToPagedList(page,1));
            }
            else
            {
                return PartialView("_List", new List<Category>().ToPagedList(page, 1));
            }
        }
        public int InsertCategory(string name)
        {
            try
            {
                //Tạp đối tượng
                Category cat = new Category();
                cat.Name = name;
                cat.CreateDate = DateTime.Now;
                cat.IsActive = 1;
                // Lưu vào DB
                cnn.Category.Add(cat);
                cnn.SaveChanges();
                return 1;
            }
            catch
            {
                return 0;
            }
        }
    }
}